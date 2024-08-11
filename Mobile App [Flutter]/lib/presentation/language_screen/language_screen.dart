import '../language_screen/widgets/listchineses_item_widget.dart';
import '../language_screen/widgets/listenglishuk_item_widget.dart';
import 'bloc/language_bloc.dart';
import 'models/language_model.dart';
import 'models/listchineses_item_model.dart';
import 'models/listenglishuk_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LanguageBloc>(
        create: (context) =>
            LanguageBloc(LanguageState(languageModelObj: LanguageModel()))
              ..add(LanguageInitialEvent()),
        child: LanguageScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
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
                title: AppbarTitle(text: "lbl_language".tr)),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 28, right: 24, bottom: 28),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Container(
                                  padding: getPadding(
                                      left: 16, top: 21, right: 16, bottom: 21),
                                  decoration: AppDecoration.outlineIndigo
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder12),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: getPadding(top: 2),
                                            child: Text(
                                                "msg_suggested_languages".tr,
                                                style: CustomTextStyles
                                                    .labelLargeSemiBold)),
                                        Expanded(
                                            child: Padding(
                                                padding: getPadding(top: 16),
                                                child: BlocSelector<
                                                        LanguageBloc,
                                                        LanguageState,
                                                        LanguageModel?>(
                                                    selector: (state) =>
                                                        state.languageModelObj,
                                                    builder: (context,
                                                        languageModelObj) {
                                                      return ListView.separated(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                                padding:
                                                                    getPadding(
                                                                        top:
                                                                            7.0,
                                                                        bottom:
                                                                            7.0),
                                                                child: SizedBox(
                                                                    width:
                                                                        getHorizontalSize(
                                                                            295),
                                                                    child: Divider(
                                                                        height:
                                                                            getVerticalSize(
                                                                                1),
                                                                        thickness:
                                                                            getVerticalSize(
                                                                                1),
                                                                        color: appTheme
                                                                            .indigo50)));
                                                          },
                                                          itemCount:
                                                              languageModelObj
                                                                      ?.listenglishukItemList
                                                                      .length ??
                                                                  0,
                                                          itemBuilder:
                                                              (context, index) {
                                                            ListenglishukItemModel
                                                                model =
                                                                languageModelObj
                                                                            ?.listenglishukItemList[
                                                                        index] ??
                                                                    ListenglishukItemModel();
                                                            return ListenglishukItemWidget(
                                                                model,
                                                                changeCheckBox:
                                                                    (value) {
                                                              context
                                                                  .read<
                                                                      LanguageBloc>()
                                                                  .add(ListenglishukItemEvent(
                                                                      index:
                                                                          index,
                                                                      englishuk:
                                                                          value));
                                                            });
                                                          });
                                                    })))
                                      ])))),
                      Expanded(
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Container(
                                  margin: getMargin(top: 24, bottom: 5),
                                  padding: getPadding(all: 16),
                                  decoration: AppDecoration.outlineIndigo
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder12),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: getPadding(top: 3),
                                            child: Text(
                                                "lbl_other_languages".tr,
                                                style: CustomTextStyles
                                                    .labelLargeSemiBold)),
                                        Expanded(
                                            child: Padding(
                                                padding: getPadding(top: 19),
                                                child: BlocSelector<
                                                        LanguageBloc,
                                                        LanguageState,
                                                        LanguageModel?>(
                                                    selector: (state) =>
                                                        state.languageModelObj,
                                                    builder: (context,
                                                        languageModelObj) {
                                                      return ListView.separated(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                                padding:
                                                                    getPadding(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8.0),
                                                                child: SizedBox(
                                                                    width:
                                                                        getHorizontalSize(
                                                                            295),
                                                                    child: Divider(
                                                                        height:
                                                                            getVerticalSize(
                                                                                1),
                                                                        thickness:
                                                                            getVerticalSize(
                                                                                1),
                                                                        color: appTheme
                                                                            .indigo50)));
                                                          },
                                                          itemCount:
                                                              languageModelObj
                                                                      ?.listchinesesItemList
                                                                      .length ??
                                                                  0,
                                                          itemBuilder:
                                                              (context, index) {
                                                            ListchinesesItemModel
                                                                model =
                                                                languageModelObj
                                                                            ?.listchinesesItemList[
                                                                        index] ??
                                                                    ListchinesesItemModel();
                                                            return ListchinesesItemWidget(
                                                                model);
                                                          });
                                                    })))
                                      ]))))
                    ]))));
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
