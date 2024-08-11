import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import '../../core/constants/global_keys.dart';
import '../../core/utils/animation_constants.dart';
import '../../core/utils/long_wait_animation_provider.dart';
import '../../widgets/AdmobAdLarge.dart';
import '../../widgets/app_bar/appbar_circleimage.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/milestone_progress.dart';
import '../feeds_page/models/get_feeds_resp.dart';
import 'bloc/home_container_bloc.dart';
import 'models/home_container_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/presentation/home_page/home_page.dart';
import 'package:fotisia/presentation/message_page/message_page.dart';
import 'package:fotisia/presentation/chat_screen/chat_screen.dart';
import 'package:fotisia/presentation/my_profile_page/profile_page.dart';
import 'package:fotisia/presentation/feeds_page/feeds_page.dart';
import 'package:fotisia/presentation/search_screen/search_screen.dart';
import 'package:fotisia/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeContainerBloc>(
        create: (context) => HomeContainerBloc(
            HomeContainerState(homeContainerModelObj: HomeContainerModel()))
          ..add(HomeContainerInitialEvent()),
        child: const HomeContainerScreen());
  }

  // static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<HomeContainerScreen> createState() => _HomeContainerScreenState();
}


class _HomeContainerScreenState extends State<HomeContainerScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // final GlobalKey panelKey = GlobalKey();
  final PanelController _pc = PanelController();
  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalKeys.navigatorKey = navigatorKey;

    //This method will call when the app is in kill state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if(message.data['page'] == "feeds-notification"){
          NavigatorService.pushNamed(
            AppRoutes.notificationsGeneralPage,
          );
        }
      }
    });

    //This method will call when the app is in foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message != null && message.data.isNotEmpty) {
        ///Handle push notification redirection here
        ///Just show a toast message with the details
      }
    });

    //This method will call when the app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        //Handle push notification redirection here
        if(message.data['page'] == "feeds-notification"){
          NavigatorService.pushNamed(
            AppRoutes.notificationsGeneralPage,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<HomeContainerBloc, HomeContainerState>(
        builder: (context, state) {
      return BlocListener<HomeContainerBloc, HomeContainerState>(
        listener: (BuildContext context, state){
          if(state.openSlideUpPanel ?? false)
          {
            _pc.animatePanelToPosition(1, duration: Duration(milliseconds: 500));
          }
        },
        child:  Scaffold(
          drawerScrimColor: Colors.black,
          body:  PopScope(
            canPop: canPopNow,
            onPopInvoked: onPopInvoked,
            child: Consumer<LongLoadingProvider>(
                builder: (context, chatProvider, child) {
                  return  Stack(
              children: [
                SlidingUpPanel(
                  parallaxEnabled: false,
                  maxHeight:  MediaQuery.of(context).size.height * .9,
                  minHeight:  MediaQuery.of(context).size.height * 0,
                  controller: _pc,
                  onPanelClosed: (){
                    context.read<HomeContainerBloc>().add(SetCloseSlideUpPanel());
                  },
                  panel: Container(
                      height: mediaQueryData.size.height * 0.9,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          )
                      ),
                      child: SizedBox(
                        height: mediaQueryData.size.height * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Stack(
                            alignment: mediaQueryData.viewInsets.bottom == 0 ? Alignment.bottomCenter : Alignment.center,
                            children: [
                              Container(
                                height: mediaQueryData.size.height * 0.9,
                                child: !state.loadingComments ? Column(
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
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(12.0)
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Center(
                                      child: Text(
                                          "Comments",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                    if (state.comments == null || state.comments!.isEmpty) CustomImageView(
                                        svgPath: ImageConstant.imgGossip,
                                        color: Colors.black.withOpacity(0.08),
                                        height: getSize(250),
                                        width: getSize(250),
                                        radius: BorderRadius.circular(
                                            getHorizontalSize(16)),
                                        alignment: Alignment.center),
                                    (state.comments == null || state.comments!.isEmpty) ? const Text("What do you think?") : Container(),

                                    (state.comments != null && state.comments!.isNotEmpty) ?  SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.56,
                                      child: ListView(
                                          physics:  const ScrollPhysics(),

                                          children: state.commentsWithAds!.map((comment) {
                                            if(comment is Comment){
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap:  () {
                                                                if(comment.user != null) {
                                                                  NavigatorService.pushNamed(
                                                                    AppRoutes.userProfilePage,
                                                                    arguments: {'userId': comment.user?.id},
                                                                  );
                                                                }
                                                              },
                                                              child: CustomIconButton(
                                                                height: getSize(40),
                                                                width: getSize(40),
                                                                margin: getMargin(
                                                                  left: 10,
                                                                  right: 10,
                                                                ),
                                                                padding: getPadding(
                                                                  all: 4,
                                                                ),
                                                                decoration: IconButtonStyleHelper.fillGrayTL16,
                                                                child: CustomImageView(
                                                                  url: (comment.user != null && comment.user!.picturePath != null && comment.user!.picturePath!.isNotEmpty) ? comment.user!.picturePath : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                                                  radius: BorderRadius.circular(getHorizontalSize(44)),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap:  () {
                                                                if(comment.user != null) {
                                                                  NavigatorService.pushNamed(
                                                                    AppRoutes.userProfilePage,
                                                                    arguments: {'userId': comment.user?.id},
                                                                  );
                                                                }
                                                              },
                                                              child: Text(
                                                                "${comment.user!.firstName} ${comment.user!.lastName}",
                                                                style: CustomTextStyles.titleSmallPrimaryBold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        comment.userId == state.thisUser?.id ? PopupMenuButton<int>(
                                                          // color: Colors.white,
                                                          offset: const Offset(10, 20),
                                                          elevation: 2,
                                                          itemBuilder: (context) => [
                                                            // popupmenu item 1
                                                            PopupMenuItem(
                                                              onTap: (){
                                                                context.read<HomeContainerBloc>().add(DeleteCommentEvent(commentId: comment.id));
                                                              },
                                                              value: 1,
                                                              // row has two child icon and text.
                                                              child: const Row(
                                                                children: [
                                                                  Icon(Icons.delete),
                                                                  SizedBox(
                                                                    // sized box with width 10
                                                                    width: 10,
                                                                  ),
                                                                  Text("Delete", style: TextStyle(color: Colors.black),)
                                                                ],
                                                              ),
                                                            ),

                                                          ],
                                                        ) : Container(),

                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: getMargin(left: 12),
                                                      padding: getPadding(
                                                          left: 12,
                                                          top: 10,
                                                          right: 12,
                                                          bottom: 10),
                                                      decoration: AppDecoration.fillGray.copyWith(
                                                          borderRadius: BorderRadius.only(
                                                            // topLeft: Radius.circular(getHorizontalSize(24)),
                                                            topRight: Radius.circular(getHorizontalSize(24)),
                                                            bottomRight: Radius.circular(getHorizontalSize(24)),
                                                            bottomLeft: Radius.circular(getHorizontalSize(24)),
                                                          )),
                                                      child: Container(
                                                          // width: getHorizontalSize(164),
                                                          margin: getMargin(right: 14),
                                                          child: Text(comment.text ?? "",
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: const TextStyle(color: Colors.black),
                                                          )
                                                      )
                                                  ),
                                                  Padding(
                                                    padding: getPadding(top: 15),
                                                    child: SizedBox(
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Divider(
                                                        height: getVerticalSize(1),
                                                        thickness: getVerticalSize(1),
                                                        color: appTheme.indigo50
                                                      )
                                                    )
                                                  ),

                                                ],
                                              ),
                                            );
                                          } else {
                                              return Container(
                                                  height: 320,
                                                  child: AdMobAdLarge()
                                              );
                                            }
                                              //Text(comment.text ?? "here");
                                          }).toList()
                                      )

                                    ) : Container(),

                                  ],
                                ) : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: LoadingAnimationWidget.staggeredDotsWave(
                                      color: theme.colorScheme.secondary,
                                      size: 60,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                height: mediaQueryData.size.height * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocSelector<HomeContainerBloc, HomeContainerState, TextEditingController?>(
                                        selector: (state) => state.commentController,
                                        builder: (context, messageController) {
                                          return CustomTextFormField(
                                              controller: messageController,
                                              maxLines: 2,
                                              margin: getMargin(left: 10, right: 10, bottom: 10),
                                              hintText: "Add a comment",
                                              hintStyle: CustomTextStyles.labelLargeGray600,
                                              textInputAction: TextInputAction.done,
                                              contentPadding: getPadding(
                                                  left: 30, top: 20, right: 30, bottom: 20),
                                              borderDecoration: TextFormFieldStyleHelper.fillGray,
                                              fillColor: appTheme.gray20001);
                                        }),
                                    CustomElevatedButton(
                                      text: "Send",
                                      onTap: (){
                                        context.read<HomeContainerBloc>().add(PostCommentEvent());
                                      },
                                      height: getVerticalSize(70),
                                      width: getHorizontalSize(137),
                                      buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                                      margin: getMargin(left: 10, right: 10, bottom: 30),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  body: Scaffold(
                      backgroundColor: appTheme.whiteA70001,
                      body: SafeArea(
                        child:
                        Navigator(
                            key: navigatorKey,
                            initialRoute: AppRoutes.homePage,
                            onGenerateRoute: (routeSetting) => PageRouteBuilder(
                                pageBuilder: (ctx, ani, ani1) =>
                                    getCurrentPage(context, routeSetting.name!),
                                transitionDuration: Duration(seconds: 0)
                            )
                        ),

                      ),
                      bottomNavigationBar: CustomBottomBar(onChanged: (BottomBarEnum type) {
                        Navigator.pushNamed(
                            navigatorKey.currentContext!, getCurrentRoute(type)
                        );
                      })),
                ),

                if(context.read<LongLoadingProvider>().loading) SafeArea(
                  child: Container(
                    height: mediaQueryData.size.height,
                    color: theme.colorScheme.tertiary,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(height: mediaQueryData.size.height * 0.01),
                          Column(
                            children: [
                              Semantics(
                                label: "Image: Picture of Sia, Your career assistant.",
                                child: SizedBox(
                                  height: mediaQueryData.size.height * 0.2,
                                  width: mediaQueryData.size.width * 0.3,
                                  child: AppbarCircleimage(
                                    imagePath: ImageConstant.imgAvatar32x32,
                                    margin: getMargin(
                                      top: 5,
                                      bottom: 5,
                                    ),
                                  ),
                                ),
                              ),
                              const  Text("Please wait while we setup your environment for the first time, this might take a while.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("...Some Basic Career Tips...", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),

                              CarouselSlider(
                                options: CarouselOptions(
                                  height: mediaQueryData.size.height * 0.2,
                                  viewportFraction: 1,
                                  aspectRatio: 1.0,
                                  autoPlayInterval: const Duration(seconds: 10),
                                  // enlargeCenterPage: true,
                                  // scrollDirection: Axis.vertical,
                                  autoPlay: true,
                                ),
                                items: const [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                      // SizedBox(
                                      //     height: 180,
                                      //     child: Lottie.asset(AnimationConstant.loadingCogAnimation)
                                      // ),
                                        Text("Networking Tip: Attend industry events to build valuable connections and learn about job opportunities.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.hiThereAnimation)
                                        // ),
                                        Text("Resume Advice: Tailor your resume for each job application to highlight relevant skills and experiences.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.loadingCogAnimation)
                                        // ),
                                        Text("Interview Prep: Practice common interview questions and develop your STAR (Situation, Task, Action, Result) responses.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.avatarToyShip)
                                        // ),
                                        Text("Skill Development: Continuously learn and update your skills through online courses and workshops.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.meditationAnimation)
                                        // ),
                                        Text("Career Goals: Set short-term and long-term career goals to keep your professional growth on track.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.loadingCogAnimation)
                                        // ),
                                        Text("Work-Life Balance: Prioritize self-care and time management to maintain a healthy work-life balance.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.shoppingAnimation)
                                        // ),
                                        Text("Professional Associations: Join professional organizations related to your field to access resources and networking opportunities.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.ballPlayAnimation)
                                        // ),
                                        Text("Soft Skills: Develop essential soft skills such as communication, teamwork, and problem-solving.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.ballPlayAnimation)
                                        // ),
                                        Text("Personal Branding: Build a personal brand that reflects your strengths and professional values.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //     height: 180,
                                        //     child: Lottie.asset(AnimationConstant.ballPlayAnimation)
                                        // ),
                                        Text("Salary Negotiation: Research salary ranges in your industry and practice negotiation techniques.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LoadingAnimationWidget.inkDrop(
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                MilestoneProgress(
                                  width: mediaQueryData.size.width * 0.95,
                                  totalMilestones: 6,
                                  completedMilestone: context.read<LongLoadingProvider>().loadingMilestone,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          )

        ),
      );

    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.chatbot:
        return AppRoutes.chatScreen;
      case BottomBarEnum.connect:
        return AppRoutes.feedsPage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
      case BottomBarEnum.search:
        return AppRoutes.searchScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage.builder(context);
      case AppRoutes.chatScreen:
        return ChatScreen.builder(context);
      case AppRoutes.feedsPage:
        return FeedsPage.builder(context);
      case AppRoutes.profilePage:
        return ProfilePage.builder(context);
      case AppRoutes.searchScreen:
        return SearchScreen.builder(context);
      default:
        return DefaultWidget();
    }
  }

  openCommentSection(){

  }


  void onPopInvoked(bool didPop) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            Duration(seconds: requiredSeconds)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tap back again to leave');
      Future.delayed(
        Duration(seconds: requiredSeconds),
            () {
          // Disable pop invoke and close the toast after 2s timeout
          setState(() {
            canPopNow = false;
          });
          Fluttertoast.cancel();
        },
      );
      // Ok, let user exit app on the next back press
      setState(() {
        canPopNow = true;
      });
    }
  }
}
