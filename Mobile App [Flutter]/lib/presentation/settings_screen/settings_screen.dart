import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'bloc/settings_bloc.dart';
import 'models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/presentation/home_page/home_page.dart';
import 'package:fotisia/presentation/message_page/message_page.dart';
import 'package:fotisia/presentation/my_profile_page/profile_page.dart';
import 'package:fotisia/presentation/saved_page/saved_page.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_bottom_bar.dart';
import 'package:fotisia/presentation/logout_popup_dialog/logout_popup_dialog.dart';

// ignore_for_file: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<SettingsBloc>(
        create: (context) =>
            SettingsBloc(SettingsState(settingsModelObj: SettingsModel()))
              ..add(SettingsInitialEvent()),
        child: SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: appTheme.whiteA70001,
          appBar: CustomAppBar(
              height: getVerticalSize(70),
              leadingWidth: getHorizontalSize(50),
              leading: Semantics(
                label: "Button: Go back to profile page",
                child: AppbarImage(
                    svgPath: ImageConstant.imgGroup162799,
                    margin: getMargin(left: 24, top: 13, bottom: 14),
                    onTap: () {
                      onTapArrowbackone(context);
                    }),
              ),
              centerTitle: true,
              title: AppbarTitle(
                  text: "lbl_settings".tr,
                margin: EdgeInsets.only(right: getHorizontalSize(40)),
              )
          ),
          body: SafeArea(
            child: SizedBox(
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                    padding: getPadding(top: 28),
                    child: Padding(
                        padding: getPadding(left: 24, right: 24, bottom: 5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Container(
                              //     padding: getPadding(top: 13, bottom: 13),
                              //     decoration: AppDecoration.fillPrimary
                              //         .copyWith(
                              //             borderRadius: BorderRadiusStyle
                              //                 .roundedBorder16),
                              //     child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         children: [
                              //           // Padding(
                              //           //     padding:
                              //           //         getPadding(top: 3, bottom: 2),
                              //           //     child: SizedBox(
                              //           //         height: getSize(64),
                              //           //         width: getSize(64),
                              //           //         child:
                              //           //             CircularProgressIndicator(
                              //           //                 color: Colors.white,
                              //           //                 value: 0.5,
                              //           //                 strokeWidth:
                              //           //                     getHorizontalSize(
                              //           //                         4))
                              //           //     )
                              //           // ),
                              //           Padding(
                              //               padding: getPadding(top: 6, left: 30, right: 30),
                              //               child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text(
                              //                         "msg_profile_completeness"
                              //                             .tr,
                              //                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                              //                     ),
                              //                     Opacity(
                              //                         opacity: 0.8,
                              //                         child: Container(
                              //                             width:
                              //                                 getHorizontalSize(
                              //                                     199),
                              //                             margin: getMargin(
                              //                                 top: 6),
                              //                             child: Text(
                              //                                 "msg_quality_profiles"
                              //                                     .tr,
                              //                                 maxLines: 2,
                              //                                 overflow:
                              //                                     TextOverflow
                              //                                         .ellipsis,
                              //                                 style: CustomTextStyles
                              //                                     .bodySmallOnPrimaryContainer
                              //                                     .copyWith(
                              //                                         height:
                              //                                             1.67, color: Colors.white))))
                              //                   ]))
                              //         ])),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: getPadding(top: 32),
                                      child: Text("lbl_account".tr,
                                          style: CustomTextStyles
                                              .labelLargeSemiBold))),
                              Semantics(
                                label: "Button: my personal information button",
                                child: SizedBox(
                                  height: 48,
                                  child: GestureDetector(
                                      onTap: () {
                                        onTapAccount(context);
                                      },
                                      child: Padding(
                                          padding: getPadding(top: 15),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Semantics(
                                                  label: "personal information button icon",
                                                  child: CustomImageView(
                                                      svgPath:
                                                          ImageConstant.imgPerson,
                                                      height: getSize(24),
                                                      width: getSize(24),
                                                      margin: getMargin(top: 3)),
                                                ),
                                                Padding(
                                                    padding: getPadding(
                                                        left: 12, top: 5),
                                                    child: Text(
                                                        "lbl_personal_info".tr,
                                                        style: theme.textTheme
                                                            .titleMedium)),
                                                Spacer(),
                                                Semantics(
                                                  label: "Button: personal information button icon 2",
                                                  child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgArrowrightPrimary,
                                                      height: getSize(24),
                                                      width: getSize(24),
                                                      margin: getMargin(bottom: 3)),
                                                )
                                              ]))),
                                ),
                              ),
                              Padding(
                                  padding: getPadding(top: 16),
                                  child:
                                      Divider(indent: getHorizontalSize(36))),
                              Semantics(
                                label: "Button: professional information button",
                                child: SizedBox(
                                  height: 48,
                                  child: GestureDetector(
                                      onTap: () {
                                        onTapPrivacy(context);
                                      },
                                      child: Padding(
                                          padding: getPadding(top: 15),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Semantics(
                                                  label: "Button: professional information button icon",
                                                  child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgUserPrimary,
                                                      height: getSize(24),
                                                      width: getSize(24),
                                                      margin: getMargin(top: 3)),
                                                ),
                                                Padding(
                                                    padding: getPadding(
                                                        left: 12, top: 7),
                                                    child: Text(
                                                        "Professional info",
                                                        style: theme.textTheme
                                                            .titleMedium)),
                                                Spacer(),
                                                Semantics(
                                                  label: "professional information button icon 2",
                                                  child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgArrowrightPrimary,
                                                      height: getSize(24),
                                                      width: getSize(24),
                                                      margin: getMargin(bottom: 4)),
                                                )
                                              ]))),
                                ),
                              ),
                              // Padding(
                              //     padding: getPadding(top: 14),
                              //     child:
                              //         Divider(indent: getHorizontalSize(36))),
                              // Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: Padding(
                              //         padding: getPadding(top: 26),
                              //         child: Text("lbl_general".tr,
                              //             style: CustomTextStyles
                              //                 .labelLargeSemiBold))),
                              // GestureDetector(
                              //     onTap: () {
                              //       onTapNotification(context);
                              //     },
                              //     child: Padding(
                              //         padding: getPadding(top: 15),
                              //         child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.end,
                              //             children: [
                              //               CustomImageView(
                              //                   svgPath:
                              //                       ImageConstant.imgBell,
                              //                   height: getSize(24),
                              //                   width: getSize(24),
                              //                   margin: getMargin(top: 2)),
                              //               Padding(
                              //                   padding: getPadding(
                              //                       left: 12, top: 2),
                              //                   child: Text(
                              //                       "lbl_notification".tr,
                              //                       style: CustomTextStyles
                              //                           .titleMediumPoppins)),
                              //               Spacer(),
                              //               CustomImageView(
                              //                   svgPath: ImageConstant
                              //                       .imgArrowrightPrimary,
                              //                   height: getSize(24),
                              //                   width: getSize(24),
                              //                   margin: getMargin(bottom: 2))
                              //             ]))),
                              // Padding(
                              //     padding: getPadding(top: 16),
                              //     child:
                              //         Divider(indent: getHorizontalSize(36))),
                              // GestureDetector(
                              //     onTap: () {
                              //       onTapLanguage(context);
                              //     },
                              //     child: Padding(
                              //         padding: getPadding(top: 15),
                              //         child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.end,
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.end,
                              //             children: [
                              //               CustomImageView(
                              //                   svgPath:
                              //                       ImageConstant.imgGlobe,
                              //                   height: getSize(24),
                              //                   width: getSize(24),
                              //                   margin: getMargin(top: 2)),
                              //               Padding(
                              //                   padding: getPadding(
                              //                       left: 12, top: 7),
                              //                   child: Text("lbl_language".tr,
                              //                       style: theme.textTheme
                              //                           .titleMedium)),
                              //               Spacer(),
                              //               CustomImageView(
                              //                   svgPath: ImageConstant
                              //                       .imgArrowrightPrimary,
                              //                   height: getSize(24),
                              //                   width: getSize(24),
                              //                   margin: getMargin(bottom: 4))
                              //             ]))),
                              // Padding(
                              //     padding: getPadding(top: 14),
                              //     child:
                              //         Divider(indent: getHorizontalSize(36))),
                              // Padding(
                              //     padding: getPadding(top: 15),
                              //     child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.end,
                              //         children: [
                              //           CustomImageView(
                              //               svgPath:
                              //                   ImageConstant.imgShielddone,
                              //               height: getSize(24),
                              //               width: getSize(24)),
                              //           Padding(
                              //               padding:
                              //                   getPadding(left: 12, top: 4),
                              //               child: Text("lbl_security".tr,
                              //                   style: theme
                              //                       .textTheme.titleMedium)),
                              //           Spacer(),
                              //           CustomImageView(
                              //               svgPath: ImageConstant
                              //                   .imgArrowrightPrimary,
                              //               height: getSize(24),
                              //               width: getSize(24))
                              //         ])),
                              // Padding(
                              //     padding: getPadding(top: 14),
                              //     child:
                              //         Divider(indent: getHorizontalSize(36))),
                              // Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: Padding(
                              //         padding: getPadding(top: 26),
                              //         child: Text("lbl_about".tr,
                              //             style: CustomTextStyles
                              //                 .labelLargeSemiBold))),
                              // GestureDetector(
                              //     onTap: () {
                              //       onTapLegalandpolicie(context);
                              //     },
                              //     child: Padding(
                              //         padding: getPadding(top: 16),
                              //         child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.end,
                              //             children: [
                              //               CustomImageView(
                              //                   svgPath:
                              //                       ImageConstant.imgShield,
                              //                   height: getSize(24),
                              //                   width: getSize(24)),
                              //               Padding(
                              //                   padding: getPadding(
                              //                       left: 12, top: 4),
                              //                   child: Text(
                              //                       "msg_legal_and_policies"
                              //                           .tr,
                              //                       style: theme.textTheme
                              //                           .titleMedium)),
                              //               Spacer(),
                              //               CustomImageView(
                              //                   svgPath: ImageConstant
                              //                       .imgArrowrightPrimary,
                              //                   height: getSize(24),
                              //                   width: getSize(24))
                              //             ]))),
                              // Padding(
                              //     padding: getPadding(top: 15),
                              //     child:
                              //         Divider(indent: getHorizontalSize(36))),
                              // Padding(
                              //     padding: getPadding(top: 16),
                              //     child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.end,
                              //         children: [
                              //           CustomImageView(
                              //               svgPath: ImageConstant
                              //                   .imgQuestionPrimary,
                              //               height: getSize(24),
                              //               width: getSize(24)),
                              //           Padding(
                              //               padding:
                              //                   getPadding(left: 12, top: 4),
                              //               child: Text(
                              //                   "lbl_help_feedback".tr,
                              //                   style: theme
                              //                       .textTheme.titleMedium)),
                              //           Spacer(),
                              //           CustomImageView(
                              //               svgPath: ImageConstant
                              //                   .imgArrowrightPrimary,
                              //               height: getSize(24),
                              //               width: getSize(24))
                              //         ])),
                              Padding(
                                  padding: getPadding(top: 17),
                                  child:
                                      Divider(indent: getHorizontalSize(36))),

                              // Padding(
                              //     padding: getPadding(top: 16),
                              //     child: Row(
                              //         mainAxisAlignment:
                              //         MainAxisAlignment.end,
                              //         children: [
                              //           CustomImageView(
                              //               svgPath: ImageConstant
                              //                   .imgQuestionPrimary,
                              //               height: getSize(24),
                              //               width: getSize(24)),
                              //           Padding(
                              //               padding:
                              //               getPadding(left: 12, top: 4),
                              //               child: Text(
                              //                   "About Fotisia",
                              //                   style: theme
                              //                       .textTheme.titleMedium)),
                              //           Spacer(),
                              //           // CustomImageView(
                              //           //     svgPath: ImageConstant
                              //           //         .imgArrowrightPrimary,
                              //           //     height: getSize(24),
                              //           //     width: getSize(24))
                              //         ])),

                              SizedBox(height: mediaQueryData.size.height * 0.3,),
                              Padding(
                                padding: getPadding(top: 17),
                                child: const Text(
                                  "This app was created as an entry to the Google Gemini API Developer competition. \nWe hope to see you again, soon! \nBye for now!!! 👋🏽",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Padding(
                                  padding: getPadding(top: 17),
                                  child:
                                  Divider()
                              ),

                              // Padding(
                              //     padding: getPadding(top: 16),
                              //     child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.end,
                              //         children: [
                              //           CustomImageView(
                              //               svgPath: ImageConstant.imgAlert,
                              //               height: getSize(24),
                              //               width: getSize(24)),
                              //           Padding(
                              //               padding:
                              //                   getPadding(left: 12, top: 2),
                              //               child: Text("lbl_about_us".tr,
                              //                   style: theme
                              //                       .textTheme.titleMedium)),
                              //           Spacer(),
                              //           CustomImageView(
                              //               svgPath: ImageConstant
                              //                   .imgArrowrightPrimary,
                              //               height: getSize(24),
                              //               width: getSize(24))
                              //         ])),
                              Align(
                                  alignment: Alignment.center,
                                  child: Semantics(
                                    label: "Button: Logout of fotisia, You personal career assistant",
                                    child: GestureDetector(
                                        onTap: () {
                                          onTapTxtLargelabelmediu(context);
                                        },
                                        child: SizedBox(
                                          height: 48,
                                          width: mediaQueryData.size.width * 0.9,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("lbl_logout".tr,
                                                style: CustomTextStyles
                                                    .titleMediumRedA200),
                                          ),
                                        )),
                                  ))
                            ])))),
          ),
          // bottomNavigationBar:
          //     CustomBottomBar(onChanged: (BottomBarEnum type) {
          //   Navigator.pushNamed(
          //       navigatorKey.currentContext!, getCurrentRoute(type));
          // })
      );
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.chatbot:
        return AppRoutes.messagePage;
      case BottomBarEnum.connect:
        return AppRoutes.profilePage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
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
      case AppRoutes.messagePage:
        return MessagePage.builder(context);
      case AppRoutes.savedPage:
        return SavedPage.builder(context);
      case AppRoutes.profilePage:
        return ProfilePage.builder(context);
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapArrowbackone(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the personalInfoScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the personalInfoScreen.
  onTapAccount(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.personalInfoScreen,
    );
  }

  /// Navigates to the experienceSettingScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the experienceSettingScreen.
  onTapPrivacy(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.experienceSettingScreen,
    );
  }

  /// Navigates to the notificationsScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the notificationsScreen.
  onTapNotification(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.notificationsScreen,
    );
  }

  /// Navigates to the languageScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the languageScreen.
  onTapLanguage(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.languageScreen,
    );
  }

  /// Navigates to the privacyScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the privacyScreen.
  onTapLegalandpolicie(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.privacyScreen,
    );
  }

  /// Displays an [AlertDialog] with a custom content widget using the
  /// provided [BuildContext].
  ///
  /// The custom content widget is created by calling
  /// [LogoutPopupDialog.builder] method.
  onTapTxtLargelabelmediu(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: LogoutPopupDialog.builder(context),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
  }
}
