import 'package:fluttertoast/fluttertoast.dart';
import '../../core/utils/validation_functions.dart';
import 'bloc/new_resume_certification_bloc.dart';
import 'models/new_resume_certification_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_drop_down.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';

class NewCertificationScreen extends StatelessWidget {
  NewCertificationScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<NewCertificationBloc>(
        create: (context) => NewCertificationBloc(
            NewCertificationState(newCertificationModelObj: NewCertificationModel()))
          ..add(NewCertificationInitialEvent()),
        child: NewCertificationScreen());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<NewCertificationBloc, NewCertificationState>(
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
                      label: "button: Back to edit resume page",
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
                          padding: getPadding(left: 24, right: 24, bottom: (MediaQuery.of(context).viewInsets.bottom + 5)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Title",
                                    style: theme.textTheme.titleSmall),
                                BlocSelector<NewCertificationBloc, NewCertificationState,
                                        TextEditingController?>(
                                    selector: (state) => state.titleController,
                                    builder: (context, titleController) {
                                      return CustomTextFormField(
                                          controller: titleController,
                                          margin: getMargin(top: 9),
                                          hintText: "e.g Capstone TRAINING / COURSE / CERTIFICATION",
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter a valid title";
                                            }
                                            return null;
                                          },
                                      );
                                    }
                                ),
                                Padding(
                                    padding: getPadding(top: 18),
                                    child: Text("lbl_start_date".tr,
                                        style: theme.textTheme.titleSmall)),
                                BlocSelector<NewCertificationBloc, NewCertificationState,
                                String?>(
                                selector: (state) => state.startDateLabel,
                                builder: (context, startDateLabel) {
                                  return CustomOutlinedButton(
                                      height: getVerticalSize(70),
                                      text: startDateLabel ?? "Select Date",
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
                                      });
                                }),
                                Padding(
                                    padding: getPadding(top: 18),
                                    child: Text("lbl_end_date".tr,
                                        style: theme.textTheme.titleSmall)),

                                BlocSelector<NewCertificationBloc, NewCertificationState,
                                String?>(
                                selector: (state) => state.endDateLabel,
                                builder: (context, endDateLabel) {
                                  return CustomOutlinedButton(
                                      height: getVerticalSize(70),
                                      text: endDateLabel ?? "Select Date",
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
                                      });
                                }),
                                Padding(
                                    padding: getPadding(top: 20),
                                    child: Text("Description",
                                        style: theme.textTheme.titleSmall)),
                                BlocSelector<NewCertificationBloc, NewCertificationState,
                                        TextEditingController?>(
                                    selector: (state) =>
                                        state.descriptionController,
                                    builder:
                                        (context, descriptionController) {
                                      return CustomTextFormField(
                                          controller: descriptionController,
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
                                              bottom: 20));
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
                        context.read<NewCertificationBloc>().add(
                          SaveTrainingsCoursesCertificationsEvent(
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
    context.read<NewCertificationBloc>().add(
      SaveTrainingsCoursesCertificationsEvent(),
    );
  }

  /// Displays a date picker dialog to update the selected date
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapSelectdate(BuildContext context) async {
    var initialState = BlocProvider.of<NewCertificationBloc>(context).state;
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
      context.read<NewCertificationBloc>().add(
          SetStartDate(startDate: dateTime)
      );
    }
  }

  /// Displays a date picker dialog to update the selected date
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapSelectdate1(BuildContext context) async {
    var initialState = BlocProvider.of<NewCertificationBloc>(context).state;
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
      context.read<NewCertificationBloc>().add(
          SetEndDate(endDate: dateTime)
      );
    }
  }
}
