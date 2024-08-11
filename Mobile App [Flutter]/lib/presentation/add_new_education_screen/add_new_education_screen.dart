import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import 'bloc/add_new_education_bloc.dart';
import 'models/add_new_education_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_drop_down.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';

class AddNewEducationScreen extends StatelessWidget {
  AddNewEducationScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<AddNewEducationBloc>(
        create: (context) => AddNewEducationBloc(AddNewEducationState(
            addNewEducationModelObj: AddNewEducationModel()))
          ..add(AddNewEducationInitialEvent()),
        child: AddNewEducationScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<AddNewEducationBloc, AddNewEducationState>(
        builder: (context, state) {
        return  Form(
          key: _formKey,
          child: Scaffold(
              backgroundColor: appTheme.whiteA70001,
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(
                  height: getVerticalSize(70),
                  leadingWidth: getHorizontalSize(50),
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
                        padding: getPadding(top: 32),
                        child: Padding(
                            padding: getPadding(left: 24, right: 24, bottom: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("lbl_school".tr,
                                      style: theme.textTheme.titleSmall),
                                  BlocSelector<
                                          AddNewEducationBloc,
                                          AddNewEducationState,
                                          TextEditingController?>(
                                      selector: (state) => state.schoolNameController,
                                      builder: (context, schoolNameController) {
                                        return Semantics(
                                          label: "Add / Edit school name",
                                          child: CustomTextFormField(
                                              controller: schoolNameController,
                                              margin: getMargin(top: 9),
                                              hintText:
                                                  "msg_ex_harvard_university".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                            validator: (value) {
                                              if (value == null || value == "") {
                                                return "Please enter a valid school name";
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("Level",
                                          style: theme.textTheme.titleSmall)),
                                  BlocSelector<
                                      AddNewEducationBloc,
                                      AddNewEducationState,
                                      TextEditingController?>(
                                      selector: (state) =>
                                      state.educationLevelController,
                                      builder: (context, frameonetwoController) {
                                        return Semantics(
                                          label: "Add / Edit eduction certificate received",
                                          child: CustomTextFormField(
                                              controller: frameonetwoController,
                                              margin: getMargin(top: 9),
                                              hintText: "Msc, Bsc...",
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                            validator: (value) {
                                              if (value == null || value == "") {
                                                return "Please enter a valid level";
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      }),
                                  Padding(
                                      padding: getPadding(top: 20),
                                      child: Text("lbl_field_of_study".tr,
                                          style: theme.textTheme.titleSmall)),
                                  BlocSelector<
                                          AddNewEducationBloc,
                                          AddNewEducationState,
                                          TextEditingController?>(
                                      selector: (state) =>
                                          state.disciplineController,
                                      builder: (context, frameoneoneController) {
                                        return Semantics(
                                          label: "Add / Edit education discipline",
                                          child: CustomTextFormField(
                                              controller: frameoneoneController,
                                              margin: getMargin(top: 7),
                                              hintText: "lbl_ex_business".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                            // validator: (value) {
                                            //   if (value == null || value == "") {
                                            //     return "Please enter a valid field of study";
                                            //   }
                                            //   return null;
                                            // },
                                          ),
                                        );
                                      }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("lbl_start_date".tr,
                                          style: theme.textTheme.titleSmall)),
                                  CustomOutlinedButton(
                                      height: getVerticalSize(70),
                                      text: state.startDateLabel.toString(),
                                      margin: getMargin(top: 9),
                                      rightIcon: Container(
                                          margin: getMargin(left: 30),
                                          child: CustomImageView(
                                              svgPath: ImageConstant.imgCalendar)),
                                      buttonStyle: CustomButtonStyles.outlineIndigo,
                                      buttonTextStyle:
                                          CustomTextStyles.titleMediumBluegray400,
                                      onTap: () {
                                        onTapSelectdate(context);
                                      }),
                                  Padding(
                                      padding: getPadding(top: 18),
                                      child: Text("lbl_end_date".tr,
                                          style: theme.textTheme.titleSmall)),
                                  CustomOutlinedButton(
                                      height: getVerticalSize(70),
                                      text: state.endDateLabel.toString(),
                                      margin: getMargin(top: 9),
                                      rightIcon: Container(
                                          margin: getMargin(left: 30),
                                          child: CustomImageView(
                                              svgPath: ImageConstant.imgCalendar)),
                                      buttonStyle: CustomButtonStyles.outlineIndigo,
                                      buttonTextStyle:
                                          CustomTextStyles.titleMediumBluegray400,
                                      onTap: () {
                                        onTapSelectdate1(context);
                                      }),
                                  BlocSelector<
                                      AddNewEducationBloc,
                                      AddNewEducationState,
                                      bool?>(
                                      selector: (state) => state.currentlySchoolHere,
                                      builder: (context,
                                          currentlyWorkHere) {
                                        return CustomCheckboxButton(
                                            text:
                                            "Currently schooling here"
                                                .tr,
                                            value:
                                            currentlyWorkHere,
                                            margin:
                                            getMargin(
                                                top: 5),
                                            textStyle:
                                            CustomTextStyles
                                                .titleSmallPoppinsBluegray300,
                                            onChange:
                                                (value) {
                                              context
                                                  .read<
                                                  AddNewEducationBloc>()
                                                  .add(ChangeCheckBoxEvent(
                                                  value:
                                                  value));
                                            });
                                      }),
                                  Padding(
                                      padding: getPadding(top: 20),
                                      child: Text("lbl_description".tr,
                                          style: theme.textTheme.titleSmall)),
                                  BlocSelector<
                                          AddNewEducationBloc,
                                          AddNewEducationState,
                                          TextEditingController?>(
                                      selector: (state) =>
                                          state.descriptionController,
                                      builder: (context, groupEightyOneController) {
                                        return Semantics(
                                          label: "Add / Edit education description",
                                          child: CustomTextFormField(
                                              controller: groupEightyOneController,
                                              margin: getMargin(top: 7),
                                              hintText: "lbl_lorem_ipsun".tr,
                                              hintStyle: CustomTextStyles
                                                  .titleMediumBluegray400,
                                              textInputAction: TextInputAction.done,
                                              maxLines: 6,
                                              contentPadding: getPadding(
                                                  left: 16,
                                                  top: 20,
                                                  right: 16,
                                                  bottom: 20)
                                          ),
                                        );
                                      })
                                ]
                            )))),
              ),
              bottomNavigationBar: CustomElevatedButton(
                  text: "lbl_save_changes".tr,
                  margin: getMargin(left: 24, right: 24, bottom: 37),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddNewEducationBloc>().add(
                        SaveEducationEvent(
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
                  )),
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
    NavigatorService.pushNamed(
      AppRoutes.experienceSettingScreen,
    );
  }

  /// Displays a date picker dialog to update the selected date
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapSelectdate(BuildContext context) async {
    var initialState = BlocProvider.of<AddNewEducationBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  // Primary colors
                  primary: Colors.black,
                  primaryContainer: Colors.black,
                  secondary: Colors.black,
                  secondaryContainer: Colors.black,
                  tertiary: Colors.black,
                  tertiaryContainer: Colors.black,

                  background: Colors.black,
                  onPrimary: Colors.white, // selected text color
                  surface: Colors.white,
                  surfaceTint: Colors.white,
                  surfaceVariant: Colors.black,
                  onSurface: Colors.black,// default text color
                  // Inverse colors
                  inversePrimary: Colors.black,
                  inverseSurface: Colors.black,
                  // Pending colors
                  onSurfaceVariant: Colors.black,
                  // circle color
                ),
                dialogBackgroundColor: Colors.black54,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.normal,
                          // fontSize: 12,
                          // fontFamily: 'Quicksand'
                        ),
                        foregroundColor: Colors.black, // color of button's letters
                        backgroundColor: Colors.white, // Background color
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)
                        )
                    )
                )),
            child: child!,
          );
        }
    );

    if(dateTime != null){
      context.read<AddNewEducationBloc>().add(
          SetStartDate(startDate: dateTime)
      );
    }

  }

  /// Displays a date picker dialog to update the selected date
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapSelectdate1(BuildContext context) async {
    var initialState = BlocProvider.of<AddNewEducationBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  // Primary colors
                  primary: Colors.black,
                  primaryContainer: Colors.black,
                  secondary: Colors.black,
                  secondaryContainer: Colors.black,
                  tertiary: Colors.black,
                  tertiaryContainer: Colors.black,

                  background: Colors.black,
                  onPrimary: Colors.white, // selected text color
                  surface: Colors.white,
                  surfaceTint: Colors.white,
                  surfaceVariant: Colors.black,
                  onSurface: Colors.black,// default text color
                  // Inverse colors
                  inversePrimary: Colors.black,
                  inverseSurface: Colors.black,
                  // Pending colors
                  onSurfaceVariant: Colors.black,
                  // circle color
                ),
                dialogBackgroundColor: Colors.black54,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.normal,
                          // fontSize: 12,
                          // fontFamily: 'Quicksand'
                        ),
                        foregroundColor: Colors.black, // color of button's letters
                        backgroundColor: Colors.white, // Background color
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)
                        )
                    )
                )),
            child: child!,
          );
        }

    );


    //Set an event to set relevant states (startDateLabel and startDate)
    if(dateTime != null){
      context.read<AddNewEducationBloc>().add(
          SetEndDate(endDate: dateTime)
      );
    }

  }
}
