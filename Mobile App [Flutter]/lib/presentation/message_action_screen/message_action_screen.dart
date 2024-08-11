import '../message_action_screen/widgets/message_action_item_widget.dart';
import 'bloc/message_action_bloc.dart';
import 'models/message_action_item_model.dart';
import 'models/message_action_model.dart';
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
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class MessageActionScreen extends StatelessWidget {
  MessageActionScreen({Key? key}) : super(key: key);

  // GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<MessageActionBloc>(
        create: (context) => MessageActionBloc(
            MessageActionState(messageActionModelObj: MessageActionModel()))
          ..add(MessageActionInitialEvent()),
        child: MessageActionScreen());
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
                title: AppbarTitle(text: "lbl_message".tr)),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(top: 24, bottom: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocSelector<MessageActionBloc, MessageActionState,
                              TextEditingController?>(
                          selector: (state) => state.searchController,
                          builder: (context, searchController) {
                            return CustomSearchView(
                                margin: getMargin(left: 24, top: 4, right: 24),
                                controller: searchController,
                                hintText: "msg_search_message".tr,
                                hintStyle:
                                    CustomTextStyles.titleMediumBluegray400,
                                prefix: Container(
                                    margin: getMargin(
                                        left: 16,
                                        top: 17,
                                        right: 8,
                                        bottom: 17),
                                    child: CustomImageView(
                                        svgPath: ImageConstant.imgSearch)),
                                prefixConstraints: BoxConstraints(
                                    maxHeight: getVerticalSize(52)),
                                suffix: Container(
                                    margin: getMargin(
                                        left: 30,
                                        top: 17,
                                        right: 16,
                                        bottom: 17),
                                    child: CustomImageView(
                                        svgPath: ImageConstant.imgInfo)),
                                suffixConstraints: BoxConstraints(
                                    maxHeight: getVerticalSize(52)),
                                borderDecoration:
                                    SearchViewStyleHelper.outlineIndigo);
                          }),
                      Expanded(
                          child: Padding(
                              padding: getPadding(top: 24),
                              child: BlocSelector<MessageActionBloc,
                                      MessageActionState, MessageActionModel?>(
                                  selector: (state) =>
                                      state.messageActionModelObj,
                                  builder: (context, messageActionModelObj) {
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
                                        itemCount: messageActionModelObj
                                                ?.messageActionItemList
                                                .length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          MessageActionItemModel model =
                                              messageActionModelObj
                                                          ?.messageActionItemList[
                                                      index] ??
                                                  MessageActionItemModel();
                                          return MessageActionItemWidget(model,
                                              onTapChat: () {
                                            onTapChat(context);
                                          }, onTapRowesther: () {
                                            onTapRowesther(context);
                                          });
                                        });
                                  }))),
                      Spacer(),
                      CustomElevatedButton(
                          height: getVerticalSize(46),
                          width: getHorizontalSize(137),
                          text: "lbl_new_chat".tr,
                          margin: getMargin(right: 24),
                          leftIcon: Container(
                              margin: getMargin(right: 4),
                              child: CustomImageView(
                                  svgPath: ImageConstant.imgPlusGray5001)),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                          buttonTextStyle: CustomTextStyles.titleSmallGray5001,
                          alignment: Alignment.centerRight)
                    ])),
            // bottomNavigationBar:
            //     CustomBottomBar(onChanged: (BottomBarEnum type) {
            //   Navigator.pushNamed(
            //       navigatorKey.currentContext!, getCurrentRoute(type));
            // })
        )
    );
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

  /// Navigates to the chatScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the chatScreen.
  onTapChat(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.chatScreen);
  }

  /// Navigates to the chatScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the chatScreen.
  onTapRowesther(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.chatScreen);
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
