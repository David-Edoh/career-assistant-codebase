import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../experience_setting_screen/widgets/experience_item_widget.dart';
import 'bloc/experience_setting_bloc.dart';
import 'models/experience_item_model.dart';
import 'models/experience_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';

class ExperienceSettingScreen extends StatelessWidget {
  const ExperienceSettingScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ExperienceSettingBloc>(
        create: (context) => ExperienceSettingBloc(ExperienceSettingState(
            experienceSettingModelObj: ExperienceSettingModel(), skillsController: TextfieldTagsController()))
          ..add(ExperienceSettingInitialEvent()),
        child: ExperienceSettingScreen());
  }


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<ExperienceSettingBloc, ExperienceSettingState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: appTheme.whiteA70001,
              appBar: CustomAppBar(
                  height: getVerticalSize(70),
                  leadingWidth: getHorizontalSize(50),
                  leading: Semantics(
                    label: "Back to previous screen",
                    child: AppbarImage(
                        svgPath: ImageConstant.imgGroup162799,
                        margin: getMargin(left: 24, top: 13, bottom: 14),
                        onTap: () {
                          onTapArrowbackone(context);
                        }),
                  ),
                  centerTitle: true,
                  title: AppbarTitle(text: "Edit Details")),
              body: SafeArea(
                child: SizedBox(
                    width: mediaQueryData.size.width,
                    child: SingleChildScrollView(
                        padding: getPadding(top: 28),
                        child: Padding(
                            padding: getPadding(left: 24, right: 24, bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Center(
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       uploadProfilePic(context);
                                  //     },
                                  //     child: (state.userPicture != null && state.userPicture!.isNotEmpty) ?
                                  //     ClipRRect(
                                  //       borderRadius: BorderRadius.circular(getHorizontalSize(44)),
                                  //       child: Container(
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(getHorizontalSize(44)),
                                  //         ),
                                  //         child: Image.memory(
                                  //           base64Decode(state.userPicture as String),
                                  //           height: getSize(89),
                                  //           width: getSize(89),
                                  //         ),
                                  //       ),
                                  //
                                  //     ) : CustomImageView(
                                  //         url: (state.picturePath != null && state.picturePath!.isNotEmpty) ? state.picturePath : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                  //         height: getSize(89),
                                  //         width: getSize(89),
                                  //         radius: BorderRadius
                                  //             .circular(
                                  //             getHorizontalSize(
                                  //                 44)
                                  //         )
                                  //     ),
                                  //   ),
                                  // ),

                                  // Center(
                                  //   child: Padding(
                                  //       padding: getPadding(top: 18),
                                  //       child: Text("Professional Picture",
                                  //           style:
                                  //           CustomTextStyles.titleSmallPrimary)),
                                  // ),

                                  // CustomOutlinedButton(
                                  //     height: getVerticalSize(52),
                                  //     text: "Click to Upload",
                                  //     margin: getMargin(top: 9, bottom: 10),
                                  //     // rightIcon: Container(
                                  //     //     margin: getMargin(left: 30),
                                  //     //     child: CustomImageView(
                                  //     //         svgPath: ImageConstant
                                  //     //             .imgCalendar)),
                                  //     buttonStyle: CustomButtonStyles
                                  //         .outlineIndigo,
                                  //     buttonTextStyle:
                                  //     CustomTextStyles
                                  //         .titleMediumBluegray400,
                                  //     onTap: () {
                                  //       uploadProfilePic(context);
                                  //     }),

                                  // Text("lbl_first_name".tr,
                                  //     style: CustomTextStyles.titleSmallPrimary),
                                  // BlocSelector<ExperienceSettingBloc,
                                  //     ExperienceSettingState,
                                  //     TextEditingController?>(
                                  //     selector: (state) =>
                                  //     state.firstNameController,
                                  //     builder: (context, firstNameController) {
                                  //       return CustomTextFormField(
                                  //           controller: firstNameController,
                                  //           margin: getMargin(top: 9),
                                  //           hintText: "lbl_gustavo".tr,
                                  //           hintStyle: CustomTextStyles
                                  //               .titleMediumBluegray400);
                                  //     }),
                                  // Padding(
                                  //     padding: getPadding(top: 18),
                                  //     child: Text("lbl_last_name".tr,
                                  //         style:
                                  //         CustomTextStyles.titleSmallPrimary)),
                                  // BlocSelector<ExperienceSettingBloc,
                                  //     ExperienceSettingState,
                                  //     TextEditingController?>(
                                  //     selector: (state) => state.lastNameController,
                                  //     builder: (context, lastNameController) {
                                  //       return CustomTextFormField(
                                  //           controller: lastNameController,
                                  //           margin: getMargin(top: 9),
                                  //           hintText: "lbl_lipshutz".tr,
                                  //           hintStyle: CustomTextStyles
                                  //               .titleMediumBluegray400);
                                  //     }),
                                  // Padding(
                                  //     padding: getPadding(top: 18),
                                  //     child: Text("lbl_email".tr,
                                  //         style:
                                  //         CustomTextStyles.titleSmallPrimary)),
                                  // BlocSelector<ExperienceSettingBloc,
                                  //     ExperienceSettingState,
                                  //     TextEditingController?>(
                                  //     selector: (state) => state.emailController,
                                  //     builder: (context, emailController) {
                                  //       return CustomTextFormField(
                                  //           controller: emailController,
                                  //           margin: getMargin(top: 9),
                                  //           hintText: "lbl_xyz_gmail_com".tr,
                                  //           hintStyle: CustomTextStyles
                                  //               .titleMediumBluegray400,
                                  //           textInputType:
                                  //           TextInputType.emailAddress,
                                  //           validator: (value) {
                                  //             if (value == null ||
                                  //                 (!isValidEmail(value,
                                  //                     isRequired: true))) {
                                  //               return "Please enter valid email";
                                  //             }
                                  //             return null;
                                  //           });
                                  //     }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("Career Title",
                                          style:
                                          CustomTextStyles.titleSmallPrimary)),
                                  BlocSelector<ExperienceSettingBloc,
                                      ExperienceSettingState,
                                      TextEditingController?>(
                                      selector: (state) => state.preferredDesignationController,
                                      builder: (context, preferredDesignationController) {
                                        return Semantics(
                                          label: "Edit your preferred career title",
                                          child: CustomTextFormField(
                                              controller: preferredDesignationController,
                                              margin: getMargin(top: 9),
                                              hintText: "Preferred Designation",
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400),
                                        );
                                      }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("lbl_phone".tr,
                                          style:
                                          CustomTextStyles.titleSmallPrimary)),
                                  BlocSelector<ExperienceSettingBloc,
                                      ExperienceSettingState,
                                      TextEditingController?>(
                                      selector: (state) => state.phoneController,
                                      builder: (context, phoneController) {
                                        return Semantics(
                                          label: "Edit / add your phone number.",
                                          child: CustomTextFormField(
                                              controller: phoneController,
                                              margin: getMargin(top: 9),
                                              hintText: "lbl_1_1234567890".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400),
                                        );
                                      }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("Website",
                                          style:
                                          CustomTextStyles.titleSmallPrimary)),
                                  BlocSelector<ExperienceSettingBloc,
                                      ExperienceSettingState,
                                      TextEditingController?>(
                                      selector: (state) => state.websiteController,
                                      builder: (context, websiteController) {
                                        return Semantics(
                                          label: "Add / Edit your website url if you have a website.",
                                          child: CustomTextFormField(
                                              controller: websiteController,
                                              margin: getMargin(top: 9),
                                              hintText: "e.g. www.yourwebsite.com",
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400),
                                        );
                                      }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("Professional Summary",
                                          style:
                                          CustomTextStyles.titleSmallPrimary)),
                                  BlocSelector<ExperienceSettingBloc,
                                      ExperienceSettingState,
                                      TextEditingController?>(
                                      selector: (state) => state.aboutMeController,
                                      builder: (context, aboutMeController) {
                                        return Semantics(
                                          label: "Edit about me section.",
                                          child: CustomTextFormField(
                                              controller: aboutMeController,
                                              margin: getMargin(top: 9),
                                              hintText: "lbl_lorem_ipsun".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                              textInputAction: TextInputAction.done,
                                              maxLines: 6,
                                              contentPadding: getPadding(
                                                  left: 16,
                                                  top: 20,
                                                  right: 16,
                                                  bottom: 20)),
                                        );
                                      }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("Address",
                                          style:
                                          CustomTextStyles.titleSmallPrimary)),
                                  BlocSelector<ExperienceSettingBloc,
                                      ExperienceSettingState,
                                      TextEditingController?>(
                                      selector: (state) => state.locationController,
                                      builder: (context, locationController) {
                                        return Semantics(
                                          label: "Add / Edit your physical address.}",
                                          child: CustomTextFormField(
                                              controller: locationController,
                                              margin: getMargin(top: 9),
                                              hintText: "lbl_lorem_ipsun".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                              textInputAction: TextInputAction.done,
                                              maxLines: 6,
                                              contentPadding: getPadding(
                                                  left: 16,
                                                  top: 20,
                                                  right: 16,
                                                  bottom: 20)),
                                        );
                                      }),

                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("Your Skills",
                                          style:
                                          CustomTextStyles.titleSmallPrimary)),
                                  BlocSelector<ExperienceSettingBloc,
                                      ExperienceSettingState,
                                      TextfieldTagsController?>(
                                      selector: (state) => state.skillsController,
                                      builder: (context, skillsController) {
                                        return Semantics(
                                          label: "Add / edit your professional skills. Separate each skill with a comma.}",
                                          child: TextFieldTags(
                                            textfieldTagsController: skillsController,
                                            initialTags: state.skills,
                                            textSeparators: const [' ', ','],
                                            letterCase: LetterCase.normal,
                                            validator: (String tag) {
                                              // if (tag == 'php') {
                                              //   return 'No, please just no';
                                              // } else if (skillsController!.getTags.contains(tag)) {
                                              //   return 'you already entered that';
                                              // }
                                              return null;
                                            },
                                            inputfieldBuilder:
                                                (context, tec, fn, error, onChanged, onSubmitted) {
                                              return ((context, sc, tags, onTagDelete) {
                                                return Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: TextField(
                                                    controller: tec,
                                                    focusNode: fn,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      border: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.black12,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      focusedBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.black12,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      helperText: 'Enter skills...',
                                                      helperStyle: const TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                      // hintText: skillsController!.hasTags ? '' : "Enter tag...",
                                                      errorText: error,
                                                      prefixIconConstraints:
                                                      BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.74),
                                                      prefixIcon: tags.isNotEmpty
                                                          ? SingleChildScrollView(
                                                        controller: sc,
                                                        scrollDirection: Axis.horizontal,
                                                        child: Row(
                                                            children: tags.map((String tag) {
                                                              return Container(
                                                                decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.all(
                                                                    Radius.circular(26.0),
                                                                  ),
                                                                  color: Colors.black,
                                                                ),
                                                                margin: const EdgeInsets.symmetric(
                                                                    horizontal: 5.0),
                                                                padding: const EdgeInsets.symmetric(
                                                                    horizontal: 10.0, vertical: 5.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    InkWell(
                                                                      child: Text(
                                                                        '#$tag',
                                                                        style: const TextStyle(
                                                                            color: Colors.white),
                                                                      ),
                                                                      onTap: () {
                                                                        // print("$tag selected");
                                                                      },
                                                                    ),
                                                                    const SizedBox(width: 4.0),
                                                                    InkWell(
                                                                      child: const Icon(
                                                                        Icons.cancel,
                                                                        size: 14.0,
                                                                        color: Color.fromARGB(
                                                                            255, 233, 233, 233),
                                                                      ),
                                                                      onTap: () {
                                                                        onTagDelete(tag);
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList()),
                                                      )
                                                          : null,
                                                    ),
                                                    onChanged: onChanged,
                                                    onSubmitted: onSubmitted,
                                                  ),
                                                );
                                              });
                                            },
                                          ),
                                        );
                                      }),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Container(
                                        padding: getPadding(all: 16),
                                        decoration: AppDecoration.outlineIndigo
                                            .copyWith(
                                            borderRadius:
                                            BorderRadiusStyle.circleBorder12),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding: getPadding(top: 2),
                                                        child: Text(
                                                          "lbl_experience".tr,
                                                          style: CustomTextStyles.titleMediumBold,
                                                        )
                                                    ),
                                                  ]),
                                              state.experiences != null && state.experiences!.isNotEmpty ? Column(
                                                  children: state.experiences!.map((experience) {
                                                    return Builder(
                                                      builder: (BuildContext context3) {
                                                        return Padding(
                                                            padding:
                                                            getPadding(top: 24, right: 0),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                      child: Padding(
                                                                          padding: getPadding(
                                                                              left: 12, top: 5),
                                                                          child: Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .start,
                                                                              children: [
                                                                                Text(
                                                                                    experience.position.toString(),
                                                                                    style: CustomTextStyles
                                                                                        .titleSmallPrimarySemiBold),
                                                                                Padding(
                                                                                    padding:
                                                                                    getPadding(
                                                                                        top: 6),
                                                                                    child: Padding(
                                                                                        padding: getPadding(
                                                                                            top:
                                                                                            1),
                                                                                        child: Text(
                                                                                            experience.company.toString(),
                                                                                            style: theme
                                                                                                .textTheme
                                                                                                .labelLarge))
                                                                                ),
                                                                                Padding(
                                                                                    padding:
                                                                                    getPadding(
                                                                                        top: 6),
                                                                                    child: Text(
                                                                                        "${experience.startDate.toString()} - ${experience.currentlyWorkHere == true ? "Present" : experience.endDate.toString()}",
                                                                                        style: theme
                                                                                            .textTheme
                                                                                            .labelLarge)
                                                                                )
                                                                              ]))
                                                                  ),
                                                                  Semantics(
                                                                    label: "Edit ${experience.position.toString()} at ${experience.company.toString()} position button",
                                                                    child: CustomIconButton(
                                                                      height: 48,
                                                                      width: 48,
                                                                      padding: getPadding(all: 8),
                                                                      onTap: () => {
                                                                        editExperience(context, experience.id as int)
                                                                      },
                                                                      child: Semantics(
                                                                        label: "Edit ${experience.position.toString()} at ${experience.company.toString()} position button",
                                                                        child: CustomImageView(
                                                                          svgPath: ImageConstant
                                                                              .imgEditsquare,
                                                                          height: getSize(12),
                                                                          width: getSize(12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // BlocProvider(
                                                                  //   create: (context) => BlocProvider.of<ExperienceSettingBloc>(context),
                                                                  //   child: YourWidget(),
                                                                  // ),

                                                                  Semantics(
                                                                    label: "Delete ${experience.position.toString()} at ${experience.company.toString()} position button",
                                                                    child: CustomIconButton(
                                                                      height: 48,
                                                                      width: 48,
                                                                      padding: getPadding(all: 8),
                                                                      onTap: () => showDialog<String>(
                                                                        context: context,
                                                                        builder: (BuildContext context2)
                                                                        {
                                                                          return AlertDialog(
                                                                            title: const Text(
                                                                                'Delete'),
                                                                            content:
                                                                            const Text('Are you sure you want to delete this item?'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () =>
                                                                                    Navigator.pop(context, 'Cancel'),
                                                                                child:
                                                                                const Text('Cancel'),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  context.read<ExperienceSettingBloc>().add(
                                                                                    DeleteItemEvent(
                                                                                      itemId: experience.id,
                                                                                      itemType: "Experience",
                                                                                      onDeleteItemError: () {
                                                                                        Fluttertoast.showToast(msg: "Failed Deleting Item", toastLength: Toast.LENGTH_LONG);
                                                                                      },
                                                                                      onDeleteItemSuccess: () {
                                                                                        Fluttertoast.showToast(msg: "Item Deleted Successfully", toastLength: Toast.LENGTH_LONG);
                                                                                        Navigator.pop(context, 'Delete');
                                                                                      },
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child:
                                                                                const Text('Delete'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                                      child: Semantics(
                                                                        label: "Delete ${experience.position.toString()} at ${experience.company.toString()} position button",
                                                                        child: CustomImageView(
                                                                          svgPath: ImageConstant
                                                                              .svgBinsquare,
                                                                          height: getSize(12),
                                                                          width: getSize(12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]
                                                            )
                                                        );
                                                      },
                                                    );
                                                  }).toList()
                                              ) : const Center(
                                                child: Text(
                                                  "Please add your experiences",
                                                ),
                                              )
                                            ]
                                        )
                                    ),
                                  ),
                                  Center(
                                    child: Semantics(
                                      label: "Add new career experience to your profile",
                                      child: CustomElevatedButton(
                                          text: "msg_add_new_position".tr,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          height: 48,
                                          margin: getMargin(left: 24, right: 24, top: 15),
                                          buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
                                            backgroundColor: MaterialStateProperty.all(Colors.black),
                                          ),
                                          onTap: () {
                                            onTapAddnew1(context);
                                          }),
                                    ),
                                  ),
                                  Container(
                                      margin: getMargin(top: 32),
                                      padding: getPadding(all: 16),
                                      decoration: AppDecoration.outlineBluegray50
                                          .copyWith(
                                          borderRadius:
                                          BorderRadiusStyle.circleBorder12),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Padding(
                                                      padding: getPadding(top: 2),
                                                      child: Text(
                                                          "lbl_education".tr,
                                                          style: CustomTextStyles
                                                              .titleMediumBold
                                                      )
                                                  ),
                                                ]
                                            ),
                                            state.educations != null && state.educations!.isNotEmpty ? Column(
                                              children: state.educations!.map((education) {
                                                return Builder(
                                                  builder: (BuildContext context1) {
                                                    return Padding(
                                                        padding:
                                                        getPadding(top: 24, right: 0),
                                                        child: Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                  child: Padding(
                                                                      padding: getPadding(
                                                                          left: 12, top: 5),
                                                                      child: Column(
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            Text(
                                                                                education.school.toString(),
                                                                                style: CustomTextStyles
                                                                                    .titleSmallPrimarySemiBold),
                                                                            Padding(
                                                                                padding:
                                                                                getPadding(
                                                                                    top: 6),
                                                                                child: Padding(
                                                                                    padding: getPadding(
                                                                                        top:
                                                                                        1),
                                                                                    child: Text(
                                                                                        "${education.level!.toString()}. ${education.discipline.toString()}",
                                                                                        style: theme
                                                                                            .textTheme
                                                                                            .labelLarge))
                                                                            ),
                                                                            Padding(
                                                                                padding:
                                                                                getPadding(
                                                                                    top: 6),
                                                                                child: Text(
                                                                                    "${education.startDate.toString()} - ${education.currentlySchoolHere == true ? "Present" : education.endDate.toString()}",
                                                                                    style: theme
                                                                                        .textTheme
                                                                                        .labelLarge)
                                                                            ),
                                                                          ]))
                                                              ),
                                                              CustomIconButton(
                                                                height: 48,
                                                                width: 48,
                                                                padding: getPadding(all: 8),
                                                                onTap: ()  async {
                                                                  const storage = FlutterSecureStorage();
                                                                  await storage.write(key: "itemId", value: education.id.toString());
                                                                  NavigatorService.pushNamed(AppRoutes.addNewEducationScreen).then((value){
                                                                    context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
                                                                  });
                                                                },
                                                                child: Semantics(
                                                                  label: "Edit ${education.level.toString()} at ${education.school.toString()} eduction button",
                                                                  child: CustomImageView(
                                                                    svgPath: ImageConstant
                                                                        .imgEditsquare,
                                                                    height: getSize(12),
                                                                    width: getSize(12),
                                                                  ),
                                                                ),
                                                              ),
                                                              CustomIconButton(
                                                                height: 48,
                                                                width: 48,
                                                                padding: getPadding(all: 8),
                                                                onTap: () => showDialog<String>(
                                                                  context: context,
                                                                  builder: (BuildContext context2)
                                                                  {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Delete'),
                                                                      content:
                                                                      const Text('Are you sure you want to delete this item?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(context, 'Cancel'),
                                                                          child:
                                                                          const Text('Cancel'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            context.read<ExperienceSettingBloc>().add(
                                                                              DeleteItemEvent(
                                                                                itemId: education.id,
                                                                                itemType: "Education",
                                                                                onDeleteItemError: () {
                                                                                  Fluttertoast.showToast(msg: "Failed Deleting Item", toastLength: Toast.LENGTH_LONG);
                                                                                },
                                                                                onDeleteItemSuccess: () {
                                                                                  Fluttertoast.showToast(msg: "Item Deleted Successfully", toastLength: Toast.LENGTH_LONG);
                                                                                  Navigator.pop(context, 'Delete');
                                                                                },
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                          const Text('Delete'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                                child: Semantics(
                                                                  label: "Delete ${education.level.toString()} at ${education.school.toString()} eduction button",
                                                                  child: CustomImageView(
                                                                    svgPath: ImageConstant
                                                                        .svgBinsquare,
                                                                    height: getSize(12),
                                                                    width: getSize(12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            ) : const Center(
                                              child: Text(
                                                "Please add your educations.",
                                              ),
                                            ),
                                          ]
                                      )
                                  ),

                                  Center(
                                    child: Semantics(
                                      label: "Add an education to your profile",
                                      child: CustomElevatedButton(
                                          text: "Add New Education",
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          height: 48,
                                          margin: getMargin(
                                              left: 24, right: 24, top: 15, bottom: 20),
                                          buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
                                            backgroundColor: MaterialStateProperty.all(Colors.black),
                                          ),
                                          onTap: () {
                                            onTapAddnew(context);
                                          }),
                                    ),
                                  ),

                                  Container(
                                      margin: getMargin(top: 32),
                                      padding: getPadding(all: 16),
                                      decoration: AppDecoration.outlineIndigo
                                          .copyWith(
                                          borderRadius:
                                          BorderRadiusStyle.circleBorder12),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                      padding: getPadding(top: 2),
                                                      child: Text(
                                                        "Projects",
                                                        style: CustomTextStyles.titleMediumBold,
                                                      )
                                                  ),
                                                ]),
                                            state.projects != null && state.projects!.isNotEmpty ? Column(
                                                children: state.projects!.map((project) {
                                                  return Builder(
                                                    builder: (BuildContext context1) {
                                                      return Padding(
                                                          padding:
                                                          getPadding(top: 24, right: 0),
                                                          child: Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Expanded(
                                                                    child: Padding(
                                                                        padding: getPadding(
                                                                            left: 12, top: 5),
                                                                        child: Column(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              Text(
                                                                                  project.title.toString(),
                                                                                  style: CustomTextStyles
                                                                                      .titleSmallPrimarySemiBold),
                                                                              Padding(
                                                                                  padding:
                                                                                  getPadding(
                                                                                      top: 6),
                                                                                  child: Text(
                                                                                      "${project.startDate.toString()} - ${project.endDate.toString()}",
                                                                                      style: theme
                                                                                          .textTheme
                                                                                          .labelLarge)
                                                                              )
                                                                            ]))
                                                                ),
                                                                CustomIconButton(
                                                                  height: 48,
                                                                  width: 48,
                                                                  padding: getPadding(all: 8),
                                                                  onTap: ()  async {
                                                                    const storage = FlutterSecureStorage();
                                                                    await storage.write(key: "itemId", value: project.id.toString());
                                                                    NavigatorService.pushNamed(AppRoutes.addNewProjectScreen).then((value){
                                                                      context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
                                                                    });
                                                                  },
                                                                  child: Semantics(
                                                                    label: "Edit ${project.title.toString()} project button",
                                                                    child: CustomImageView(
                                                                      svgPath: ImageConstant
                                                                          .imgEditsquare,
                                                                      height: getSize(12),
                                                                      width: getSize(12),
                                                                    ),
                                                                  ),
                                                                ),
                                                                CustomIconButton(
                                                                  height: 48,
                                                                  width: 48,
                                                                  padding: getPadding(all: 8),
                                                                  onTap: () => showDialog<String>(
                                                                    context: context,
                                                                    builder: (BuildContext context2)
                                                                    {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'Delete'),
                                                                        content:
                                                                        const Text('Are you sure you want to delete this item?'),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'Cancel'),
                                                                            child:
                                                                            const Text('Cancel'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              context.read<ExperienceSettingBloc>().add(
                                                                                DeleteItemEvent(
                                                                                  itemId: project.id,
                                                                                  itemType: "Project",
                                                                                  onDeleteItemError: () {
                                                                                    Fluttertoast.showToast(msg: "Failed Deleting Item", toastLength: Toast.LENGTH_LONG);
                                                                                  },
                                                                                  onDeleteItemSuccess: () {
                                                                                    Fluttertoast.showToast(msg: "Item Deleted Successfully", toastLength: Toast.LENGTH_LONG);
                                                                                    Navigator.pop(context, 'Delete');
                                                                                  },
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                            const Text('Delete'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                  child: Semantics(
                                                                    label: "Delete ${project.title.toString()} project button",
                                                                    child: CustomImageView(
                                                                      svgPath: ImageConstant
                                                                          .svgBinsquare,
                                                                      height: getSize(12),
                                                                      width: getSize(12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                          )
                                                      );
                                                    },
                                                  );
                                                }).toList()
                                            ): const Center(
                                              child: Text(
                                                "Please add your project",
                                              ),
                                            )
                                          ]
                                      )
                                  ),
                                  Center(
                                    child: CustomElevatedButton(
                                        text: "Add New Project",
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        height: 48,
                                        margin: getMargin(left: 24, right: 24, top: 15),
                                        buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
                                          backgroundColor: MaterialStateProperty.all(Colors.black),
                                        ),
                                        onTap: () async {
                                          const storage = FlutterSecureStorage();
                                          await storage.write(key: "itemId", value: null);
                                          NavigatorService.pushNamed(AppRoutes.addNewProjectScreen).then((value){
                                            context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
                                          });
                                        }),
                                  ),



                                  Container(
                                      margin: getMargin(top: 32),
                                      padding: getPadding(all: 16),
                                      decoration: AppDecoration.outlineBluegray50
                                          .copyWith(
                                          borderRadius:
                                          BorderRadiusStyle.circleBorder12),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Padding(
                                                      padding: getPadding(top: 2),
                                                      child: Text(
                                                          "References",
                                                          style: CustomTextStyles
                                                              .titleMediumBold
                                                      )
                                                  ),
                                                ]
                                            ),
                                            state.references != null && state.references!.isNotEmpty ? Column(
                                              children: state.references!.map((reference) {
                                                return Builder(
                                                  builder: (BuildContext context1) {
                                                    return Padding(
                                                        padding:
                                                        getPadding(top: 24, right: 0),
                                                        child: Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                  child: Padding(
                                                                      padding: getPadding(
                                                                          left: 12, top: 5),
                                                                      child: Column(
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            Text(
                                                                                reference.name.toString(),
                                                                                style: CustomTextStyles
                                                                                    .titleSmallPrimarySemiBold),
                                                                            Padding(
                                                                                padding:
                                                                                getPadding(
                                                                                    top: 6),
                                                                                child: Padding(
                                                                                    padding: getPadding(
                                                                                        top:
                                                                                        1),
                                                                                    child: Text(
                                                                                        "${reference.company!.toString()}. ${reference.position.toString()}",
                                                                                        style: theme
                                                                                            .textTheme
                                                                                            .labelLarge))
                                                                            ),
                                                                            Padding(
                                                                                padding:
                                                                                getPadding(
                                                                                    top: 6),
                                                                                child: Text(
                                                                                    "${reference.email.toString()} - ${reference.phoneNumber.toString()}",
                                                                                    style: theme
                                                                                        .textTheme
                                                                                        .labelLarge)
                                                                            )
                                                                          ]))
                                                              ),
                                                              CustomIconButton(
                                                                height: 48,
                                                                width: 48,
                                                                padding: getPadding(all: 8),
                                                                onTap: ()  async {
                                                                  const storage = FlutterSecureStorage();
                                                                  await storage.write(key: "itemId", value: reference.id.toString());
                                                                  NavigatorService.pushNamed(AppRoutes.addNewReferenceScreen).then((value){
                                                                    context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
                                                                  });
                                                                },
                                                                child: Semantics(
                                                                  label: "Edit ${reference.name.toString()} reference button",
                                                                  child: CustomImageView(
                                                                    svgPath: ImageConstant
                                                                        .imgEditsquare,
                                                                    height: getSize(12),
                                                                    width: getSize(12),
                                                                  ),
                                                                ),
                                                              ),
                                                              CustomIconButton(
                                                                height: 48,
                                                                width: 48,
                                                                padding: getPadding(all: 8),
                                                                onTap: () => showDialog<String>(
                                                                  context: context,
                                                                  builder: (BuildContext context2)
                                                                  {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Delete'),
                                                                      content:
                                                                      const Text('Are you sure you want to delete this item?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(context, 'Cancel'),
                                                                          child:
                                                                          const Text('Cancel'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            context.read<ExperienceSettingBloc>().add(
                                                                              DeleteItemEvent(
                                                                                itemId: reference.id,
                                                                                itemType: "Reference",
                                                                                onDeleteItemError: () {
                                                                                  Fluttertoast.showToast(msg: "Failed Deleting Item", toastLength: Toast.LENGTH_LONG);
                                                                                },
                                                                                onDeleteItemSuccess: () {
                                                                                  Fluttertoast.showToast(msg: "Item Deleted Successfully", toastLength: Toast.LENGTH_LONG);
                                                                                  Navigator.pop(context, 'Delete');
                                                                                },
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                          const Text('Delete'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                                child: Semantics(
                                                                  label: "Delete ${reference.name.toString()} reference button",
                                                                  child: CustomImageView(
                                                                    svgPath: ImageConstant
                                                                        .svgBinsquare,
                                                                    height: getSize(12),
                                                                    width: getSize(12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            ) : const Center(
                                              child: Text(
                                                "Please add your references.",
                                              ),
                                            ),
                                          ]
                                      )
                                  ),

                                  Center(
                                    child: CustomElevatedButton(
                                        text: "Add New Reference",
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        height: 48,
                                        margin: getMargin(
                                            left: 24, right: 24, top: 15, bottom: 20),
                                        buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
                                          backgroundColor: MaterialStateProperty.all(Colors.black),
                                        ),
                                        onTap: () async {
                                          const storage = FlutterSecureStorage();
                                          await storage.write(key: "itemId", value: null);
                                          NavigatorService.pushNamed(AppRoutes.addNewReferenceScreen).then((value){
                                            context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
                                          });
                                        }),
                                  ),


                                  Container(
                                      margin: getMargin(top: 32),
                                      padding: getPadding(all: 16),
                                      decoration: AppDecoration.outlineBluegray50
                                          .copyWith(
                                          borderRadius:
                                          BorderRadiusStyle.circleBorder12),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Padding(
                                                      padding: getPadding(top: 2),
                                                      child: Text(
                                                          "Social Links",
                                                          style: CustomTextStyles
                                                              .titleMediumBold
                                                      )
                                                  ),
                                                ]
                                            ),
                                            state.socials != null && state.socials!.isNotEmpty ? Column(
                                              children: state.socials!.map((social) {
                                                return Builder(
                                                  builder: (BuildContext context1) {
                                                    return Padding(
                                                        padding:
                                                        getPadding(top: 24, right: 0),
                                                        child: Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                  child: Padding(
                                                                      padding: getPadding(
                                                                          left: 12, top: 5),
                                                                      child: Column(
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            Text(
                                                                                social.name.toString(),
                                                                                style: CustomTextStyles
                                                                                    .titleSmallPrimarySemiBold),
                                                                            Padding(
                                                                                padding:
                                                                                getPadding(
                                                                                    top: 6),
                                                                                child: Text(
                                                                                    social.url.toString(),
                                                                                    style: theme
                                                                                        .textTheme
                                                                                        .labelLarge)
                                                                            )
                                                                          ]))
                                                              ),
                                                              CustomIconButton(
                                                                height: 48,
                                                                width: 48,
                                                                padding: getPadding(left: 8),
                                                                onTap: ()  async {
                                                                  const storage = FlutterSecureStorage();
                                                                  await storage.write(key: "itemId", value: social.id.toString());
                                                                  NavigatorService.pushNamed(AppRoutes.addNewSocialLinkScreen).then((value){
                                                                    context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
                                                                  });;
                                                                },
                                                                child: Semantics(
                                                                  label: "Edit your ${social.name.toString()} social link button",
                                                                  child: CustomImageView(
                                                                    svgPath: ImageConstant
                                                                        .imgEditsquare,
                                                                    height: getSize(12),
                                                                    width: getSize(12),
                                                                  ),
                                                                ),
                                                              ),
                                                              CustomIconButton(
                                                                height: 48,
                                                                width: 48,
                                                                padding: getPadding(all: 8),
                                                                onTap: () => showDialog<String>(
                                                                  context: context,
                                                                  builder: (BuildContext context2)
                                                                  {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Delete'),
                                                                      content:
                                                                      const Text('Are you sure you want to delete this item?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(context, 'Cancel'),
                                                                          child:
                                                                          const Text('Cancel'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            context.read<ExperienceSettingBloc>().add(
                                                                              DeleteItemEvent(
                                                                                itemId: social.id,
                                                                                itemType: "Social",
                                                                                onDeleteItemError: () {
                                                                                  Fluttertoast.showToast(msg: "Failed Deleting Item", toastLength: Toast.LENGTH_LONG);
                                                                                },
                                                                                onDeleteItemSuccess: () {
                                                                                  Fluttertoast.showToast(msg: "Item Deleted Successfully", toastLength: Toast.LENGTH_LONG);
                                                                                  Navigator.pop(context, 'Delete');
                                                                                },
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                          const Text('Delete'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                                child: Semantics(
                                                                  label: "Delete your ${social.name.toString()} social link button",
                                                                  child: CustomImageView(
                                                                    svgPath: ImageConstant
                                                                        .svgBinsquare,
                                                                    height: getSize(12),
                                                                    width: getSize(12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            ) : const Center(
                                              child: Text(
                                                "Please add links e.g (Linkedin, Behance, Github...)",
                                              ),
                                            ),
                                          ]
                                      )
                                  ),

                                  Center(
                                    child: CustomElevatedButton(
                                        text: "Add New Social Link",
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        height: 48,
                                        margin: getMargin(
                                            left: 24, right: 24, top: 15, bottom: 20),
                                        buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
                                          backgroundColor: MaterialStateProperty.all(Colors.black),
                                        ),
                                        onTap: () async {
                                          const storage = FlutterSecureStorage();
                                          await storage.write(key: "itemId", value: null);
                                          NavigatorService.pushNamed(AppRoutes.addNewSocialLinkScreen).then((value){
                                            context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
                                          });;
                                        }),
                                  ),


                                ]
                            )
                        )
                    )
                ),
              ),
              bottomNavigationBar: CustomElevatedButton(
                  text: "Save",
                  margin: getMargin(left: 24, right: 24, top: 10, bottom: 20),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  onTap: () {
                    //onTapAddnew(context);
                    context.read<ExperienceSettingBloc>().add(
                      SaveResumeDetailsEvent(),
                    );
                  }
              )

            // CustomElevatedButton(
            //     text: "Save",
            //     margin: getMargin(left: 24, right: 24, top: 10, bottom: 20),
            //     buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
            //       backgroundColor: MaterialStateProperty.all(Colors.black),
            //     ),
            //     onTap: () {
            //       //onTapAddnew(context);
            //       // context.read<ExperienceSettingBloc>().add(
            //       //   SaveResumeDetailsEvent(),
            //       // );
            //     }
            // )
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

  editExperience (BuildContext context, int id) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "itemId", value: id.toString());
    NavigatorService.pushNamed(AppRoutes.newPositionScreen).then((value){
      context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
    });
  }

  /// Navigates to the addNewEducationScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the addNewEducationScreen.
  onTapAddnew(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "itemId", value: null);
    await NavigatorService.pushNamed(
      AppRoutes.addNewEducationScreen,
    ).then((value){
      context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
    });;
  }


  /// Navigates to the newPositionScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the newPositionScreen.
  onTapAddnew1(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "itemId", value: null);
    NavigatorService.pushNamed(
      AppRoutes.newPositionScreen,
    ).then((value){
      context.read<ExperienceSettingBloc>().add(ExperienceSettingInitialEvent());
    });
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

    print(croppedFile?.path);

    context.read<ExperienceSettingBloc>().add(
      SetSelectedImage(value: croppedFile!.path),
    );
  }
}


class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceSettingBloc, ExperienceSettingState>(
        builder: (context, state) {
          // rebuild widget...
          return Text("");
        }
    );
  }
}