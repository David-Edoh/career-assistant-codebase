import 'bloc/chat_bloc.dart';
import 'models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';

class InboxChatScreen extends StatelessWidget {
  const InboxChatScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(ChatState(chatModelObj: ChatModel()))
          ..add(ChatInitialEvent()),
        child: InboxChatScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            resizeToAvoidBottomInset: false,
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
                title: AppbarTitle(text: "David")),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 28, right: 24, bottom: 28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: getPadding(right: 80),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(32),
                                    width: getSize(32),
                                    margin: getMargin(bottom: 36),
                                    child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgImage56x56,
                                              height: getSize(32),
                                              width: getSize(32),
                                              radius: BorderRadius.circular(
                                                  getHorizontalSize(16)),
                                              alignment: Alignment.center),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                  height: getSize(8),
                                                  width: getSize(8),
                                                  decoration: BoxDecoration(
                                                      color: appTheme.tealA700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  4)),
                                                      border: Border.all(
                                                          color: theme
                                                              .colorScheme
                                                              .onPrimaryContainer
                                                              .withOpacity(1),
                                                          width:
                                                              getHorizontalSize(
                                                                  1)))))
                                        ])),
                                Container(
                                    margin: getMargin(left: 12),
                                    padding: getPadding(
                                        left: 12,
                                        top: 10,
                                        right: 12,
                                        bottom: 10),
                                    decoration: AppDecoration.fillGray.copyWith(
                                        borderRadius: BorderRadiusStyle
                                            .customBorderTL241),
                                    child: Container(
                                        width: getHorizontalSize(164),
                                        margin: getMargin(top: 4, right: 14),
                                        child: Text("Hi, Glorious",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .titleSmallGray600
                                                .copyWith(height: 1.57)
                                        )
                                    )
                                )
                              ])),
                      Padding(
                          padding: getPadding(left: 44, top: 6),
                          child: Text("lbl_15_42_pm".tr,
                              style: CustomTextStyles.labelMediumBluegray300)),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: getPadding(left: 97, top: 26),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                        child: CustomElevatedButton(
                                            height: getVerticalSize(46),
                                            text: "Hellooooo",
                                            buttonStyle: CustomButtonStyles
                                                .fillPrimaryTL24,
                                            buttonTextStyle: CustomTextStyles
                                                .titleSmallGray5001_1)),
                                    CustomImageView(
                                        imagePath:
                                            ImageConstant.imageProfilePicture,
                                        height: getSize(32),
                                        width: getSize(32),
                                        margin: getMargin(
                                            left: 12, top: 7, bottom: 7))
                                  ]))),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: getPadding(top: 6, right: 44),
                              child: Text("lbl_15_42_pm".tr,
                                  style: CustomTextStyles
                                      .labelMediumBluegray300))),
                      Padding(
                          padding: getPadding(top: 26, right: 80),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(32),
                                    width: getSize(32),
                                    margin: getMargin(bottom: 36),
                                    child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgImage56x56,
                                              height: getSize(32),
                                              width: getSize(32),
                                              radius: BorderRadius.circular(
                                                  getHorizontalSize(16)),
                                              alignment: Alignment.center),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                  height: getSize(8),
                                                  width: getSize(8),
                                                  decoration: BoxDecoration(
                                                      color: appTheme.tealA700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  4)),
                                                      border: Border.all(
                                                          color: theme
                                                              .colorScheme
                                                              .onPrimaryContainer
                                                              .withOpacity(1),
                                                          width:
                                                              getHorizontalSize(
                                                                  1)))))
                                        ])),
                                Container(
                                    margin: getMargin(left: 12),
                                    padding: getPadding(
                                        left: 12,
                                        top: 10,
                                        right: 12,
                                        bottom: 10),
                                    decoration: AppDecoration.fillGray.copyWith(
                                        borderRadius: BorderRadiusStyle
                                            .customBorderTL241),
                                    child: Container(
                                        width: getHorizontalSize(164),
                                        margin: getMargin(top: 4, right: 14),
                                        child: Text("How are you doing?",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .titleSmallGray600
                                                .copyWith(height: 1.57))))
                              ])),
                      Padding(
                          padding: getPadding(left: 44, top: 6, bottom: 5),
                          child: Text("lbl_15_42_pm".tr,
                              style: CustomTextStyles.labelMediumBluegray300))
                    ])),
            // bottomNavigationBar:
            //     BlocSelector<ChatBloc, ChatState, TextEditingController?>(
            //         selector: (state) => state.messageController,
            //         builder: (context, messageController) {
            //           return CustomTextFormField(
            //               controller: messageController,
            //               margin: getMargin(left: 24, right: 24, bottom: 40),
            //               hintText: "msg_type_your_message".tr,
            //               hintStyle: CustomTextStyles.labelLargeGray600,
            //               textInputAction: TextInputAction.done,
            //               contentPadding: getPadding(
            //                   left: 30, top: 20, right: 30, bottom: 20),
            //               borderDecoration: TextFormFieldStyleHelper.fillGray,
            //               fillColor: appTheme.gray20001);
            //         })
        ));
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
