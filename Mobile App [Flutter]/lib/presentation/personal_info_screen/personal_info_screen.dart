import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pick_or_save/pick_or_save.dart';
import '../../widgets/custom_outlined_button.dart';
import 'bloc/personal_info_bloc.dart';
import 'models/personal_info_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/core/utils/validation_functions.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_image_1.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';
import 'package:file_picker/file_picker.dart';

// ignore_for_file: must_be_immutable
class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<PersonalInfoBloc>(
        create: (context) => PersonalInfoBloc(
            PersonalInfoState(personalInfoModelObj: PersonalInfoModel()))
          ..add(PersonalInfoInitialEvent()),
        child: PersonalInfoScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        builder: (context, state) {
    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            leadingWidth: getHorizontalSize(50),
          height: getVerticalSize(70),
            leading: Semantics(
              label: "Back to settings page",
              child: AppbarImage(
                  svgPath: ImageConstant.imgGroup162799,
                  margin: getMargin(left: 24, top: 13, bottom: 13),
                  onTap: () {
                    onTapArrowbackone(context);
                  }),
            ),
            centerTitle: true,
            title: AppbarTitle(
                text: "lbl_personal_info".tr,
              margin: EdgeInsets.only(right: getHorizontalSize(40)),
            ),
           ),
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  padding: getPadding(top: 32),
                  child: Padding(
                      padding: getPadding(left: 24, right: 24, bottom: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  uploadProfilePic(context);
                                },
                                child: (state.userPicture != null && state.userPicture!.isNotEmpty) ?
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(getHorizontalSize(44)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(getHorizontalSize(44)),
                                    ),
                                    child: Image.memory(
                                      base64Decode(state.userPicture as String),
                                      height: getSize(89),
                                      width: getSize(89),
                                    ),
                                  ),

                                ) : Semantics(
                                  label: "Edit your profile picture",
                                  child: CustomImageView(
                                      url: (state.picturePath != null && state.picturePath!.isNotEmpty) ? state.picturePath : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                      height: getSize(89),
                                      width: getSize(89),
                                      radius: BorderRadius
                                          .circular(
                                          getHorizontalSize(44)
                                      )
                                  ),
                                ),
                              ),
                            ),

                            Center(
                              child: Padding(
                                  padding: getPadding(top: 18),
                                  child: Text("Professional Picture",
                                      style:
                                      CustomTextStyles.titleSmallPrimary)),
                            ),

                            Semantics(
                              label: "Edit your profile picture",
                              child: CustomOutlinedButton(
                                  height: 48,
                                  text: "Click to Upload",
                                  margin: getMargin(top: 9, bottom: 10),
                                  // rightIcon: Container(
                                  //     margin: getMargin(left: 30),
                                  //     child: CustomImageView(
                                  //         svgPath: ImageConstant
                                  //             .imgCalendar)),
                                  buttonStyle: CustomButtonStyles
                                      .outlineIndigo,
                                  buttonTextStyle:
                                  CustomTextStyles
                                      .titleMediumBluegray400,
                                  onTap: () {
                                    uploadProfilePic(context);
                                  }),
                            ),

                            Text("lbl_first_name".tr,
                                style: CustomTextStyles.titleSmallPrimary),
                            BlocSelector<PersonalInfoBloc, PersonalInfoState,
                                    TextEditingController?>(
                                selector: (state) =>
                                    state.firstNameController,
                                builder: (context, firstNameController) {
                                  return Semantics(
                                    label: "Edit your first name",
                                    child: CustomTextFormField(
                                        controller: firstNameController,
                                        margin: getMargin(top: 9),
                                        hintText: "lbl_gustavo".tr,
                                        hintStyle: CustomTextStyles
                                            .titleMediumBluegray400),
                                  );
                                }),
                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("lbl_last_name".tr,
                                    style:
                                        CustomTextStyles.titleSmallPrimary)),
                            BlocSelector<PersonalInfoBloc, PersonalInfoState,
                                    TextEditingController?>(
                                selector: (state) => state.lastNameController,
                                builder: (context, lastNameController) {
                                  return Semantics(
                                    label: "Edit your last name",
                                    child: CustomTextFormField(
                                        controller: lastNameController,
                                        margin: getMargin(top: 9),
                                        hintText: "lbl_lipshutz".tr,
                                        hintStyle: CustomTextStyles
                                            .titleMediumBluegray400),
                                  );
                                }),
                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("lbl_email".tr,
                                    style:
                                        CustomTextStyles.titleSmallPrimary)),
                            BlocSelector<PersonalInfoBloc, PersonalInfoState,
                                    TextEditingController?>(
                                selector: (state) => state.emailController,
                                builder: (context, emailController) {
                                  return Semantics(
                                    label: "Your email address, This cannot be edited.",
                                    child: CustomTextFormField(
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
                                        }),
                                  );
                                }),
                            // Padding(
                            //     padding: getPadding(top: 18),
                            //     child: Text("lbl_phone".tr,
                            //         style:
                            //             CustomTextStyles.titleSmallPrimary)),
                            // BlocSelector<PersonalInfoBloc, PersonalInfoState,
                            //         TextEditingController?>(
                            //     selector: (state) => state.phoneController,
                            //     builder: (context, phoneController) {
                            //       return CustomTextFormField(
                            //           controller: phoneController,
                            //           margin: getMargin(top: 9),
                            //           hintText: "lbl_1_1234567890".tr,
                            //           hintStyle: CustomTextStyles
                            //               .titleMediumBluegray400);
                            //     }),
                            // Padding(
                            //     padding: getPadding(top: 18),
                            //     child: Text("lbl_location".tr,
                            //         style:
                            //             CustomTextStyles.titleSmallPrimary)),
                            // BlocSelector<PersonalInfoBloc, PersonalInfoState,
                            //         TextEditingController?>(
                            //     selector: (state) => state.locationController,
                            //     builder: (context, locationController) {
                            //       return CustomTextFormField(
                            //           controller: locationController,
                            //           margin: getMargin(top: 9),
                            //           hintText: "lbl_lorem_ipsun".tr,
                            //           hintStyle: CustomTextStyles
                            //               .titleMediumBluegray400,
                            //           textInputAction: TextInputAction.done,
                            //           maxLines: 6,
                            //           contentPadding: getPadding(
                            //               left: 16,
                            //               top: 20,
                            //               right: 16,
                            //               bottom: 20));
                            //     })
                          ]
                      )
                  )
              )
          ),
        ),
        bottomNavigationBar: CustomElevatedButton(
            text: "lbl_save_changes".tr,
            margin: getMargin(left: 24, right: 24, bottom: 44),
            // buttonStyle: CustomButtonStyles.fillBlueGray,
            buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
              // backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onTap: () {
              onTapSavechanges(context);
            })
    );
  });
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

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapSavechanges(BuildContext context) {
    // NavigatorService.goBack();
    context.read<PersonalInfoBloc>().add(
      SaveProfileDetailsEvent(),
    );
  }

Future<void> uploadProfilePic(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png'],
  );

  if (result != null) {
    String? filePath = result.files.single.path;
    if (filePath != null) {
      _cropImage(filePath, context);
    }
  } else {
    // User canceled the picker
  }
}


  Future<Null> _cropImage(String path, BuildContext context) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          :
      [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
          // initAspectRatio: CropAspectRatioPreset.square,
          // lockAspectRatio: true
        ),
      ],
    );

    context.read<PersonalInfoBloc>().add(
      SetSelectedImage(value: croppedFile!.path),
    );
  }
}
