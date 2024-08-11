import 'package:flutter/cupertino.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';

import 'bloc/forgot_password_bloc.dart';
import 'models/forgot_password_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_pin_code_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
        create: (context) => ForgotPasswordBloc(
            ForgotPasswordState(forgotPasswordModelObj: ForgotPasswordModel()))
          ..add(ForgotPasswordInitialEvent()),
        child: ForgotPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
              width: double.maxFinite,
              padding: getPadding(left: 24, top: 13, right: 24, bottom: 13),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Semantics(
                  label: "Back to login page",
                  child: SizedBox(
                    height: 48,
                    child: CustomImageView(
                        svgPath: ImageConstant.imgGroup162799,
                        height: getSize(30),
                        width: getSize(30),
                        alignment: Alignment.centerLeft,
                        onTap: () {
                          onTapImgImage(context);
                        }),
                  ),
                ),
                Padding(
                    padding: getPadding(top: 44),
                    child: Text("Password Reset".tr,
                        style: theme.textTheme.headlineSmall)),
                BlocSelector<ForgotPasswordBloc, ForgotPasswordState, bool?>(
                    selector: (state) => state.emailSent,
                    builder: (context, emailSent) {
                      return emailSent != null && emailSent
                          ? Container(
                              width: getHorizontalSize(282),
                              margin: getMargin(left: 22, top: 10, right: 22),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "We have just sent an email containing a reset link. Follow the link to reset your password.",
                                        style: CustomTextStyles
                                            .titleSmallBluegray400_3),
                                    // TextSpan(
                                    //     text: "msg_example_gmail_com".tr,
                                    //     style: CustomTextStyles.titleSmallPrimary_1)
                                  ]),
                                  textAlign: TextAlign.center))
                          : Container();
                    }),
                BlocSelector<ForgotPasswordBloc, ForgotPasswordState,
                        TextEditingController?>(
                    selector: (state) => state.emailController,
                    builder: (context, emailController) {
                      return CustomTextFormField(
                          hintText: "Enter your email here...",
                          margin: getMargin(left: 0, top: 38, right: 0),
                          controller: emailController,
                          contentPadding: getPadding(left: 16, top: 15, bottom: 15),
                          onChange: (data) {
                            context.read<ForgotPasswordBloc>().add(
                                  OnChangeEvent(email: data),
                                );
                          });
                    }),
                CustomElevatedButton(
                    text: "lbl_continue".tr,
                    margin: getMargin(top: 40),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    onTap: () {
                      onTapContinue(context);
                    }),
                // Padding(
                //     padding: getPadding(
                //         left: 30, top: 26, right: 30, bottom: 5),
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text("msg_didn_t_receive_code".tr,
                //               style: CustomTextStyles
                //                   .titleMediumBluegray300),
                //           Text("lbl_resend_code".tr,
                //               style: theme.textTheme.titleMedium)
                //         ]))
              ])),
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

  /// Navigates to the jobTypeScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the jobTypeScreen.
  onTapContinue(BuildContext context) {
    context.read<ForgotPasswordBloc>().add(
          ResetPasswordEvent(),
        );
  }
}
