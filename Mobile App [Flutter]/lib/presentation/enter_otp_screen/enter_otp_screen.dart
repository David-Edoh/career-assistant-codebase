import 'bloc/enter_otp_bloc.dart';
import 'models/enter_otp_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_pin_code_text_field.dart';

class EnterOtpScreen extends StatelessWidget {
  const EnterOtpScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<EnterOtpBloc>(
        create: (context) =>
            EnterOtpBloc(EnterOtpState(enterOtpModelObj: EnterOtpModel()))
              ..add(EnterOtpInitialEvent()),
        child: EnterOtpScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 13, right: 24, bottom: 13),
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
                          child: Text("lbl_enter_otp".tr,
                              style: theme.textTheme.headlineSmall)),
                      Container(
                          width: getHorizontalSize(282),
                          margin: getMargin(left: 22, top: 10, right: 22),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "msg_we_have_just_sent2".tr,
                                    style: CustomTextStyles
                                        .titleSmallBluegray400_3),
                                TextSpan(
                                    text: "msg_example_gmail_com".tr,
                                    style: CustomTextStyles.titleSmallPrimary_1)
                              ]),
                              textAlign: TextAlign.center)),
                      BlocSelector<EnterOtpBloc, EnterOtpState,
                              TextEditingController?>(
                          selector: (state) => state.otpController,
                          builder: (context, otpController) {
                            return CustomPinCodeTextField(
                                context: context,
                                margin: getMargin(left: 16, top: 38, right: 15),
                                controller: otpController,
                                onChanged: (value) {
                                  otpController?.text = value;
                                });
                          }),
                      CustomElevatedButton(
                          text: "lbl_continue".tr,
                          margin: getMargin(top: 40),
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          onTap: () {
                            onTapContinue(context);
                          }),
                      Padding(
                          padding: getPadding(
                              left: 30, top: 26, right: 30, bottom: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("msg_didn_t_receive_code".tr,
                                    style: CustomTextStyles
                                        .titleMediumBluegray300),
                                Text("lbl_resend_code".tr,
                                    style: theme.textTheme.titleMedium)
                              ]))
                    ]))));
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
    NavigatorService.pushNamed(
      AppRoutes.jobTypeScreen,
    );
  }
}
