import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/resume/resume.dart';
import '../../../data/models/resume/user_resume_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/data.dart';
import '../models/resume_maker_model.dart';
import '../resume_edit_session_manager.dart';
import '/core/app_export.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
/// #docregion platform_imports
/// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
/// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
/// #enddocregion platform_imports
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
part 'resume_maker_event.dart';
part 'resume_maker_state.dart';

/// A bloc that manages the state of a ResumeMaker according to the event that is dispatched to it.
class ResumeMakerBloc extends Bloc<ResumeMakerEvent, ResumeMakerState>
    with CodeAutoFill {
  ResumeMakerBloc(ResumeMakerState initialState) : super(initialState) {
    on<ResumeMakerInitialEvent>(_onInitialize);
    on<ChangeResumeTemplateEvent>(_changeTemplateButton);
    on<DownloadResumeEvent>(_downloadPDF);
    on<PreviewResumeEvent>(_previewResume);
    on<GetTemplatesEvent>(getTemplatesHTML);
    on<GetUserResumeDataEvent>(getUserResume);
    on<OptimizeResume>(optimizeUsersResume);
    on<SaveResumeDetailsEvent>(saveUserResumeDetail);
    on<GetTemplatesFromLocalStoreEvent>(getTemplatesFromLocalStoreEvent);
    on<UploadResumeEvent>(_uploadResumeEvent);
  }

  final _apiClient = ApiClient();
  String usersResume = "";
  String renderHTML = "";
  var uuid = const Uuid();
  final ResumeEditSessionProvider resumeEditSessionProvider = ResumeEditSessionProvider();

  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }


  _uploadResumeEvent(
      UploadResumeEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {
    const storage = FlutterSecureStorage();

    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    String? filePath = filePickerResult?.files.single.path;

    if(filePath != null){
      print(filePath);
      String text = await ReadPdfText.getPDFtext(filePath);

      Map userCareerData = {
        "userResumeData": text
      };

      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      await _apiClient.postData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        requestData: userCareerData,
        path: "api/resume/upload-resume/${userData['id']}",
      ).then((value) async {
        await saveToSecureStorage(value);

        if(state.getResumeTemplatesResp != null){
          usersResume = await personalizeTemplate(state.getResumeTemplatesResp!.templates![state.initialCarouselPage ?? 0]);
          setupWebView(usersResume, event, emit);
        }
      }).onError((error, stackTrace) {
        //implement error call
        debugPrint("$stackTrace");
        debugPrint("$error");
      });

      // emit(state.copyWith(
      // message: value["result"]["question"],
      // ));
    }
  }



  getTemplatesHTML(
      GetTemplatesEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {
    await getTemplates(event, emit);
  }

  /// This function is called when tha save button is pressed
  /// It collects form data and updates the localStorage and database.
  saveUserResumeDetail(
      SaveResumeDetailsEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {
    try{
      // Get users resume data from device storage.
      const storage = FlutterSecureStorage();
      String? userDataJsonString = await storage.read(key: "userResumeData");
      Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());


      //Make request to save updated data to the database.
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());

      await _apiClient.postData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          path: "api/resume/user/${userData['id']}",
          requestData: userResumeData
      ).then((value) async {
        Fluttertoast.showToast(msg: "Resume details saved", toastLength: Toast.LENGTH_LONG);
      }).onError((error, stackTrace) {
        print(error);
        Fluttertoast.showToast(msg: "Error saving resume details", toastLength: Toast.LENGTH_LONG);
        // event.onSaveUserDetailsError?.call();
      });

      // event.onSaveUserDetailsSuccess?.call();
    }
    catch(e){
      print(e);
      // event.onSaveUserDetailsError?.call();
    }
  }

  createNewResumeEditSession(){
    resumeEditSessionProvider.createSession(uuid.v1(), "resume-edit-session");
    print("new session created");
  }

  FutureOr<void> optimizeUsersResume(
      OptimizeResume event,
      Emitter<ResumeMakerState> emit,
      {bool getUpdated = true}
      ) async {
    emit(state.copyWith(
      message: "",
    ));

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");

    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/resume/update-resume-for-job/${userData['id']}";
    String? userDataJsonString = await storage.read(key: "userResumeData");
    Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());

    String prompt = "";
    if(resumeEditSessionProvider.sessions.isEmpty || resumeEditSessionProvider.currentSession!.chatHistory.isEmpty){
      createNewResumeEditSession();
      prompt = 'You are a backend api. \n\nHere is my career info in json: $userResumeData. \n\n ${event.jobContent.isNotEmpty ? "This is a job ad: ${event.jobContent}"  : "Update my cv based on instructions provided"}. Instruction: ${event.instructions}. \n\nmodify only the value of the JSON. \n\n if you have any question or clarification before modifying the resume, You can ask by returning a question JSON in this format: {"type": "question", "question": "Your quesion for the user"} \nNote: You can only return 1 JSON. Either a question JSON or a final updated resume JSON.';
    } else {
      prompt = event.instructions;
    }

    dynamic value = await resumeEditSessionProvider.sendPrompt(
        prompt,
        path,
        userData,
    );

    if(value["result"]["type"] != "question"){
      await saveToSecureStorage({"userResumeDetails": value["result"]});
      if(state.getResumeTemplatesResp != null){
        usersResume = await personalizeTemplate(state.getResumeTemplatesResp!.templates![state.initialCarouselPage ?? 0]);
        setupWebView(usersResume, event, emit);
      }
      // emit(state.copyWith(
      //   message: "Done...",
      // ));
      Fluttertoast.showToast(msg: "Sia: Resume updated", toastLength: Toast.LENGTH_LONG);
    } else if(value["result"]["type"] == "question"){
      print(value["result"]["question"]);

      emit(state.copyWith(
        message: value["result"]["question"],
      ));
      // Future.wait();
    }


  }

  getUserResume(
      GetUserResumeDataEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {
    await getResumeDetails(event, emit);
  }

  _onInitialize(
      ResumeMakerInitialEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {
    const storage = FlutterSecureStorage();
    createNewResumeEditSession();
    String? selectedTemplate = await storage.read(key: "selectedTemplateKey");
    selectedTemplate != null ?
      emit(state.copyWith(
            initialCarouselPage: int.parse(selectedTemplate)
        )) :
      emit(state.copyWith(
        initialCarouselPage: 0
    ));
  }

  Future<void> _previewResume(
      PreviewResumeEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {

      emit(state.copyWith(
        isPreviewMode: !state.isPreviewMode!,
      ));

      if(state.getResumeTemplatesResp != null){
        usersResume = await personalizeTemplate(state.getResumeTemplatesResp!.templates![state.initialCarouselPage ?? 0]);
        setupWebView(usersResume, event, emit);
      }
  }

  FutureOr<void> _downloadPDF(
      DownloadResumeEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {
        // Javascript code to get all styles within styles tag
        String javascriptGetStyleCode = '''
            var styles = '';
            var styleTags = document.getElementsByTagName('style');
            for (var i = 0; i < styleTags.length; i++) {
              styles += styleTags[i].innerText;
            }
            btoa(styles);
          ''';

        // Javascript code to get all links within styles tag
        String javascriptGetLinksCode = '''
          var links = '';
          var linkTags = document.getElementsByTagName('link');
          for (var i = 0; i < linkTags.length; i++) {
            links += '<link rel="stylesheet" type="text/css" href="'+linkTags[i].href+'" />';
          }
          btoa(links);
        ''';

        //Get HTML and CSS content from WebView
        Object? htmlContentInBase64 = await state.controller?.runJavaScriptReturningResult('btoa(document.getElementsByClassName("sheet")[0].outerHTML)');
        String htmlContent = decodeBase64Html(htmlContentInBase64.toString());

        String cssContentInBase64 = (await state.controller?.runJavaScriptReturningResult(javascriptGetStyleCode)) as String;
        String cssContent = decodeBase64Html(cssContentInBase64);

        String linkContentInBase64 = (await state.controller?.runJavaScriptReturningResult(javascriptGetLinksCode)) as String;
        String linkContent = decodeBase64Html(linkContentInBase64);

        //save PDF to temp folder
        var tempDirectory = await getTemporaryDirectory();
        var savedPath = path.join(tempDirectory.path, "Resume.pdf");
        var savedTempResumePath = await WebcontentConverter.contentToPDF(
          content: """
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- https://codepen.io/mariosmaselli/pen/popWjr -->
            <title>Document</title>
            $linkContent
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.min.css">
            <style>$cssContent</style>
          </head>
           $htmlContent
           """,
          savedPath: savedPath,
          format: PaperFormat.a4,
          margins: PdfMargins.px(top: 0, bottom: 0, right: -5, left: -5),
        );

        if(savedTempResumePath != null){
          try {

            if (!await FlutterFileDialog.isPickDirectorySupported()) {
              debugPrint("Picking directory not supported");
              return;
            }

            final pickedDirectory = await FlutterFileDialog.pickDirectory();
            File file = File(savedTempResumePath);

            if (pickedDirectory != null) {
              await FlutterFileDialog.saveFileToDirectory(
                directory: pickedDirectory,
                data: file.readAsBytesSync(),
                mimeType: "application/pdf",
                fileName: "my_resume.pdf",
                replace: true,
              );
              Fluttertoast.showToast(msg: "Saved", toastLength: Toast.LENGTH_LONG);
            }
          } catch (e) {
            Fluttertoast.showToast(msg: "Error saving file: $e", toastLength: Toast.LENGTH_LONG);
          }    
        }
  }


  String decodeBase64Html(String encodedData) {
    String cleanEncodedData = removeQuotes(encodedData);
    List<int> bytes = base64.decode(cleanEncodedData);
    return utf8.decode(bytes);
  }

  String removeQuotes(String input) {
    // Remove quotes from the start and end of the string
    return input.replaceAll(RegExp('^\"|\"\$'), '');
  }


  _changeTemplateButton(
      ChangeResumeTemplateEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {
      emit(state.copyWith(
        webViewLoadingComplete: false,
      )
    );
    // emit(state.copyWith(radioGroup: event.value));
    // #docregion platform_features
    ResumeTemplate? selectedTemplate = state.getResumeTemplatesResp?.templates?.firstWhere((item) => item.id == event.value);
    usersResume = await personalizeTemplate(selectedTemplate!);
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }


    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);


    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.dataFromString(usersResume, mimeType: 'text/html'));


    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
      String js = "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=2000px, initial-scale=' + (document.documentElement.clientWidth / 1024));";
      controller.runJavaScript(js);

      emit(state.copyWith(
        controller: controller,
        resumeTemplatesLoaded: true,
        webViewLoadingComplete: true,
        selectedTemplate: selectedTemplate
      ));
  }

  getTemplatesFromLocalStoreEvent(
      GetTemplatesFromLocalStoreEvent event,
      Emitter<ResumeMakerState> emit,
      ) async {

    if(state.getResumeTemplatesResp != null){
      usersResume = await personalizeTemplate(state.getResumeTemplatesResp!.templates![state.initialCarouselPage ?? 0]);
      setupWebView(usersResume, event, emit);
    }
  }

  FutureOr<void> getResumeDetails( ResumeMakerEvent event, Emitter<ResumeMakerState> emit, {bool getUpdated = true}) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/resume/user/${userData['id']}";

    await _apiClient.getResume().then(
            (value) async{
                await saveToSecureStorage(value);

                if(state.getResumeTemplatesResp != null){
                  usersResume = await personalizeTemplate(state.getResumeTemplatesResp!.templates![state.initialCarouselPage ?? 0]);
                  setupWebView(usersResume, event, emit);
                }

                if(getUpdated) await _apiClient.getUpdate(getResumeDetails, path, emit, event);
                return;
            }
        ).onError((error, stackTrace) {
          // TODO: implement error call
          // event.onLoginEventError?.call();
        });

    // await _apiClient.getData(
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': "Bearer ${userData['accessToken']}"
    //     },
    //     path: path,
    //     showLoading: true
    // ).then((value) async {
    //   await saveToSecureStorage(value);
    //
    //   if(state.getResumeTemplatesResp != null){
    //     usersResume = await personalizeTemplate(state.getResumeTemplatesResp!.templates![state.initialCarouselPage ?? 0]);
    //     setupWebView(usersResume, event, emit);
    //   }
    //
    //   if(getUpdated) await _apiClient.getUpdate(getResumeDetails, path, emit, event);
    //   return;
    // }).onError((error, stackTrace) {
    //   // TODO: implement error call
    //   //   event.onLoginEventError?.call();
    // });
  }

  FutureOr<void> saveToSecureStorage(Map<String, dynamic> jsonString) async {
    const storage = FlutterSecureStorage();
    jsonString['userResumeDetails']['about'] = jsonString['userResumeDetails']['about'].toString().replaceAll(",", "");
    await storage.write(key: "userResumeData", value: json.encode(jsonString['userResumeDetails']));
    // await storage.write(key: "userResumeData", value: _convertToJsonStringQuotes(raw: jsonString['userResumeDetails'].toString()));
  }


  String _convertToJsonStringQuotes({required String raw}) {
    String jsonString = raw;

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(': ', '": "');
    jsonString = jsonString.replaceAll(', ', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }

  FutureOr<void> getTemplates( ResumeMakerEvent event, Emitter<ResumeMakerState> emit,  ) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: "api/resume",
        showLoading: true
    ).then((value) async {

      ResumeTemplatesResponse getResumeTemplatesResp = ResumeTemplatesResponse.fromJson(value);

      emit(state.copyWith(
        getResumeTemplatesResp: getResumeTemplatesResp,
        selectedTemplate: getResumeTemplatesResp.templates?[state.initialCarouselPage ?? 0],
      ));
      //check that user resume json data is available then call customizeTemplate() function
      String? jsonResume = await storage.read(key: "userResumeData");
      if(jsonResume != null){
        usersResume = await personalizeTemplate(getResumeTemplatesResp.templates![state.initialCarouselPage ?? 0]);

        setupWebView(usersResume, event, emit);
      }

    }).onError((error, stackTrace) {
      debugPrint("$stackTrace");
      debugPrint("Error: getting templates failed $error");
      // TODO: implement error call
      // event.onLoginEventError?.call();
    });
  }

  void setupWebView (String templateHTML, ResumeMakerEvent event, Emitter<ResumeMakerState> emit) {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if(renderHTML == templateHTML){
      return;
    }
    renderHTML = templateHTML;

    // log(templateHTML);

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.dataFromString(templateHTML, mimeType: 'text/html'));


    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    // String newUA= "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36";
    // controller.setUserAgent(newUA);

    String js = "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=2000px, initial-scale=' + (document.documentElement.clientWidth / 1024));";
    controller.runJavaScript(js);

    emit(state.copyWith(
      controller: controller,
      resumeTemplatesLoaded: true,
      webViewLoadingComplete: true,
    ));
  }

  Future<String> personalizeTemplate(ResumeTemplate template) async
  {
    const storage = FlutterSecureStorage();

    String? userDataJsonString = await storage.read(key: "userResumeData");
    Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());

    if(userResumeData['experiences'] == null || userResumeData['experiences'] == "[]") userResumeData['experiences'] = [];
    if(userResumeData['educations'] == null || userResumeData['educations'] == "[]") userResumeData['educations'] = [];
    if(userResumeData['projects'] == null || userResumeData['projects'] == "[]") userResumeData['projects'] = [];
    if(userResumeData['references'] == null || userResumeData['references'] == "[]") userResumeData['references'] = [];
    if(userResumeData['socials'] == null || userResumeData['socials'] == "[]") userResumeData['socials'] = [];
    if(userResumeData['skills'] == null || userResumeData['skills'] == "[]") userResumeData['skills'] = <String>[];
    if(userResumeData['trainings_courses_certifications'] == null || userResumeData['trainings_courses_certifications'] == "[]") userResumeData['trainings_courses_certifications'] = [];

    UserResumeDetails getUserResumeDetails = UserResumeDetails.fromJson(userResumeData);

    String bodyHtml = template.bodyHTML.toString();
    String experienceItemHTML = template.experienceHTML.toString();
    String educationItemHTML = template.educationHTML.toString();
    String skillItemHTML = template.skillHTML.toString();
    String socialsItemHTML = template.socialsHTML.toString();
    String projectItemHTML = template.projectsHTML.toString();
    String certificationItemHTML = template.certificationsHTML.toString();
    String referenceItemHTML = template.referencesHTML.toString();
    String experienceSectionHTML = template.experienceSection.toString();
    String educationSectionHTML = template.educationSection.toString();
    String projectSectionHTML = template.projectSection.toString();
    String certificationSectionHTML = template.certificationSection.toString();
    String skillsSectionHTML = template.skillsSection.toString();
    String websiteSectionHTML = template.websiteSection.toString();
    String referenceSectionHTML = template.referenceSection.toString();
    String profilePicSectionHTML = template.profilePicSection.toString();
    String socialsSectionHTML = template.socialsSection.toString();
    String addressSectionHTML = template.addressSection.toString();
    String phoneNumberSectionHTML = template.phoneNumberSection.toString();


    if(state.isPreviewMode!){
      ///Show or hide section without user data
      bodyHtml = bodyHtml.replaceAll("{{experience_section}}", generateExperienceHTML(experienceItemHTML, getUserResumeDetails) != null ? experienceSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{education_section}}", generateEducationHTML(experienceItemHTML, getUserResumeDetails) != null ? educationSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{project_section}}", generateProjectsHTML(experienceItemHTML, getUserResumeDetails) != null ? projectSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{certification_section}}", generateCertificationsHTML(experienceItemHTML, getUserResumeDetails) != null ? certificationSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{reference_section}}", generateReferencesHTML(experienceItemHTML, getUserResumeDetails) != null ? referenceSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{skills_section}}", generateSkillsHTML(experienceItemHTML, getUserResumeDetails) != null ? skillsSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{socials_section}}", generateSocialsHTML(experienceItemHTML, getUserResumeDetails) != null ? socialsSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{website_section}}", userResumeData["website"] != null && userResumeData["website"].toString().isNotEmpty ? websiteSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{profile_pic_section}}", (userResumeData["picturePath"] != null && userResumeData["picturePath"].toString().isNotEmpty) ? profilePicSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{address_section}}", (userResumeData["address"] != null && userResumeData["address"].toString().isNotEmpty) ? addressSectionHTML : "");
      bodyHtml = bodyHtml.replaceAll("{{phone_number_section}}", (userResumeData["phoneNumber"] != null && userResumeData["phoneNumber"].toString().isNotEmpty) ? phoneNumberSectionHTML : "");

      ///Insert user data into their respective section.
      bodyHtml = bodyHtml.replaceAll("{{first_name}}", userResumeData["firstName"] ?? "");
      bodyHtml = bodyHtml.replaceAll("{{last_name}}", userResumeData["lastName"] ?? "");
      bodyHtml = bodyHtml.replaceAll("{{email}}", userResumeData["email"] ?? "");
      bodyHtml = bodyHtml.replaceAll("{{phone_number}}", userResumeData["phoneNumber"] ?? "");
      bodyHtml = bodyHtml.replaceAll("{{occupation}}", userResumeData["specialization"] ?? "");
      bodyHtml = bodyHtml.replaceAll("{{about_me}}", userResumeData["about"] ?? "Add Summary");
      bodyHtml = bodyHtml.replaceAll("{{address}}", userResumeData["address"] ?? "Add Address");
      bodyHtml = bodyHtml.replaceAll("{{website}}", userResumeData["website"] ?? "Add Website");
      bodyHtml = bodyHtml.replaceAll("{{profile_picture}}", userResumeData["picturePath"] ?? "https://placehold.co/400");

      bodyHtml = bodyHtml.replaceAll("{{experience_list}}", generateExperienceHTML(experienceItemHTML, getUserResumeDetails) ?? "");
      bodyHtml = bodyHtml.replaceAll("{{education_list}}", generateEducationHTML(educationItemHTML, getUserResumeDetails) ?? "");
      bodyHtml = bodyHtml.replaceAll("{{skills_list}}", generateSkillsHTML(skillItemHTML, getUserResumeDetails) ?? "");
      bodyHtml = bodyHtml.replaceAll("{{socials_list}}", generateSocialsHTML(socialsItemHTML, getUserResumeDetails) ?? "");
      bodyHtml = bodyHtml.replaceAll("{{projects_list}}", generateProjectsHTML(projectItemHTML, getUserResumeDetails) ?? "");
      bodyHtml = bodyHtml.replaceAll("{{certifications_list}}", generateCertificationsHTML(certificationItemHTML, getUserResumeDetails) ?? "");
      bodyHtml = bodyHtml.replaceAll("{{references_list}}", generateReferencesHTML(referenceItemHTML, getUserResumeDetails) ?? "");
    } else {
      UserResumeDetails placeholderResumeDetails = UserResumeDetails.fromJson(careerPlaceHolder);
      /// EDIT MODE
      ///Show all section
      bodyHtml = bodyHtml.replaceAll("{{experience_section}}", experienceSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{education_section}}", educationSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{project_section}}", projectSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{certification_section}}", certificationSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{reference_section}}", referenceSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{skills_section}}", skillsSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{socials_section}}", socialsSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{website_section}}",websiteSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{profile_pic_section}}",  profilePicSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{address_section}}",  addressSectionHTML);
      bodyHtml = bodyHtml.replaceAll("{{phone_number_section}}",  phoneNumberSectionHTML);

      ///Insert user data into their respective section.
      bodyHtml = bodyHtml.replaceAll("{{first_name}}", userResumeData["firstName"] != null && userResumeData["firstName"].toString().isNotEmpty ? userResumeData["firstName"] : careerPlaceHolder["firstName"]);
      bodyHtml = bodyHtml.replaceAll("{{last_name}}", userResumeData["lastName"] != null && userResumeData["lastName"].toString().isNotEmpty ? userResumeData["lastName"] : careerPlaceHolder["lastName"]);
      bodyHtml = bodyHtml.replaceAll("{{email}}", userResumeData["email"] != null && userResumeData["email"].toString().isNotEmpty ? userResumeData["email"] : careerPlaceHolder["email"]);
      bodyHtml = bodyHtml.replaceAll("{{phone_number}}", userResumeData["phoneNumber"] != null && userResumeData["phoneNumber"].toString().isNotEmpty ? userResumeData["phoneNumber"] : careerPlaceHolder["phoneNumber"]);
      bodyHtml = bodyHtml.replaceAll("{{occupation}}", userResumeData["specialization"] != null && userResumeData["specialization"].toString().isNotEmpty ? userResumeData["specialization"] : careerPlaceHolder["specialization"]);
      bodyHtml = bodyHtml.replaceAll("{{about_me}}", userResumeData["about"] != null && userResumeData["about"].toString().isNotEmpty ? userResumeData["about"] : careerPlaceHolder["about"]);
      bodyHtml = bodyHtml.replaceAll("{{address}}", userResumeData["address"] != null && userResumeData["address"].toString().isNotEmpty ? userResumeData["address"] : careerPlaceHolder["address"]);
      bodyHtml = bodyHtml.replaceAll("{{website}}", userResumeData["website"] != null && userResumeData["website"].toString().isNotEmpty ? userResumeData["website"] : careerPlaceHolder["website"]);
      bodyHtml = bodyHtml.replaceAll("{{profile_picture}}", userResumeData["picturePath"] ?? careerPlaceHolder["picturePath"]);

      bodyHtml = bodyHtml.replaceAll("{{experience_list}}", generateExperienceHTML(experienceItemHTML, getUserResumeDetails) != null ? generateExperienceHTML(experienceItemHTML, getUserResumeDetails).toString() : generateExperienceHTML(experienceItemHTML, placeholderResumeDetails).toString());
      bodyHtml = bodyHtml.replaceAll("{{education_list}}", generateEducationHTML(educationItemHTML, getUserResumeDetails) != null ? generateEducationHTML(educationItemHTML, getUserResumeDetails).toString() : generateEducationHTML(educationItemHTML, placeholderResumeDetails).toString());
      bodyHtml = bodyHtml.replaceAll("{{skills_list}}", generateSkillsHTML(skillItemHTML, getUserResumeDetails) != null ? generateSkillsHTML(skillItemHTML, getUserResumeDetails).toString() : generateSkillsHTML(skillItemHTML, placeholderResumeDetails).toString());
      bodyHtml = bodyHtml.replaceAll("{{socials_list}}", generateSocialsHTML(socialsItemHTML, getUserResumeDetails) != null ? generateSocialsHTML(socialsItemHTML, getUserResumeDetails).toString() : generateSocialsHTML(socialsItemHTML, placeholderResumeDetails).toString());
      bodyHtml = bodyHtml.replaceAll("{{projects_list}}", generateProjectsHTML(projectItemHTML, getUserResumeDetails) != null ? generateProjectsHTML(projectItemHTML, getUserResumeDetails).toString() : generateProjectsHTML(projectItemHTML, placeholderResumeDetails).toString());
      bodyHtml = bodyHtml.replaceAll("{{certifications_list}}", generateCertificationsHTML(certificationItemHTML, getUserResumeDetails) != null ? generateCertificationsHTML(certificationItemHTML, getUserResumeDetails).toString() : generateCertificationsHTML(certificationItemHTML, placeholderResumeDetails).toString());
      bodyHtml = bodyHtml.replaceAll("{{references_list}}", generateReferencesHTML(referenceItemHTML, getUserResumeDetails) != null ? generateReferencesHTML(referenceItemHTML, getUserResumeDetails).toString() : generateReferencesHTML(referenceItemHTML, placeholderResumeDetails).toString());
    }

    return bodyHtml;
  }

  String? generateCertificationsHTML(String certificationsItemHTMLTemplate, UserResumeDetails userResumeDetails)
  {
    String finalCertificationsHTML = "";
    if(userResumeDetails.trainings_courses_certifications != null && userResumeDetails.trainings_courses_certifications!.isNotEmpty)
    {
      for(int i = 0; i < userResumeDetails.trainings_courses_certifications!.length; i++)
      {
        String certificationsItem = certificationsItemHTMLTemplate.replaceAll("{{certification_title}}", userResumeDetails.trainings_courses_certifications![i].title.toString());
        certificationsItem = certificationsItem.replaceAll("{{certification_description}}", userResumeDetails.trainings_courses_certifications![i].description.toString());
        certificationsItem = certificationsItem.replaceAll("{{certification_start_year}}", getYearFromDate(userResumeDetails.trainings_courses_certifications![i].startDate.toString()));
        certificationsItem = certificationsItem.replaceAll("{{certification_end_year}}", getYearFromDate(userResumeDetails.trainings_courses_certifications![i].endDate.toString()));
        certificationsItem = certificationsItem.replaceAll("{{certification_start_month}}", getMonthFromDate(userResumeDetails.trainings_courses_certifications![i].startDate.toString()));
        certificationsItem = certificationsItem.replaceAll("{{certification_end_month}}", getMonthFromDate(userResumeDetails.trainings_courses_certifications![i].endDate.toString()));
        finalCertificationsHTML = finalCertificationsHTML + certificationsItem;
      }
    }
    return finalCertificationsHTML.isEmpty ? null : finalCertificationsHTML;
  }

  String? generateExperienceHTML(String experienceItemHTMLTemplate, UserResumeDetails userResumeDetails)
  {
    String finalExperienceHTML = "";
    if(userResumeDetails.experiences != null && userResumeDetails.experiences!.isNotEmpty)
    {
      for(int i = 0; i < userResumeDetails.experiences!.length; i++)
      {
        String expItemHTMLTemplate = experienceItemHTMLTemplate.replaceAll("{{company_name}}", userResumeDetails.experiences![i].company.toString());
        expItemHTMLTemplate = expItemHTMLTemplate.replaceAll("{{company_address}}", userResumeDetails.experiences![i].address.toString());
        expItemHTMLTemplate = expItemHTMLTemplate.replaceAll("{{experience_start_year}}", getYearFromDate(userResumeDetails.experiences![i].startDate.toString()));
        expItemHTMLTemplate = expItemHTMLTemplate.replaceAll("{{experience_end_year}}", userResumeDetails.experiences![i].currentlyWorkHere == true ? "Present" :  getYearFromDate(userResumeDetails.experiences![i].endDate.toString()));
        expItemHTMLTemplate = expItemHTMLTemplate.replaceAll("{{experience_start_month}}", getMonthFromDate(userResumeDetails.experiences![i].startDate.toString()));
        expItemHTMLTemplate = expItemHTMLTemplate.replaceAll("{{experience_end_month}}", userResumeDetails.experiences![i].currentlyWorkHere == true ? "" :  getMonthFromDate(userResumeDetails.experiences![i].endDate.toString()));
        expItemHTMLTemplate = expItemHTMLTemplate.replaceAll("{{position}}", userResumeDetails.experiences![i].position.toString());
        expItemHTMLTemplate = expItemHTMLTemplate.replaceAll("{{description}}", HtmlUnescape().convert(userResumeDetails.experiences![i].description.toString()));

        finalExperienceHTML = finalExperienceHTML + expItemHTMLTemplate;
      }
    }

    return finalExperienceHTML.isEmpty ? null : finalExperienceHTML;
  }

  String? generateEducationHTML(String educationItemHTMLTemplate, UserResumeDetails userResumeDetails)
  {
    String finalEducationHTML = "";
    // debugPrint(userResumeDetails?.educations?.length.toString());
    if(userResumeDetails.educations != null && userResumeDetails.educations!.isNotEmpty)
    {
      for(int i = 0; i < userResumeDetails.educations!.length; i++)
      {
        String eduItemHTMLTemplate = educationItemHTMLTemplate.replaceAll("{{school_name}}", userResumeDetails.educations![i].school.toString());
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{school_address}}", userResumeDetails.educations![i].schoolAddress.toString());
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{education_start_year}}", getYearFromDate(userResumeDetails.educations![i].startDate.toString()));
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{education_end_year}}", userResumeDetails.educations![i].currentlySchoolHere == true ? "Present" :  getYearFromDate(userResumeDetails.educations![i].endDate.toString()));
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{education_start_month}}", getMonthFromDate(userResumeDetails.educations![i].startDate.toString()));
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{education_end_month}}",  userResumeDetails.educations![i].currentlySchoolHere == true ? "" :  getMonthFromDate(userResumeDetails.educations![i].endDate.toString()));
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{discipline}}", userResumeDetails.educations![i].discipline.toString());
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{education_level}}", userResumeDetails.educations![i].level.toString());
        eduItemHTMLTemplate = eduItemHTMLTemplate.replaceAll("{{education_description}}", userResumeDetails.educations![i].description.toString());

        finalEducationHTML = finalEducationHTML + eduItemHTMLTemplate;
      }
    }

    return finalEducationHTML.isEmpty ? null : finalEducationHTML;
  }

  String? generateSkillsHTML(String skillsItemHTMLTemplate, UserResumeDetails userResumeDetails)
  {
    String finalSkillsHTML = "";
    if(userResumeDetails.skills != null && userResumeDetails.skills!.isNotEmpty)
    {
      for(int i = 0; i < userResumeDetails.skills!.length; i++)
      {
        String skillsItem = skillsItemHTMLTemplate.replaceAll("{{skill}}", userResumeDetails.skills![i].toString());
        finalSkillsHTML = finalSkillsHTML + skillsItem;
      }
    }

    return finalSkillsHTML.isEmpty ? null : finalSkillsHTML;
  }

  String? generateSocialsHTML(String socialsItemHTMLTemplate, UserResumeDetails userResumeDetails)
  {
    String finalSocialsHTML = "";
    if(userResumeDetails.socials != null && userResumeDetails.socials!.isNotEmpty)
    {
      for(int i = 0; i < userResumeDetails.socials!.length; i++)
      {
        String socialsItem = socialsItemHTMLTemplate.replaceAll("{{social_name}}", userResumeDetails.socials![i].name.toString());
        socialsItem = socialsItem.replaceAll("{{social_link}}", userResumeDetails.socials![i].url.toString());
        finalSocialsHTML = finalSocialsHTML + socialsItem;
      }
    }
    return finalSocialsHTML.isEmpty ? null : finalSocialsHTML;
  }

  String? generateProjectsHTML(String projectsItemHTMLTemplate, UserResumeDetails userResumeDetails)
  {
    String finalProjectsHTML = "";
    if(userResumeDetails.projects != null && userResumeDetails.projects!.isNotEmpty)
    {
      for(int i = 0; i < userResumeDetails.projects!.length; i++)
      {
        String projectsItem = projectsItemHTMLTemplate.replaceAll("{{project_title}}", userResumeDetails.projects![i].title.toString());
        projectsItem = projectsItem.replaceAll("{{project_description}}", userResumeDetails.projects![i].description.toString());
        projectsItem = projectsItem.replaceAll("{{project_start_year}}", getYearFromDate(userResumeDetails.projects![i].startDate));
        projectsItem = projectsItem.replaceAll("{{project_end_year}}", getYearFromDate(userResumeDetails.projects![i].endDate));
        projectsItem = projectsItem.replaceAll("{{project_start_month}}", getMonthFromDate(userResumeDetails.projects![i].startDate));
        projectsItem = projectsItem.replaceAll("{{project_end_month}}", getMonthFromDate(userResumeDetails.projects![i].endDate));
        finalProjectsHTML = finalProjectsHTML + projectsItem;
      }
    }
    return finalProjectsHTML.isEmpty ? null : finalProjectsHTML;
  }

  String? generateReferencesHTML(String referencesItemHTMLTemplate, UserResumeDetails userResumeDetails)
  {
    String finalSocialsHTML = "";
    if(userResumeDetails.references != null && userResumeDetails.references!.isNotEmpty)
    {
      for(int i = 0; i < userResumeDetails.references!.length; i++)
      {
        String referencesItem = referencesItemHTMLTemplate.replaceAll("{{reference_name}}", userResumeDetails.references![i].name.toString());
        referencesItem = referencesItem.replaceAll("{{reference_company}}", userResumeDetails.references![i].company.toString());
        referencesItem = referencesItem.replaceAll("{{reference_position}}", userResumeDetails.references![i].position.toString());
        referencesItem = referencesItem.replaceAll("{{reference_email}}", userResumeDetails.references![i].email.toString());
        referencesItem = referencesItem.replaceAll("{{reference_address}}", userResumeDetails.references![i].address.toString());
        referencesItem = referencesItem.replaceAll("{{reference_phonenumber}}", userResumeDetails.references![i].phoneNumber.toString());
        finalSocialsHTML = finalSocialsHTML + referencesItem;
      }
    }
    return finalSocialsHTML.isEmpty ? null : finalSocialsHTML;
  }

  String getYearFromDate(String? dateString) {
    if(dateString != null && dateString.isNotEmpty){
      List<String> dateParts = dateString.split('/');
      if (dateParts.length == 3) {
        return dateParts[2]; // The year is at index 2 in the split array
      } else {
        print(dateString);
        throw FormatException('Invalid date format');
      }
    } else {
      return "";
    }
  }

  String getMonthFromDate(String? dateString) {
  if(dateString != null && dateString.isNotEmpty){
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      int? monthNumber = int.tryParse(dateParts[1]);

      if (monthNumber != null && monthNumber >= 1 && monthNumber <= 12) {
        // List of month names
        List<String> monthNames = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];

        // Return the corresponding month name
        return monthNames[monthNumber - 1];
      } else {
        print(dateString);
        throw FormatException('Invalid month number');
      }
    } else {
      throw FormatException('Invalid date format');
    }
  }
  else {
  return "";
}
}
}
