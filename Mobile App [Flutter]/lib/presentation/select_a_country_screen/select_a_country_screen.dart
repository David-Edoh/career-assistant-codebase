import 'bloc/select_a_country_bloc.dart';
import 'models/select_a_country_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_radio_button.dart';
import 'package:fotisia/widgets/custom_search_view.dart';

class SelectACountryScreen extends StatelessWidget {
  const SelectACountryScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SelectACountryBloc>(
        create: (context) => SelectACountryBloc(
            SelectACountryState(selectACountryModelObj: SelectACountryModel()))
          ..add(SelectACountryInitialEvent()),
        child: SelectACountryScreen());
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
                    svgPath: ImageConstant.imgClose,
                    margin: getMargin(left: 24, top: 13, bottom: 14),
                    onTap: () {
                      onTapCloseone(context);
                    }),
                centerTitle: true,
                title: AppbarTitle(text: "msg_select_a_country2".tr)),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 13, right: 24, bottom: 13),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocSelector<SelectACountryBloc, SelectACountryState,
                              TextEditingController?>(
                          selector: (state) => state.searchController,
                          builder: (context, searchController) {
                            return CustomSearchView(
                                margin: getMargin(top: 12),
                                controller: searchController,
                                hintText: "lbl_search".tr,
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
                                suffix: Padding(
                                    padding: EdgeInsets.only(
                                        right: getHorizontalSize(15)),
                                    child: IconButton(
                                        onPressed: () {
                                          searchController!.clear();
                                        },
                                        icon: Icon(Icons.clear,
                                            color: Colors.grey.shade600))),
                                contentPadding:
                                    getPadding(top: 15, right: 30, bottom: 15),
                                borderDecoration:
                                    SearchViewStyleHelper.outlineIndigo);
                          }),
                      Padding(
                          padding: getPadding(top: 24),
                          child: BlocBuilder<SelectACountryBloc,
                              SelectACountryState>(builder: (context, state) {
                            return state.selectACountryModelObj!.radioList
                                    .isNotEmpty
                                ? Column(children: [
                                    CustomRadioButton(
                                        text: "lbl_afghanistan".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[0] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(right: 68),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_albania".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[1] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 22, right: 104),
                                        padding: getPadding(top: 1, bottom: 1),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_algeria".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[2] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 24, right: 107),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_andorra".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[3] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 22, right: 99),
                                        padding: getPadding(top: 1, bottom: 1),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }
                                        ),
                                    CustomRadioButton(
                                        text: "lbl_angola".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[4] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 24, right: 107),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "msg_antigua_and_barbuda".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[5] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 22),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_argentina".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[6] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 22, right: 85),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_argentina".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[7] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 22, right: 85),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_armenia".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[8] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 22, right: 97),
                                        padding: getPadding(top: 1, bottom: 1),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_australia".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[9] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 24, right: 94),
                                        padding: getPadding(top: 1, bottom: 1),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_austria".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[10] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 24, right: 107),
                                        padding: getPadding(top: 1, bottom: 1),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_azerbaijan".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[11] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 24, right: 80),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_azerbaijan".tr,
                                        value: state.selectACountryModelObj
                                                ?.radioList[12] ??
                                            "",
                                        groupValue: state.radioGroup,
                                        margin: getMargin(top: 22, right: 80),
                                        onChange: (value) {
                                          context
                                              .read<SelectACountryBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        })
                                  ])
                                : Container();
                          }))
                    ]))));
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapCloseone(BuildContext context) {
    NavigatorService.goBack();
  }
}
