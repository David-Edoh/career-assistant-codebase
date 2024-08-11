import '../filter_bottomsheet/widgets/chipviewjobs_item_widget.dart';
import 'bloc/filter_bloc.dart';
import 'models/chipviewjobs_item_model.dart';
import 'models/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';

class FilterBottomsheet extends StatelessWidget {
  const FilterBottomsheet({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<FilterBloc>(
        create: (context) =>
            FilterBloc(FilterState(filterModelObj: FilterModel()))
              ..add(FilterInitialEvent()),
        child: FilterBottomsheet());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Container(
        width: double.maxFinite,
        padding: getPadding(left: 24, top: 25, right: 24, bottom: 25),
        decoration: AppDecoration.fillWhiteA70001
            .copyWith(borderRadius: BorderRadiusStyle.customBorderTL24),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                CustomImageView(
                    svgPath: ImageConstant.imgClose,
                    height: getSize(24),
                    width: getSize(24),
                    onTap: () {
                      onTapImgCloseone(context);
                    }),
                Padding(
                    padding: getPadding(left: 16),
                    child: Text("lbl_filter".tr,
                        style: CustomTextStyles.titleMedium18)),
                Spacer(),
                Padding(
                    padding: getPadding(top: 3, bottom: 2),
                    child: Text("lbl_reset_filters".tr,
                        style: CustomTextStyles.titleSmallDeeporangeA200))
              ]),
              Padding(
                  padding: getPadding(top: 29),
                  child: Text("lbl_categories".tr,
                      style: CustomTextStyles.titleMediumBold_1)),
              Padding(
                  padding: getPadding(top: 14, right: 51),
                  child: Row(children: [
                    CustomElevatedButton(
                        height: getVerticalSize(44),
                        width: getHorizontalSize(159),
                        text: "msg_design_creative".tr,
                        leftIcon: Container(
                            margin: getMargin(right: 5),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgCheckmarkGray5001)),
                        buttonStyle: CustomButtonStyles.fillDeepOrangeA,
                        buttonTextStyle:
                            CustomTextStyles.labelLargeGray5001SemiBold_1),
                    CustomOutlinedButton(
                        width: getHorizontalSize(100),
                        text: "lbl_finance".tr,
                        margin: getMargin(left: 16),
                        leftIcon: Container(
                            margin: getMargin(right: 4),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgPlus)))
                  ])),
              Padding(
                  padding: getPadding(top: 10, right: 3),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomOutlinedButton(
                            width: getHorizontalSize(211),
                            text: "msg_engineering_architecture".tr,
                            leftIcon: Container(
                                margin: getMargin(right: 4),
                                child: CustomImageView(
                                    svgPath: ImageConstant.imgPlus))),
                        CustomOutlinedButton(
                            width: getHorizontalSize(96),
                            text: "lbl_writing".tr,
                            leftIcon: Container(
                                margin: getMargin(right: 4),
                                child: CustomImageView(
                                    svgPath: ImageConstant.imgPlus)))
                      ])),
              Padding(
                  padding: getPadding(top: 10, right: 38),
                  child: Row(children: [
                    CustomOutlinedButton(
                        width: getHorizontalSize(114),
                        text: "lbl_marketing".tr,
                        leftIcon: Container(
                            margin: getMargin(right: 5),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgPlus))),
                    CustomOutlinedButton(
                        width: getHorizontalSize(158),
                        text: "msg_development_it".tr,
                        margin: getMargin(left: 16),
                        leftIcon: Container(
                            margin: getMargin(right: 5),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgPlus)))
                  ])),
              Padding(
                  padding: getPadding(top: 26),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("lbl_salaries".tr,
                            style: CustomTextStyles.titleMediumBold_1),
                        Padding(
                            padding: getPadding(top: 2, bottom: 2),
                            child: Text("lbl_6_000_month".tr,
                                style:
                                    CustomTextStyles.labelLargeDeeporangeA200))
                      ])),
              Padding(
                  padding: getPadding(top: 16),
                  child: SliderTheme(
                      data: SliderThemeData(
                          trackShape: RoundedRectSliderTrackShape(),
                          activeTrackColor: appTheme.deepOrangeA200,
                          inactiveTrackColor: appTheme.blueGray5001,
                          thumbColor: theme.colorScheme.onPrimaryContainer
                              .withOpacity(1),
                          thumbShape: RoundSliderThumbShape()),
                      child: Slider(
                          value: 52.91,
                          min: 0.0,
                          max: 100.0,
                          onChanged: (value) {}))),
              Padding(
                  padding: getPadding(top: 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("lbl_560".tr,
                            style: CustomTextStyles.labelLargeSemiBold),
                        Text("lbl_12_000".tr,
                            style: CustomTextStyles.labelLargeSemiBold)
                      ])),
              Padding(
                  padding: getPadding(top: 28),
                  child: Text("lbl_jobs".tr,
                      style: CustomTextStyles.titleMediumBold_1)),
              Padding(
                  padding: getPadding(top: 16),
                  child: BlocSelector<FilterBloc, FilterState, FilterModel?>(
                      selector: (state) => state.filterModelObj,
                      builder: (context, filterModelObj) {
                        return Wrap(
                            runSpacing: getVerticalSize(16),
                            spacing: getHorizontalSize(16),
                            children: List<Widget>.generate(
                                filterModelObj?.chipviewjobsItemList.length ??
                                    0, (index) {
                              ChipviewjobsItemModel model =
                                  filterModelObj?.chipviewjobsItemList[index] ??
                                      ChipviewjobsItemModel();
                              return ChipviewjobsItemWidget(model,
                                  onSelectedChipView: (value) {
                                context.read<FilterBloc>().add(
                                    UpdateChipViewEvent(
                                        index: index, isSelected: value));
                              });
                            }));
                      })),
              CustomElevatedButton(
                  text: "lbl_apply_filters".tr,
                  margin: getMargin(top: 30, bottom: 15),
                  buttonStyle: CustomButtonStyles.fillPrimary)
            ]));
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapImgCloseone(BuildContext context) {
    NavigatorService.goBack();
  }
}
