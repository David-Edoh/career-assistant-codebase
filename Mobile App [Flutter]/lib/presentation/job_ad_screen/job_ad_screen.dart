import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import '../../widgets/custom_glow_button.dart';
import '../resume_maker_screen/resume_edit_session_manager.dart';
import 'bloc/job_ad_bloc.dart';
import 'job_analysis_popup_dialog/job_analysis_popup_dialog.dart';



class JobAdScreen extends StatefulWidget {
  JobAdScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<JobAdBloc>(
        create: (context) => JobAdBloc(JobAdState())
          ..add(JobAdInitialEvent()),
        child: JobAdScreen());
  }

  @override
  State<JobAdScreen> createState() => _JobAdScreenState();
}


class _JobAdScreenState extends State<JobAdScreen> {
  late WebViewController wvController;
  late String jobUrl = "";

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    String jobLink = arguments['jobUrl'];

    if(jobUrl.isEmpty){
      setState(() {
        jobUrl = jobLink;
        wvController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {

              },
              onPageFinished: (String url) {
                _extractContent();
              },
              // onHttpError: (HttpResponseError error) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(jobUrl));
      });
    }

    return BlocBuilder<JobAdBloc, JobAdState>(builder: (context, state)
    {
      return Scaffold(
          backgroundColor: appTheme.whiteA70001,
          resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Semantics(
            label: "Text: Sia's job recommendation",
            child: FloatingActionButton.extended(
              backgroundColor: Colors.transparent,
                elevation: 0,
              onPressed: () {},
              label: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  state.gettingQualificationScore != null && state.gettingQualificationScore! ? Container(
                    height: mediaQueryData.size.width * 0.2,
                    width: mediaQueryData.size.width * 0.95,
                    color: Colors.black,
                    child: LoadingAnimationWidget.beat(
                      color: Colors.white,
                      size: 20,
                    ),
                  ) : Container(),
                  state.gettingQualificationScore != null && !state.gettingQualificationScore! ? Container(
                    height: mediaQueryData.size.width * 0.2,
                    width: mediaQueryData.size.width * 0.95,
                    color: Colors.black,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8,8,8),
                          child: SizedBox(
                            width: mediaQueryData.size.width * 0.55,
                            child: Text(
                                state.qualificationScore! >=  60 ? "SIA: You are ${state.qualificationScore.toString()}% qualified for this position. Should I prepare your resume so you can apply?" : "SIA: You are ${state.qualificationScore.toString()}% qualified for this job.",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                    ),
                  ) : Container(),

                  state.gettingQualificationScore != null && !state.gettingQualificationScore! && state.qualificationScore! >= 60 ? Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: ElevatedButton(
                        onPressed: () async {
                          String? currentPageTitle = await wvController.getTitle();
                          Object content = await wvController.runJavaScriptReturningResult(
                            "document.documentElement.innerText",
                          );
                          ResumeEditSessionProvider().createSession("", "resume-edit-session");
                          NavigatorService.pushNamed(AppRoutes.resumeMaker, arguments: {"jobLink": jobUrl, "currentJobPageTitle": currentPageTitle, "jobTitle": state.jobTitle, "jobCompany": state.jobCompany, "jobContent": content.toString()});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        ),
                        child: const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Text("Yes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                        )
                    ),
                  ) : Container(),

                  state.gettingQualificationScore != null && !state.gettingQualificationScore! && state.qualificationScore! < 60 ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: (){
                          onTapTxtLargelabelmediu(context, state.explanation!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        ),
                        child: const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Text("See why", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                        )
                    ),
                  ) : Container(),
                ],
              ),
            ),
          ),
          appBar: CustomAppBar(
              height: getVerticalSize(70),
              leadingWidth: getHorizontalSize(50),
              leading: Center(
                child: Semantics(
                  label: "Back to previous page",
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: AppbarImage(
                        svgPath: ImageConstant.imgGroup162799,
                        margin: getMargin(left: 24, top: 13, bottom: 14),
                        onTap: () {
                          onTapArrowbackone(context);
                        }),
                  ),
                ),
              ),
              centerTitle: true,
              title: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                child: Center(
                  child: AppbarTitle(
                      text: "Job Ad"
                  ),
                ),
              )),
          body: SafeArea(
            child: WebViewWidget(
                controller: wvController
            ),
          ));
    });
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapImgImage(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the jobTypeScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the jobTypeScreen.
  onTapContinue(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.jobTypeScreen,
    );
  }

  onTapArrowbackone(BuildContext context) {
    Navigator.pop(context);
  }

  void _extractContent() async {
    String? currentUrl = await wvController.currentUrl();
    // if(currentUrl != null && currentUrl.isNotEmpty && currentUrl.contains("other")){
      Object content = await wvController.runJavaScriptReturningResult(
        "document.documentElement.innerText",
      );
      _getInsights(content.toString());
    // }
  }

  void _getInsights(String content) {
    // Send content to Gemini API and handle the response
    context.read<JobAdBloc>().add(GetQualificationScore(jobAd: content.toString()));
  }

  onTapTxtLargelabelmediu(BuildContext context, String data) {

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: JobAnalysisPopupDialog(explanation: data,).builder(context),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ));
  }
}
