import 'bloc/privacy_bloc.dart';
import 'models/privacy_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<PrivacyBloc>(
        create: (context) =>
            PrivacyBloc(PrivacyState(privacyModelObj: PrivacyModel()))
              ..add(PrivacyInitialEvent()),
        child: PrivacyScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<PrivacyBloc, PrivacyState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: appTheme.whiteA70001,
              appBar: CustomAppBar(
                  height: getVerticalSize(70),
                  leadingWidth: getHorizontalSize(50),
                  leading: AppbarImage(
                      svgPath: ImageConstant.imgGroup162799,
                      margin: getMargin(left: 24, top: 13, bottom: 14),
                      onTap: () {
                        onTapArrowbackone(context);
                      }),
                  centerTitle: true,
                  title: AppbarTitle(text: "msg_legel_and_policies".tr)),
              body: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 24, right: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: getPadding(top: 30),
                            child: Text("lbl_terms".tr,
                                style: CustomTextStyles.titleMediumBold_1)),
                        Opacity(
                            opacity: 0.5,
                            child: Container(
                                width: getHorizontalSize(307),
                                margin: getMargin(top: 11, right: 19),
                                child: Text("msg_lorem_ipsum_dolor9".tr,
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles
                                        .titleSmallBluegray400_2
                                        .copyWith(height: 1.57)))),
                        Opacity(
                            opacity: 0.5,
                            child: Container(
                                width: getHorizontalSize(307),
                                margin: getMargin(top: 4, right: 19),
                                child: Text("msg_lorem_ipsum_dolor9".tr,
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles
                                        .titleSmallBluegray400_2
                                        .copyWith(height: 1.57)))),
                        Padding(
                            padding: getPadding(top: 21),
                            child: Text("msg_changes_to_the_service".tr,
                                style: CustomTextStyles.titleMediumBold_1)),
                        Container(
                            height: getVerticalSize(298),
                            width: getHorizontalSize(307),
                            margin: getMargin(top: 7),
                            child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Opacity(
                                          opacity: 0.5,
                                          child: SizedBox(
                                              width: getHorizontalSize(307),
                                              child: Text(
                                                  "msg_lorem_ipsum_dolor9".tr,
                                                  maxLines: 7,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray400_2
                                                      .copyWith(
                                                          height: 1.57))))),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Opacity(
                                          opacity: 0.5,
                                          child: SizedBox(
                                              width: getHorizontalSize(307),
                                              child: Text(
                                                  "msg_lorem_ipsum_dolor9".tr,
                                                  maxLines: 7,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray400_2
                                                      .copyWith(
                                                          height: 1.57)))))
                                ]))
                      ]))));
    });
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
}
