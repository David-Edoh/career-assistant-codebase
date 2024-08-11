import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/custom_text_form_field.dart';
import 'bloc/employment_status_bloc.dart';
import 'models/employment_status_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_checkbox_button.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_radio_button.dart';
import 'package:fotisia/presentation/confirmation_dialog/confirmation_dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotisia/core/utils/validation_functions.dart';


class EmploymentStatusScreen extends StatelessWidget {
   EmploymentStatusScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<EmploymentStatusBloc>(
        create: (context) => EmploymentStatusBloc(EmploymentStatusState(
            EmploymentStatusModelObj: EmploymentStatusModel()))
          ..add(EmploymentStatusInitialEvent()),
        child: EmploymentStatusScreen());
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
                            child: Text("What is your current employment status?",
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall!
                                    .copyWith(height: 1.33, color: Colors.white))),
                        Padding(
                            padding: getPadding(top: 50),
                            child: BlocBuilder<EmploymentStatusBloc,
                                EmploymentStatusState>(builder: (context, state) {
                              return state.EmploymentStatusModelObj!.radioList
                                      .isNotEmpty
                                  ? Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                      Column(
                                        children: [
                                          Semantics(
                                            label: "Option: employed full time?",
                                            child: Container(
                                              margin: getMargin(left: 1, top: 16, bottom: 5),
                                              padding: getPadding(
                                                  left: 16, top: 12, right: 16, bottom: 12),
                                              decoration: AppDecoration.outlineIndigo.copyWith(
                                                  borderRadius: BorderRadiusStyle.roundedBorder24),
                                              child: CustomRadioButton(
                                                  isRightCheck: true,
                                                  text: "Employed full-time",
                                                  value: state.EmploymentStatusModelObj
                                                          ?.radioList[0] ??
                                                      "",
                                                  groupValue: state.radioGroup,
                                                  padding: getPadding(top: 1, bottom: 1),
                                                  onChange: (value) {
                                                    context
                                                        .read<EmploymentStatusBloc>()
                                                        .add(ChangeRadioButtonEvent(
                                                            value: value));
                                                  }),
                                            ),
                                          ),
                                          Semantics(
                                            label: "Option: Employed part-time?",
                                            child: Container(
                                              margin: getMargin(left: 1, top: 16, bottom: 5),
                                              padding: getPadding(
                                                  left: 16, top: 12, right: 16, bottom: 12),
                                              decoration: AppDecoration.outlineIndigo.copyWith(
                                                  borderRadius: BorderRadiusStyle.roundedBorder24),
                                              child: CustomRadioButton(
                                                  isRightCheck: true,
                                                  text: "Employed part-time",
                                                  value: state.EmploymentStatusModelObj
                                                          ?.radioList[1] ??
                                                      "",
                                                  groupValue: state.radioGroup,
                                                  padding: getPadding(top: 1, bottom: 1),
                                                  onChange: (value) {
                                                    context
                                                        .read<EmploymentStatusBloc>()
                                                        .add(ChangeRadioButtonEvent(
                                                            value: value));
                                                  }),
                                            ),
                                          ),
                                          Semantics(
                                            label: "Option: Unemployed?",
                                            child: Container(
                                              margin: getMargin(left: 1, top: 16, bottom: 5),
                                              padding: getPadding(
                                                  left: 16, top: 12, right: 16, bottom: 12),
                                              decoration: AppDecoration.outlineIndigo.copyWith(
                                                  borderRadius: BorderRadiusStyle.roundedBorder24),
                                              child: CustomRadioButton(
                                                  isRightCheck: true,
                                                  text: "Unemployed",
                                                  value: state.EmploymentStatusModelObj
                                                          ?.radioList[2] ??
                                                      "",
                                                  groupValue: state.radioGroup,
                                                  padding: getPadding(top: 1, bottom: 1),
                                                  onChange: (value) {
                                                    context
                                                        .read<EmploymentStatusBloc>()
                                                        .add(ChangeRadioButtonEvent(
                                                            value: value));
                                                  }),
                                            ),
                                          ),
            
                                          Semantics(
                                            label: "Option: Student?",
                                            child: Container(
                                              margin: getMargin(left: 1, top: 16, bottom: 5),
                                              padding: getPadding(
                                                  left: 16, top: 12, right: 16, bottom: 12),
                                              decoration: AppDecoration.outlineIndigo.copyWith(
                                                  borderRadius: BorderRadiusStyle.roundedBorder24),
                                              child: CustomRadioButton(
                                                  isRightCheck: true,
                                                  text: "Student",
                                                  value: state.EmploymentStatusModelObj
                                                      ?.radioList[3] ??
                                                      "",
                                                  groupValue: state.radioGroup,
                                                  padding: getPadding(top: 1, bottom: 1),
                                                  onChange: (value) {
                                                    context
                                                        .read<EmploymentStatusBloc>()
                                                        .add(ChangeRadioButtonEvent(
                                                        value: value));
                                                  }
                                                  ),
                                            ),
                                          ),
            
                                        Semantics(
                                          label: "Option: Select this option if you will like to type out your employment status... (if your option is not listed, please specify it in the form below)",
                                          child: Container(
                                            margin: getMargin(left: 1, top: 16, bottom: 5),
                                            padding: getPadding(
                                                left: 16, top: 12, right: 16, bottom: 12),
                                            decoration: AppDecoration.outlineIndigo.copyWith(
                                                borderRadius: BorderRadiusStyle.roundedBorder24),
                                            child: CustomRadioButton(
                                                isRightCheck: true,
                                                text: "Other (please specify)",
                                                value: state.EmploymentStatusModelObj
                                                    ?.radioList[4] ??
                                                    "",
                                                groupValue: state.radioGroup,
                                                padding: getPadding(top: 1, bottom: 1),
                                                onChange: (value) {
                                                  context
                                                      .read<EmploymentStatusBloc>()
                                                      .add(ChangeRadioButtonEvent(
                                                      value: value));
                                                }),
                                          ),
                                        ),
            
                                        state.radioGroup == "others" ?  Semantics(
                                          label: "Enter your current employment status, in details",
                                          child: CustomTextFormField(
                                              controller: state.othersTextController,
                                              margin: getMargin(top: 9),
                                              hintText: "Tell us more",
                                              hintStyle:
                                              CustomTextStyles.titleMediumBluegray400,
                                              textInputAction: TextInputAction.done,
                                              textInputType: TextInputType.emailAddress,
                                              onChange: (value) {
                                                context.read<EmploymentStatusBloc>().add(SetOthersTextEvent(value: value));
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
                                        ],
                                      ),
                                    CustomElevatedButton(
                                        text: "lbl_continue".tr,
                                        margin: getMargin(top: 39),
                                        buttonStyle: CustomButtonStyles.fillPrimary,
                                        onTap: () {
                                          onTapEducationLevelPage(context, state);
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


  onTapEducationLevelPage(BuildContext context, EmploymentStatusState state) async {
    const storage = FlutterSecureStorage();
    String? data = await storage.read(key: "userData");

    if(state.radioGroup == "") {
      Fluttertoast.showToast(msg: "Please select an option to proceed.", toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (_formKey.currentState!.validate() && state.radioGroup != "" && state.radioGroup != "others") {

      storage.write(key: "employment_status", value: state.radioGroup);
      NavigatorService.pushNamed(
        AppRoutes.educationLevelScreen,
      );
    }

    if (_formKey.currentState!.validate() && state.radioGroup != "" && state.radioGroup == "others") {
      if(state.othersText == null || state.othersText!.isEmpty)
      {
        Fluttertoast.showToast(msg: "Please provide more information to proceed.", toastLength: Toast.LENGTH_LONG);
        return;
      }
      storage.write(key: "employment_status", value: state.othersText);
      NavigatorService.pushNamed(
        AppRoutes.educationLevelScreen,
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
