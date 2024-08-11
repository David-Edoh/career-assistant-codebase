import 'bloc/apply_job_bloc.dart';
import 'models/apply_job_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/core/utils/validation_functions.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';
import 'package:fotisia/presentation/apply_job_popup_dialog/apply_job_popup_dialog.dart';

// ignore_for_file: must_be_immutable
class ApplyJobScreen extends StatelessWidget {
  ApplyJobScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<ApplyJobBloc>(
        create: (context) =>
            ApplyJobBloc(ApplyJobState(applyJobModelObj: ApplyJobModel()))
              ..add(ApplyJobInitialEvent()),
        child: ApplyJobScreen());
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
                title: AppbarTitle(text: "lbl_apply_job".tr)),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        getPadding(left: 24, top: 31, right: 24, bottom: 31),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("lbl_full_name".tr,
                                        style:
                                            CustomTextStyles.titleSmallPrimary),
                                    BlocSelector<ApplyJobBloc, ApplyJobState,
                                            TextEditingController?>(
                                        selector: (state) =>
                                            state.fullNameController,
                                        builder: (context, fullNameController) {
                                          return CustomTextFormField(
                                              controller: fullNameController,
                                              margin: getMargin(top: 9),
                                              hintText:
                                                  "msg_brooklyn_simmons".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400);
                                        })
                                  ])),
                          Container(
                              margin: getMargin(top: 26),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("lbl_email_address".tr,
                                        style:
                                            CustomTextStyles.titleSmallPrimary),
                                    BlocSelector<ApplyJobBloc, ApplyJobState,
                                            TextEditingController?>(
                                        selector: (state) =>
                                            state.emailController,
                                        builder: (context, emailController) {
                                          return CustomTextFormField(
                                              controller: emailController,
                                              margin: getMargin(top: 9),
                                              hintText: "lbl_xyz_gmail_com".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              validator: (value) {
                                                if (value == null ||
                                                    (!isValidEmail(value,
                                                        isRequired: true))) {
                                                  return "Please enter valid email";
                                                }
                                                return null;
                                              });
                                        })
                                  ])),
                          Padding(
                              padding: getPadding(top: 28),
                              child: Text("lbl_upload_cv".tr,
                                  style: CustomTextStyles.titleSmallPrimary)),
                          Padding(
                              padding: getPadding(top: 7),
                              child: DottedBorder(
                                  color: appTheme.indigo50,
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(1),
                                      top: getVerticalSize(1),
                                      right: getHorizontalSize(1),
                                      bottom: getVerticalSize(1)),
                                  strokeWidth: getHorizontalSize(1),
                                  radius: Radius.circular(24),
                                  borderType: BorderType.RRect,
                                  dashPattern: [6, 6],
                                  child: Container(
                                      padding: getPadding(
                                          left: 125,
                                          top: 39,
                                          right: 125,
                                          bottom: 39),
                                      decoration: AppDecoration.outlineIndigo501
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder24),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgCloudupload1,
                                                height: getSize(40),
                                                width: getSize(40)),
                                            Padding(
                                                padding: getPadding(top: 8),
                                                child: Text(
                                                    "lbl_upload_file".tr,
                                                    style: CustomTextStyles
                                                        .titleSmallPrimarySemiBold))
                                          ])))),
                          Container(
                              margin: getMargin(top: 28, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("msg_website_blog_or".tr,
                                        style:
                                            CustomTextStyles.titleSmallPrimary),
                                    BlocSelector<ApplyJobBloc, ApplyJobState,
                                            TextEditingController?>(
                                        selector: (state) =>
                                            state.frameOneController,
                                        builder: (context, frameOneController) {
                                          return CustomTextFormField(
                                              controller: frameOneController,
                                              margin: getMargin(top: 7),
                                              hintText: "lbl_https".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                              textInputAction:
                                                  TextInputAction.done);
                                        })
                                  ]))
                        ]))),
            bottomNavigationBar: CustomElevatedButton(
                text: "lbl_continue".tr,
                margin: getMargin(left: 24, right: 24, bottom: 40),
                buttonStyle: CustomButtonStyles.fillPrimary,
                onTap: () {
                  onTapContinue(context);
                })));
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

  /// Displays an [AlertDialog] with a custom content widget using the
  /// provided [BuildContext].
  ///
  /// The custom content widget is created by calling
  /// [ApplyJobPopupDialog.builder] method.
  onTapContinue(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: ApplyJobPopupDialog.builder(context),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
  }
}
