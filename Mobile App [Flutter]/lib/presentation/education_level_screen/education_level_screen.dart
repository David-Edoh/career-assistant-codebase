import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/custom_text_form_field.dart';
import 'bloc/education_level_bloc.dart';
import 'models/education_level_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_checkbox_button.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_radio_button.dart';
import 'package:fotisia/presentation/confirmation_dialog/confirmation_dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EducationLevelScreen extends StatelessWidget {
  EducationLevelScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<EducationLevelBloc>(
        create: (context) => EducationLevelBloc(EducationLevelState(
            EducationLevelModelObj: EducationLevelModel()))
          ..add(EducationLevelInitialEvent()),
        child: EducationLevelScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
      resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 23, top: 13, right: 23, bottom: 13),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Semantics(
                          label: "back to previous page",
                          child: SizedBox(
                            height: 48,
                            child: CustomImageView(
                                svgPath: ImageConstant.imgGroup162799,
                                color: Colors.white,
                                height: getSize(24),
                                width: getSize(24),
                                alignment: Alignment.centerLeft,
                                margin: getMargin(left: 1),
                                onTap: () {
                                  onTapImgImage(context);
                                }),
                          ),
                        ),
                        Container(
                            // width: getHorizontalSize(177),
                            margin: getMargin(top: 11),
                            child: Text("What is your current level of education?",
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall!
                                    .copyWith(height: 1.33, color: Colors.white))),
                        Padding(
                            padding: getPadding(top: 50),
                            child: BlocBuilder<EducationLevelBloc,
                                EducationLevelState>(builder: (context, state) {
                              return state.EducationLevelModelObj!.radioList
                                      .isNotEmpty
                                  ? Column(children: [
                                      Semantics(
                                        label: "Option: High school diploma/GED?",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "High school diploma/GED",
                                              value: state.EducationLevelModelObj
                                                      ?.radioList[0] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<EducationLevelBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                        value: value));
                                              }),
                                        ),
                                      ),
                                      Semantics(
                                        label: "Option: Associate's degree or college?",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Associate's degree or college",
                                              value: state.EducationLevelModelObj?.radioList[1] ?? "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                    context.read<EducationLevelBloc>().add(ChangeRadioButtonEvent(value: value)
                                                  );
                                                }
                                              ),
                                        ),
                                      ),
                                      Semantics(
                                        label: "Option: Bachelor's degree?",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Bachelor's degree",
                                              value: state.EducationLevelModelObj
                                                      ?.radioList[2] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<EducationLevelBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                        value: value));
                                              }),
                                        ),
                                      ),
                                      Semantics(
                                        label: "Option: Master's degree or higher",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Master's degree or higher",
                                              value: state.EducationLevelModelObj
                                                  ?.radioList[3] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<EducationLevelBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                    value: value));
                                              }),
                                        ),
                                      ),
                                      Semantics(
                                        label: "Option: Select this option if you will like to type out your education level... (if your option is not listed, please specify it in the form below)",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Other (please specify)",
                                              value: state.EducationLevelModelObj
                                                  ?.radioList[4] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<EducationLevelBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                    value: value));
                                              }
                                            ),
                                        ),
                                      ),

                                    state.radioGroup == "others" ?  Semantics(
                                      label: "Enter your current education level, in details",
                                      child: CustomTextFormField(
                                          controller: state.othersTextController,
                                          margin: getMargin(top: 9),
                                          hintText: "Tell us more",
                                          hintStyle:
                                          CustomTextStyles.titleMediumBluegray400,
                                          textInputAction: TextInputAction.done,
                                          textInputType: TextInputType.emailAddress,
                                          onChange: (value) {
                                            context.read<EducationLevelBloc>().add(SetOthersTextEvent(value: value));
                                          },
                                          validator: (value) {
                                            if ( state.radioGroup == "others" && value == null ) {
                                              return "more information required";
                                            }
                                            return null;
                                          },
                                          contentPadding: getPadding (
                                              left: 12,
                                              top: 20,
                                              right: 12,
                                              bottom: 20
                                          )
                                      ),
                                    ) : Container(),

                                      CustomElevatedButton(
                                          text: "lbl_continue".tr,
                                          margin: getMargin(top: 39),
                                          buttonStyle: CustomButtonStyles.fillPrimary,
                                          onTap: () {
                                            onTapSpecializationPage(context, state);
                                          })
                                    ])
                                  : Container();
                            })),
                      ])),
            ),
          ),
        ),
    );
  }

  onTapSpecializationPage(BuildContext context, EducationLevelState state) {
    const storage = FlutterSecureStorage();

    if(state.radioGroup == "") {
      Fluttertoast.showToast(msg: "Please select an option to proceed.", toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (_formKey.currentState!.validate() && state.radioGroup != "" && state.radioGroup != "others") {
      storage.write(key: "education_level", value: state.radioGroup);
      NavigatorService.pushNamed(
        AppRoutes.speciallizationScreen,
      );
    }

    if (_formKey.currentState!.validate() && state.radioGroup != "" && state.radioGroup == "others") {
      if(state.othersText == null || state.othersText!.isEmpty)
      {
        Fluttertoast.showToast(msg: "Please provide more information to proceed.", toastLength: Toast.LENGTH_LONG);
        return;
      }
      storage.write(key: "education_level", value: state.othersText);
      NavigatorService.pushNamed(
        AppRoutes.speciallizationScreen,
      );
    }
  }

  /// Displays an [AlertDialog] with a custom content widget using the
  /// provided [BuildContext].
  ///
  /// The custom content widget is created by calling
  /// [ConfirmationDialog.builder] method.
  onTapContinue(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: ConfirmationDialog.builder(context),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
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
}
