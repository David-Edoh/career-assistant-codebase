import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/presentation/resume_maker_screen/widgets/ai_action_buttons.dart';
import 'package:fotisia/presentation/resume_maker_screen/widgets/loading.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/resume_maker_bloc.dart';
import 'widgets/message_box.dart';
import 'models/resume_maker_model.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:animated_floating_button_pro/floating_action_button.dart';
import 'package:animated_floating_button_pro/floating_button_props.dart';



class ResumeMakerScreen extends StatefulWidget {
  ResumeMakerScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ResumeMakerBloc>(
        create: (context) => ResumeMakerBloc(
            ResumeMakerState(personalBrandModelObj: ResumeMakerModel()))
          ..add(ResumeMakerInitialEvent())
          ..add(GetUserResumeDataEvent())
          ..add(GetTemplatesEvent()),
        child: ResumeMakerScreen());
  }

  @override
  State<ResumeMakerScreen> createState() => _ResumeMakerScreenState();
}

class _ResumeMakerScreenState extends State<ResumeMakerScreen> {
  ///[controller] create a QuillEditorController to access the editor methods
  final PanelController _panelController = PanelController();
  late String link = "";
  late String currentJobPageTitle = "";
  late String jobTitle = "";
  late String jobCompany = "";
  late String jobContent = "";
  final _toolbarColor = Colors.grey.shade200;
  final _toolbarIconColor = Colors.black87;
  bool enteringInstruction = false;
  late double? maxPanelHeight;
  late double? minPanelHeight;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController resumeEditInstructionsInputController = TextEditingController();
  bool webPageHasLoaded = false;
  bool siaMessageOpen = true;



  @override
  void initState() {
    super.initState();
    maxPanelHeight =  null;
    minPanelHeight = null;
    // _controller = controller;
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final scaleMatrix = Matrix4.identity()..scale(1.0);
    final transformationController = TransformationController(scaleMatrix);

    if(link.isEmpty || link == null){
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
      if(arguments['jobLink'] != null){
        setState(() {
          link = arguments['jobLink'];
          jobTitle = arguments['jobTitle'];
          jobCompany = arguments['jobCompany'];
          jobContent = arguments['jobContent'];
          currentJobPageTitle = arguments['currentJobPageTitle'];
        });
      }
    }

    return BlocBuilder<ResumeMakerBloc, ResumeMakerState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
              backgroundColor: appTheme.whiteA70001,
              resizeToAvoidBottomInset: true,
              drawerEnableOpenDragGesture: false,
              appBar: CustomAppBar(
                height: getVerticalSize(70),
                leadingWidth: getHorizontalSize(50),
                leading: Semantics(
                  label: "button: Go back to the previous page",
                  child: Center(
                    child: AppbarImage(
                        svgPath: ImageConstant.imgGroup162799,
                        margin: getMargin(top: 13, bottom: 14),
                        onTap: () {
                          onTapArrowbackone(context);
                        }),
                  ),
                ),
                centerTitle: true,
                title: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: AppbarTitle(text: "Resume Builder"),
                  ),
                ),
                actions: [
                  PopupMenuButton<String>(
                    offset: const Offset(20, 20),
                    onSelected: (String value) {
                      setState(() {
                        // _selectedValue = value;
                      });
                    },

                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: const Text('Upload Resume (PDF)'),
                        onTap: () async {
                          context.read<ResumeMakerBloc>().add(UploadResumeEvent());
                        },
                      ),

                      PopupMenuItem(
                        child: const Text('Edit Resume'),
                        onTap: () async {
                          NavigatorService.pushNamed(AppRoutes.editResumeDetails).then((_) {
                            context.read<ResumeMakerBloc>().add(ResumeMakerInitialEvent());
                            context.read<ResumeMakerBloc>().add(GetTemplatesFromLocalStoreEvent());
                            context.read<ResumeMakerBloc>().add(GetTemplatesEvent());
                          });
                        },
                      ),

                      PopupMenuItem(
                        child: const Text('Save changes'),
                        onTap: (){
                          context.read<ResumeMakerBloc>().add(
                            SaveResumeDetailsEvent(),
                          );
                        },
                      ),

                      PopupMenuItem(
                        child: const Text('Download resume'),
                        onTap: (){
                          context.read<ResumeMakerBloc>().add(
                            DownloadResumeEvent(),
                          );
                        },
                      ),

                      // !state.isPreviewMode! ? PopupMenuItem(
                      //   child: const Text('Preview'),
                      //   onTap: () {
                      //     context.read<ResumeMakerBloc>().add(
                      //       PreviewResumeEvent(),
                      //     );
                      //   },
                      // ) : PopupMenuItem(
                      //   child: const Text('Exit Preview'),
                      //   onTap: () {
                      //     context.read<ResumeMakerBloc>().add(
                      //       PreviewResumeEvent(),
                      //     );
                      //   },
                      // ),

                      PopupMenuItem(
                        child: const Text('View Sample'),
                        onTap: () => Scaffold.of(context).openDrawer(),
                      ),

                    ],
                  )
                ],
              ),
              drawer: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Drawer(
                  child: SafeArea(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Semantics(
                              label: "button: Close sample resume drawer",
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: CustomImageView(
                                  svgPath: ImageConstant.imgClose2,
                                  height: 48,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("Sample Resume"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Semantics(
                          label: "Image: Sample resume with the selected template",
                          child: CustomImageView(
                            height: getVerticalSize(500),
                            url: state.selectedTemplate?.thumbnail,
                          ),
                        ),
                      ),
                    ],
                  )), // Populate the Drawer in the next step.
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: mediaQueryData.size.height * 0.75,
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: SlidingUpPanel(
                                        defaultPanelState: PanelState.OPEN,
                                        parallaxEnabled: false,
                                        maxHeight: maxPanelHeight ?? MediaQuery.of(context).size.height * .25,
                                        minHeight: minPanelHeight ?? MediaQuery.of(context).size.height * .02,
                                        controller: _panelController,
                                        body: Column(
                                          children: [
                                            SizedBox(
                                              height: mediaQueryData.size.height * 0.8,
                                              child: Column(
                                                children: [
                                                  state.webViewLoadingComplete ? Expanded(
                                                    child: InteractiveViewer(
                                                            // alignment: Alignment.topLeft,
                                                            constrained: false,
                                                            boundaryMargin:
                                                                const EdgeInsets.all(
                                                                    double.infinity),
                                                            transformationController:
                                                                transformationController,
                                                            minScale: 0.01,
                                                            // maxScale: 5.6,
                                                            child: SizedBox(
                                                                width: MediaQuery.of(context).size.width * 1,
                                                                height: MediaQuery.of(context).size.height * 4,
                                                                child: Stack(
                                                                  alignment: Alignment.topCenter,
                                                                  children: [
                                                                    WebViewWidget(
                                                                        controller: (state.controller as WebViewController)..setNavigationDelegate(
                                                                            NavigationDelegate(
                                                                                  onPageStarted: (String url){
                                                                                    print("Started loading web-view");
                                                                                    setState(() {
                                                                                      webPageHasLoaded = false;
                                                                                    });
                                                                                  },
                                                                                  onPageFinished: (String url) {
                                                                                    print("Done loading web-view");
                                                                                    String js = "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=50px, initial-scale=' + (document.documentElement.clientWidth / 1024));";
                                                                                    state.controller?.runJavaScript(js);
                                                                                    setState(() {
                                                                                      webPageHasLoaded = true;
                                                                                    });
                                                                                  },
                                                                            )
                                                                        ),
                                                                    ),
                                                                    if (!webPageHasLoaded) Positioned.fill(
                                                                      child: Container(
                                                                        color: Colors.white,
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(
                                                                                width: mediaQueryData.size.width * 0.6,
                                                                                height: mediaQueryData.size.height * 0.7,

                                                                                child: ResumeShimmerPage()
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                            )
                                                        )
                                                    ) :  SizedBox(
                                                          width: mediaQueryData.size.width * 0.6,
                                                          height: mediaQueryData.size.height * 0.5,
                                                          child: ResumeShimmerPage(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        panelBuilder: (ScrollController sc) => !enteringInstruction ? Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24.0),
                                                topRight: Radius.circular(24.0),
                                              )),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 6.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 30,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(12.0))),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              (state.getResumeTemplatesResp != null &&
                                                      state.getResumeTemplatesResp!.templates!
                                                          .isNotEmpty)
                                                  ? CarouselSlider(
                                                      options: CarouselOptions(
                                                        height: MediaQuery.of(context).size.height *
                                                                .20,
                                                        initialPage:
                                                            state.initialCarouselPage ?? 0,
                                                        viewportFraction: 0.4,
                                                        enableInfiniteScroll: false,
                                                        enlargeCenterPage: true,
                                                        enlargeFactor: 0.3,
                                                        clipBehavior: Clip.none,
                                                      ),
                                                      items: state
                                                          .getResumeTemplatesResp?.templates
                                                          ?.asMap()
                                                          .entries
                                                          .map((entry) => GestureDetector(
                                                                onTap: () async {
                                                                  const storage =
                                                                      FlutterSecureStorage();
                                                                  await storage.write(
                                                                      key: "selectedTemplateKey",
                                                                      value: (entry.key).toString());
                                                                  context.read<ResumeMakerBloc>().add(
                                                                        ChangeResumeTemplateEvent(
                                                                            value: entry.value.id as int),
                                                                      );
                                                                },
                                                                child: Semantics(
                                                                  label: "button: Resume template ${entry.key}",
                                                                  child: Card(
                                                                    // semanticLabel: "",
                                                                    shape: state.selectedTemplate?.id == entry.value.id
                                                                        ? RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                color: theme
                                                                                    .colorScheme
                                                                                    .primary,
                                                                                width: 2.0),
                                                                            borderRadius:
                                                                                BorderRadius
                                                                                    .circular(4.0))
                                                                        : RoundedRectangleBorder(
                                                                            side: const BorderSide(
                                                                                color: Colors.white,
                                                                                width: 2.0),
                                                                            borderRadius:
                                                                                BorderRadius
                                                                                    .circular(4.0)),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Center(
                                                                        child: Semantics(
                                                                          label: "button: Resume template ${entry.key}",
                                                                          child: CustomImageView(
                                                                            fit: BoxFit.fitWidth,
                                                                            url: entry.value.thumbnail
                                                                                .toString(),
                                                                            // height: 90.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                    )
                                                  : Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.fromLTRB(
                                                            0, 10, 0, 10.0),
                                                        child: Container(
                                                          height: getHorizontalSize(80),
                                                          child:
                                                              LoadingAnimationWidget.beat(
                                                            color: theme.colorScheme.primary,
                                                            size: getHorizontalSize(20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ) : Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            CustomTextFormField(
                                                controller: resumeEditInstructionsInputController,
                                                margin: getMargin(top: 7),
                                                hintText: "How should I modify your resume?",
                                                hintStyle: CustomTextStyles
                                                    .titleMediumBluegray400,
                                                textInputAction: TextInputAction.done,
                                                maxLines: 6,
                                                contentPadding: getPadding(
                                                    left: 16,
                                                    top: 20,
                                                    right: 16,
                                                    bottom: 20)
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CustomElevatedButton(
                                                    width: mediaQueryData.size.width * 0.3,
                                                      text: "Cancel",
                                                      height: 30,
                                                      margin: getMargin(left: 24, right: 24, bottom: 37),
                                                      buttonStyle: CustomButtonStyles.fillPrimary,
                                                      onTap: () async {
                                                        await _panelController.close();
                                                        setState(() {
                                                          // if (_formKey.currentState!.validate()) {
                                                            enteringInstruction = false;
                                                            maxPanelHeight = mediaQueryData.size.height * 0.80;
                                                          // }
                                                        });
                                                      }
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CustomElevatedButton(
                                                      width: mediaQueryData.size.width * 0.3,
                                                      text: "Send",
                                                      height: 30,
                                                      margin: getMargin(left: 24, right: 24, bottom: 37),
                                                      buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
                                                        backgroundColor: MaterialStateProperty.all(theme.colorScheme.secondary),
                                                      ),
                                                      onTap: () async {
                                                        await _panelController.close();
                                                        context.read<ResumeMakerBloc>().add(
                                                          OptimizeResume(jobContent: jobContent, instructions: resumeEditInstructionsInputController.value.text),
                                                        );
                                                        setState(() {
                                                          if (_formKey.currentState!.validate()) {
                                                            enteringInstruction = false;
                                                            maxPanelHeight = mediaQueryData.size.height * 0.80;
                                                          }
                                                        });
                                                      }
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        collapsed: Container()
                                      )
                                  ),
                                ),
                              ),

                              Padding(
                                  padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
                                  child: SiaResumeSection(jobTitle: jobTitle, jobCompany: jobCompany, resumeEditInstructionsInputController: resumeEditInstructionsInputController, sendInstruction: sendInstruction,),
                              ),
                            ],
                          ),
                        ],
                      ),

                      if(state.message != null && state.message!.isNotEmpty) Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(siaMessageOpen) Container(
                                  margin: getMargin(left: 12),
                                  padding: getPadding(
                                      left: 12,
                                      top: 10,
                                      right: 12,
                                      bottom: 10),
                                  decoration: AppDecoration.fillPrimary.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                          getHorizontalSize(24.00),
                                        ),
                                        bottomRight: Radius.circular(
                                          getHorizontalSize(24.00),
                                        ),
                                        bottomLeft: Radius.circular(
                                          getHorizontalSize(24.00),
                                        ),
                                      )
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: getHorizontalSize(164),
                                          margin: getMargin(top: 4, right: 14),
                                          child: Text(state.message!, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                                      ),
                                      const Icon(Icons.close, color: Colors.white,)
                                    ],
                                  )
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    siaMessageOpen = !siaMessageOpen;
                                  });
                                },
                                child: Container(
                                  height: 43,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.account_circle),
                                      Text("Sia"),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  Widget _scrollingList(ScrollController sc) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        const BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          const SizedBox(
            height: 18.0,
          ),
          Expanded(
            child: ListView.builder(
              controller: sc,
              itemCount: 50,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("$i"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget textButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: _toolbarIconColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: _toolbarColor),
          )),
    );
  }

   sendInstruction(String instruction) async {
    await _panelController.close();
    context.read<ResumeMakerBloc>().add(OptimizeResume(jobContent: jobContent, instructions: instruction),
    );
    setState(() {
      if (_formKey.currentState!.validate()) {
        enteringInstruction = false;
        maxPanelHeight = mediaQueryData.size.height * 0.80;
      }
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
    NavigatorService.goBack();
  }
}
