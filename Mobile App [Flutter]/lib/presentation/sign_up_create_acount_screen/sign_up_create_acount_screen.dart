import 'bloc/sign_up_create_acount_bloc.dart';
import 'models/sign_up_create_acount_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/core/utils/validation_functions.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';
import 'package:fotisia/domain/googleauth/google_auth_helper.dart';

// ignore_for_file: must_be_immutable
class SignUpCreateAcountScreen extends StatelessWidget {
  SignUpCreateAcountScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<SignUpCreateAcountBloc>(
        create: (context) => SignUpCreateAcountBloc(SignUpCreateAcountState(
            signUpCreateAcountModelObj: SignUpCreateAcountModel()))
          ..add(SignUpCreateAcountInitialEvent()),
        child: SignUpCreateAcountScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: appTheme.whiteA70002,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: Container(
                  width: double.maxFinite,
                  padding:
                      getPadding(left: 24, top: 13, right: 24, bottom: 13),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomImageView(
                            svgPath: ImageConstant.imgGroup162799,
                            height: getSize(24),
                            width: getSize(24),
                            alignment: Alignment.centerLeft,
                            onTap: () {
                              onTapImgImage(context);
                            }),
                        Padding(
                            padding: getPadding(top: 44),
                            child: Text("Create Account",
                                style: theme.textTheme.headlineSmall)),
                        CustomOutlinedButton(
                            height: getVerticalSize(56),
                            text: "Signup with Google",
                            margin: getMargin(top: 28),
                            leftIcon: Container(
                                margin: getMargin(right: 12),
                                child: CustomImageView(
                                    svgPath: ImageConstant.imgGooglesymbol1)),
                            buttonStyle: CustomButtonStyles.outlinePrimary,
                            buttonTextStyle: theme.textTheme.titleMedium!,
                            onTap: () {
                              onTapContinuewith(context);
                            }),
                        CustomOutlinedButton(
                            height: getVerticalSize(56),
                            text: "Signup with Apple",
                            margin: getMargin(top: 16),
                            leftIcon: Container(
                                margin: getMargin(right: 12),
                                child: CustomImageView(
                                    svgPath: ImageConstant.imgIconApple)),
                            buttonStyle: CustomButtonStyles.outlinePrimary,
                            buttonTextStyle: theme.textTheme.titleMedium!),
                        Padding(
                            padding: getPadding(left: 33, top: 26, right: 33),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: getPadding(top: 8, bottom: 8),
                                      child: SizedBox(
                                          width: getHorizontalSize(62),
                                          child: Divider())),
                                  Padding(
                                      padding: getPadding(left: 12),
                                      child: Text("msg_or_continue_with".tr,
                                          style: CustomTextStyles
                                              .titleSmallBluegray300)),
                                  Padding(
                                      padding: getPadding(top: 8, bottom: 8),
                                      child: SizedBox(
                                          width: getHorizontalSize(74),
                                          child: Divider(
                                              indent: getHorizontalSize(12))))
                                ])),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(top: 28),
                                child: Text("Email",
                                    style:
                                        CustomTextStyles.titleSmallPrimary))),
                        BlocSelector<
                                SignUpCreateAcountBloc,
                                SignUpCreateAcountState,
                                TextEditingController?>(
                            selector: (state) => state.emailController,
                            builder: (context, emailController) {
                              return CustomTextFormField(
                                  controller: emailController,
                                  margin: getMargin(top: 9),
                                  hintText: "msg_enter_your_email".tr,
                                  hintStyle:
                                      CustomTextStyles.titleMediumBluegray400,
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null ||
                                        (!isValidEmail(value,
                                            isRequired: true))) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  },
                                  contentPadding: getPadding(
                                      left: 12,
                                      top: 15,
                                      right: 12,
                                      bottom: 15));
                            }),
                        CustomElevatedButton(
                            text: "msg_continue_with_email".tr,
                            margin: getMargin(top: 40),
                            buttonStyle: CustomButtonStyles.fillPrimary,
                            onTap: () {
                              onTapContinuewith1(context);
                            }),
                        Padding(
                            padding: getPadding(left: 40, top: 28, right: 40),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("msg_already_have_an".tr,
                                      style: CustomTextStyles
                                          .titleMediumBluegray300),
                                  GestureDetector(
                                      onTap: () {
                                        onTapTxtLargelabelmediu(context);
                                      },
                                      child: Padding(
                                          padding: getPadding(left: 3),
                                          child: Text("Login",
                                              style: theme
                                                  .textTheme.titleMedium)))
                                ])),
                        Container(
                            width: getHorizontalSize(245),
                            margin: getMargin(
                                left: 40, top: 84, right: 40, bottom: 5),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "msg_by_signing_up_you2".tr,
                                      style: CustomTextStyles
                                          .titleSmallBluegray400SemiBold),
                                  TextSpan(
                                      text: "lbl_terms".tr,
                                      style: CustomTextStyles
                                          .titleSmallErrorContainer),
                                  TextSpan(
                                      text: "lbl_and".tr,
                                      style: CustomTextStyles
                                          .titleSmallBluegray400SemiBold),
                                  TextSpan(
                                      text: "msg_conditions_of_use".tr,
                                      style: CustomTextStyles
                                          .titleSmallErrorContainer)
                                ]),
                                textAlign: TextAlign.center))
                      ]))),
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

  /// Performs a Google sign-in and returns a [GoogleUser] object.
  ///
  /// If the sign-in is successful, the [onSuccess] callback will be called with
  /// a TODO comment needed to be modified by you.
  /// If the sign-in fails, the [onError] callback will be called with the error message.
  ///
  /// Throws an exception if the Google sign-in process fails.
  onTapContinuewith(BuildContext context) async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
      if (googleUser != null) {
        //TODO Actions to be performed after signin
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('user data is empty')));
      }
    }).catchError((onError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }

  /// Navigates to the signUpCompleteAccountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCompleteAccountScreen.
  onTapContinuewith1(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signUpCompleteAccountScreen,
        arguments: {'email': 'exampleArgument'}
    );
  }

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the loginScreen.
  onTapTxtLargelabelmediu(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.loginScreen,
    );
  }
}
