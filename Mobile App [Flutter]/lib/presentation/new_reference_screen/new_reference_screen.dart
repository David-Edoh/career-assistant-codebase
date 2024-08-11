import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/validation_functions.dart';
import 'bloc/new_reference_bloc.dart';
import 'models/new_reference_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_drop_down.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';

class NewReferenceScreen extends StatelessWidget {
  NewReferenceScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<NewReferenceBloc>(
        create: (context) => NewReferenceBloc(
            NewReferenceState(newReferenceModelObj: NewReferenceModel()))
          ..add(NewReferenceInitialEvent()),
        child: NewReferenceScreen());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<NewReferenceBloc, NewReferenceState>(
        builder: (context, state) {
          return  Form(
            key: _formKey,
            child: Scaffold(
                backgroundColor: appTheme.whiteA70001,
                resizeToAvoidBottomInset: true,
                appBar: CustomAppBar(
                    leadingWidth: getHorizontalSize(50),
                    height: getVerticalSize(70),
                    leading: Semantics(
                      label: "Back to edit resume page",
                      child: AppbarImage(
                          svgPath: ImageConstant.imgGroup162799,
                          margin: getMargin(left: 24, top: 13, bottom: 13),
                          onTap: () {
                            onTapArrowbackone(context);
                          }),
                    ),
                    centerTitle: true,
                    title: AppbarTitle(
                        text: state.screenTitle.toString(),
                      margin: const EdgeInsets.only(right: 40),
                    )),
                body: SafeArea(
                  child: SingleChildScrollView(
                      padding: getPadding(top: 36),
                      child: Padding(
                          padding: getPadding(left: 24, right: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Full Name",
                                    style: theme.textTheme.titleSmall),
                                BlocSelector<NewReferenceBloc, NewReferenceState,
                                    TextEditingController?>(
                                    selector: (state) => state.fullNameController,
                                    builder: (context, fullNameController) {
                                      return Semantics(
                                        label: "Add / Edit reference person name field",
                                        child: CustomTextFormField(
                                          controller: fullNameController,
                                          margin: getMargin(top: 9),
                                          hintText: "full name",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid title";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }
                                ),
                                Padding(
                                  padding: getPadding(top: 18),
                                  child: Text("Title",
                                      style: theme.textTheme.titleSmall),
                                ),
                                BlocSelector<NewReferenceBloc, NewReferenceState,
                                        TextEditingController?>(
                                    selector: (state) => state.jobTitleController,
                                    builder: (context, jobTitleController) {
                                      return Semantics(
                                        label: "Add / Edit reference person title field",
                                        child: CustomTextFormField(
                                            controller: jobTitleController,
                                            margin: getMargin(top: 9),
                                            hintText: "job title",
                                            hintStyle: CustomTextStyles
                                                .titleMediumBluegray400,
                                            validator: (value) {
                                              if (value == null || value == "") {
                                                return "Please enter a valid title";
                                              }
                                              return null;
                                            },
                                        ),
                                      );
                                    }
                                ),
                                Padding(
                                  padding: getPadding(top: 18),
                                  child: Text("Company",
                                      style: theme.textTheme.titleSmall),
                                ),
                                BlocSelector<NewReferenceBloc, NewReferenceState,
                                    TextEditingController?>(
                                    selector: (state) => state.companyController,
                                    builder: (context, companyController) {
                                      return Semantics(
                                        label: "Add / Edit reference person company name field",
                                        child: CustomTextFormField(
                                          controller: companyController,
                                          margin: getMargin(top: 9),
                                          hintText: "company name",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid title";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }
                                ),
                                Padding(
                                  padding: getPadding(top: 18),
                                  child: Text("Phone Number",
                                      style: theme.textTheme.titleSmall),
                                ),
                                BlocSelector<NewReferenceBloc, NewReferenceState,
                                    TextEditingController?>(
                                    selector: (state) => state.phoneNumberController,
                                    builder: (context, phoneNumberController) {
                                      return Semantics(
                                        label: "Add / Edit reference person phone-number field",
                                        child: CustomTextFormField(
                                          controller: phoneNumberController,
                                          margin: getMargin(top: 9),
                                          hintText: "phone number",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid title";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }
                                ),
                                Padding(
                                  padding: getPadding(top: 18),
                                  child: Text("Email",
                                      style: theme.textTheme.titleSmall),
                                ),
                                BlocSelector<NewReferenceBloc, NewReferenceState,
                                    TextEditingController?>(
                                    selector: (state) => state.emailController,
                                    builder: (context, emailController) {
                                      return Semantics(
                                        label: "Add / Edit reference person email address field",
                                        child: CustomTextFormField(
                                          controller: emailController,
                                          margin: getMargin(top: 9),
                                          hintText: "email address",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid title";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }
                                ),
                                Padding(
                                    padding: getPadding(top: 20),
                                    child: Text("Address",
                                        style: theme.textTheme.titleSmall)),
                                BlocSelector<NewReferenceBloc, NewReferenceState,
                                        TextEditingController?>(
                                    selector: (state) =>
                                        state.addressController,
                                    builder:
                                        (context, addressController) {
                                      return Semantics(
                                        label: "Add / Edit reference person description field",
                                        child: CustomTextFormField(
                                            controller: addressController,
                                            margin: getMargin(top: 7),
                                            hintText: "lbl_lorem_ipsun".tr,
                                            hintStyle: CustomTextStyles
                                                .titleMediumBluegray400,
                                            validator: (value) {
                                              if (value == null || value == "") {
                                                return "Please enter a valid description";
                                              }
                                              return null;
                                            },
                                            textInputAction: TextInputAction.done,
                                            maxLines: 6,
                                            contentPadding: getPadding(
                                                left: 16,
                                                top: 20,
                                                right: 16,
                                                bottom: 20)),
                                      );
                                    })
                              ]))),
                ),
                bottomNavigationBar:
                CustomElevatedButton(
                    text: "lbl_save_changes".tr,
                    margin: getMargin(left: 24, right: 24, bottom: 37),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<NewReferenceBloc>().add(
                          SaveReferenceEvent(
                            onSaveUserDetailsError: () {
                              _onSaveUserDataEventError(context);
                            },
                            onSaveUserDetailsSuccess: () {
                              NavigatorService.goBack();
                            },
                          ),
                        );
                        //navigate back to edit resume screen
                        // NavigatorService.goBack();
                      }
                    }
                    )
            ),
          );
  });
  }

  void _onSaveUserDataEventError(BuildContext context) {
    Fluttertoast.showToast(msg: "An error occurred while trying save your data.", toastLength: Toast.LENGTH_LONG);
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

  /// Navigates to the experienceSettingScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the experienceSettingScreen.
  onTapSavechanges(BuildContext context) {
    //Save details
    context.read<NewReferenceBloc>().add(
      SaveReferenceEvent(),
    );
  }




}
