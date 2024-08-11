import '../message_page/widgets/message_item_widget.dart';
import 'bloc/message_bloc.dart';
import 'models/message_item_model.dart';
import 'models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_search_view.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<MessageBloc>(
        create: (context) =>
            MessageBloc(MessageState(messageModelObj: MessageModel()))
              ..add(MessageInitialEvent()),
        child: MessagePage());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
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
            title: AppbarTitle(text: "Inbox")),
        body: SafeArea(
          child: Container(
              width: double.maxFinite,
              padding: getPadding(all: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // BlocSelector<MessageBloc, MessageState,
                    //         TextEditingController?>(
                    //     selector: (state) => state.searchController,
                    //     builder: (context, searchController) {
                    //       return CustomSearchView(
                    //           margin: getMargin(top: 4),
                    //           controller: searchController,
                    //           hintText: "msg_search_message".tr,
                    //           hintStyle:
                    //               CustomTextStyles.titleMediumBluegray400,
                    //           prefix: Container(
                    //               margin: getMargin(
                    //                   left: 16,
                    //                   top: 17,
                    //                   right: 8,
                    //                   bottom: 17),
                    //               child: CustomImageView(
                    //                   svgPath: ImageConstant.imgSearch)),
                    //           prefixConstraints: BoxConstraints(
                    //               maxHeight: getVerticalSize(52)),
                    //           suffix: Container(
                    //               margin: getMargin(
                    //                   left: 30,
                    //                   top: 17,
                    //                   right: 16,
                    //                   bottom: 17),
                    //               child: CustomImageView(
                    //                   svgPath:
                    //                       ImageConstant.imgFilterPrimary)),
                    //           suffixConstraints: BoxConstraints(
                    //               maxHeight: getVerticalSize(52)),
                    //           contentPadding:
                    //               getPadding(top: 12, bottom: 12));
                    //     }),
                    Expanded(
                        child: Padding(
                            padding: getPadding(top: 2),
                            child: BlocSelector<MessageBloc, MessageState,
                                    MessageModel?>(
                                selector: (state) => state.messageModelObj,
                                builder: (context, messageModelObj) {
                                  return ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) {
                                        return Padding(
                                            padding: getPadding(
                                                top: 7.5, bottom: 7.5),
                                            child: SizedBox(
                                                width: getHorizontalSize(327),
                                                child: Divider(
                                                    height:
                                                        getVerticalSize(1),
                                                    thickness:
                                                        getVerticalSize(1),
                                                    color:
                                                        appTheme.indigo50)));
                                      },
                                      itemCount: messageModelObj
                                              ?.messageItemList.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        MessageItemModel model =
                                            messageModelObj?.messageItemList[
                                                    index] ??
                                                MessageItemModel();
                                        return MessageItemWidget(model,
                                            onTapRowesther: () {
                                          onTapRowesther(context);
                                        });
                                      });
                                }))),
                    // Spacer(),
                    CustomElevatedButton(
                        height: getVerticalSize(46),
                        width: getHorizontalSize(137),
                        text: "lbl_new_chat".tr,
                        leftIcon: Container(
                            margin: getMargin(right: 4),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgPlusGray5001)),
                        buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                        buttonTextStyle: CustomTextStyles.titleSmallGray5001)
                  ])),
        ));
  }

  /// Navigates to the chatScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the chatScreen.
  onTapRowesther(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.inboxChatScreen);
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
