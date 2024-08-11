import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/custom_text_form_field.dart';
import 'bloc/career_goals_bloc.dart';
import 'models/career_goals_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_checkbox_button.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_radio_button.dart';
import 'package:fotisia/presentation/confirmation_dialog/confirmation_dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CareerGoalsScreen extends StatelessWidget {
  CareerGoalsScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<CareerGoalsBloc>(
        create: (context) => CareerGoalsBloc(CareerGoalsState(
            careerGoalsModelObj: CareerGoalsModel()))
          ..add(CareerGoalsInitialEvent()),
        child: CareerGoalsScreen());
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
                          label: "Image: back to previous page",
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
                            margin: getMargin(top: 44),
                            child: Text("What are your primary career goals?",
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall!
                                    .copyWith(height: 1.33, color: Colors.white))),
                        Padding(
                            padding: getPadding(top: 15),
                            child: BlocBuilder<CareerGoalsBloc,
                                CareerGoalsState>(builder: (context, state) {
                              return state.careerGoalsModelObj!.radioList
                                      .isNotEmpty
                                  ? Column(children: [
                                      Semantics(
                                        label: "Option: Advance within your current field?",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Advance within your current field",
                                              value: state.careerGoalsModelObj
                                                      ?.radioList[0] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<CareerGoalsBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                        value: value));
                                              }),
                                        ),
                                      ),
                                      Semantics(
                                        label: "Option: Switch to a new field or industry?",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Switch to a new field or industry",
                                              value: state.careerGoalsModelObj
                                                      ?.radioList[1] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<CareerGoalsBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                        value: value));
                                              }),
                                        ),
                                      ),
                                      Semantics(
                                        label: "Option: Starting your own business?",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Starting your own business",
                                              value: state.careerGoalsModelObj
                                                      ?.radioList[2] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<CareerGoalsBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                        value: value));
                                              }),
                                        ),
                                      ),
                                      Semantics(
                                        label: "Option: Achieving work-life balance?",
                                        child: Container(
                                          margin: getMargin(left: 1, top: 16, bottom: 5),
                                          padding: getPadding(
                                              left: 16, top: 12, right: 16, bottom: 12),
                                          decoration: AppDecoration.outlineIndigo.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder24),
                                          child: CustomRadioButton(
                                              isRightCheck: true,
                                              text: "Achieving work-life balance",
                                              value: state.careerGoalsModelObj
                                                  ?.radioList[3] ??
                                                  "",
                                              groupValue: state.radioGroup,
                                              padding: getPadding(top: 1, bottom: 1),
                                              onChange: (value) {
                                                context
                                                    .read<CareerGoalsBloc>()
                                                    .add(ChangeRadioButtonEvent(
                                                    value: value));
                                              }),
                                        ),
                                      ),
                                //       Container(
                                //         margin: getMargin(left: 1, top: 16, bottom: 5),
                                //         padding: getPadding(
                                //             left: 16, top: 12, right: 16, bottom: 12),
                                //         decoration: AppDecoration.outlineIndigo.copyWith(
                                //             borderRadius: BorderRadiusStyle.roundedBorder24),
                                //         child: CustomRadioButton(
                                //             isRightCheck: true,
                                //             text: "Other (please specify)",
                                //             value: state.careerGoalsModelObj
                                //                 ?.radioList[4] ??
                                //                 "",
                                //             groupValue: state.radioGroup,
                                //             padding: getPadding(top: 1, bottom: 1),
                                //             onChange: (value) {
                                //               context
                                //                   .read<CareerGoalsBloc>()
                                //                   .add(ChangeRadioButtonEvent(
                                //                   value: value));
                                //             }),
                                //       ),
                                // state.radioGroup == "others" ?  CustomTextFormField(
                                //     controller: state.othersTextController,
                                //     margin: getMargin(top: 9),
                                //     hintText: "Tell us more",
                                //     hintStyle:
                                //     CustomTextStyles.titleMediumBluegray400,
                                //     textInputAction: TextInputAction.done,
                                //     textInputType: TextInputType.emailAddress,
                                //     onChange: (value) {
                                //       context.read<CareerGoalsBloc>().add(SetOthersTextEvent(value: value));
                                //     },
                                //     validator: (value) {
                                //       if ( state.radioGroup == "others" && value == null ) {
                                //         return "more information required";
                                //       }
                                //       return null;
                                //     },
                                //     contentPadding: getPadding (
                                //         left: 12,
                                //         top: 15,
                                //         right: 12,
                                //         bottom: 15
                                //     )
                                // ) : Container(),
                                      CustomElevatedButton(
                                          text: "lbl_continue".tr,
                                          margin: getMargin(top: 39),
                                          buttonStyle: CustomButtonStyles.fillPrimary,
                                          onTap: () {
                                            onTapKeyStrengthPage(context, state);
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

  onTapKeyStrengthPage(BuildContext context, CareerGoalsState state) {
    const storage = FlutterSecureStorage();

    if(state.radioGroup == "") {
      Fluttertoast.showToast(msg: "Please select an option to proceed.", toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (_formKey.currentState!.validate() && state.radioGroup != "" && state.radioGroup != "others") {
      storage.write(key: "career_goal", value: state.radioGroup);
      NavigatorService.pushNamed(
        AppRoutes.keyStrengthScreen,
      );
    }

    if (_formKey.currentState!.validate() && state.radioGroup != "" && state.radioGroup == "others") {
      if(state.othersText == null || state.othersText!.isEmpty)
      {
        Fluttertoast.showToast(msg: "Please provide more information to proceed.", toastLength: Toast.LENGTH_LONG);
        return;
      }
      storage.write(key: "career_goal", value: state.othersText);
      NavigatorService.pushNamed(
        AppRoutes.keyStrengthScreen,
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
