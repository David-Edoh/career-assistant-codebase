import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/validation_functions.dart';
import 'bloc/new_social_link_bloc.dart';
import 'models/new_social_link_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_drop_down.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';

class NewSocialLinktScreen extends StatelessWidget {
  NewSocialLinktScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<NewSocialLinkBloc>(
        create: (context) => NewSocialLinkBloc(
            NewSocialLinkState(newSocialLinkModelObj: NewSocialLinkModel()))
          ..add(NewSocialLinkInitialEvent()),
        child: NewSocialLinktScreen());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<NewSocialLinkBloc, NewSocialLinkState>(
        builder: (context, state)
    {
      return Form(
        key: _formKey,
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            resizeToAvoidBottomInset: false,
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
              child: SizedBox(
                  width: mediaQueryData.size.width,
                  child: SingleChildScrollView(
                      padding: getPadding(top: 36),
                      child: Padding(
                          padding: getPadding(left: 24, right: 24, bottom: 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Social Platform",
                                    style: theme.textTheme.titleSmall),
                                BlocSelector<NewSocialLinkBloc,
                                    NewSocialLinkState,
                                    TextEditingController?>(
                                    selector: (state) =>
                                    state.socialNameController,
                                    builder: (context, socialNameController) {
                                      return Semantics(
                                        label: "Add / Edit social platform name",
                                        child: CustomTextFormField(
                                          controller: socialNameController,
                                          margin: getMargin(top: 9),
                                          hintText: "e.g Linkedin",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid name";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }
                                ),
                    
                                Padding(
                                  padding: getPadding(top: 18),
                                  child: Text("Username",
                                      style: theme.textTheme.titleSmall),
                                ),
                                BlocSelector<NewSocialLinkBloc,
                                    NewSocialLinkState,
                                    TextEditingController?>(
                                    selector: (state) =>
                                    state.socialUsernameController,
                                    builder: (context, socialUsernameController) {
                                      return Semantics(
                                        label: "Add / Edit your username on the social platfor",
                                        child: CustomTextFormField(
                                          controller: socialUsernameController,
                                          margin: getMargin(top: 9),
                                          hintText: "john_doe",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid username";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }
                                ),
                    
                                Padding(
                                  padding: getPadding(top: 18),
                                  child: Text("Social Profile Link",
                                      style: theme.textTheme.titleSmall),
                                ),
                                BlocSelector<NewSocialLinkBloc,
                                    NewSocialLinkState,
                                    TextEditingController?>(
                                    selector: (state) =>
                                    state.socialLinkController,
                                    builder: (context, socialLinkController) {
                                      return Semantics(
                                        label: "Add / Edit your profile link on the social platform.",
                                        child: CustomTextFormField(
                                          controller: socialLinkController,
                                          margin: getMargin(top: 9),
                                          hintText: "e.g https://linkedin.com/me/john_doe",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid url";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }
                                ),
                    
                    
                              ])))),
            ),
            bottomNavigationBar:
            CustomElevatedButton(
                text: "lbl_save_changes".tr,
                margin: getMargin(left: 24, right: 24, bottom: 37),
                buttonStyle: CustomButtonStyles.fillPrimary,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<NewSocialLinkBloc>().add(
                      SaveSocialLinkEvent(
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
    context.read<NewSocialLinkBloc>().add(
      SaveSocialLinkEvent(),
    );
  }

}
