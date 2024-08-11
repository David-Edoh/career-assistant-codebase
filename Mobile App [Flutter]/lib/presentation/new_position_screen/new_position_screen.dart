import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import 'bloc/new_position_bloc.dart';
import 'models/new_position_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_drop_down.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class NewPositionScreen extends StatelessWidget {
  NewPositionScreen({Key? key}) : super(key: key);


  static Widget builder(BuildContext context) {
    return BlocProvider<NewPositionBloc>(
        create: (context) => NewPositionBloc(
            NewPositionState(newPositionModelObj: NewPositionModel()))
          ..add(NewPositionInitialEvent()),
        child: NewPositionScreen());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final toolbarColor = Colors.grey.shade200;
    const backgroundColor = Colors.white70;
    const toolbarIconColor = Colors.black87;
    const editorTextStyle = TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontFamily: 'Roboto');
    const hintTextStyle = TextStyle(
        fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

    bool _hasFocus = false;


    return BlocBuilder<NewPositionBloc, NewPositionState>(
        builder: (context, state) {
          return Form(
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
                      // reverse: true,
                      child: Padding(
                          padding: getPadding(
                              left: 24, right: 24, bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("lbl_title".tr,
                                    style: theme.textTheme.titleSmall),
                                BlocSelector<NewPositionBloc,
                                    NewPositionState,
                                    TextEditingController?>(
                                    selector: (state) =>
                                    state.positionTitleController,
                                    builder: (context, positionTitleController) {
                                      return Semantics(
                                        label: "Add / Edit job title field",
                                        child: CustomTextFormField(
                                          controller: positionTitleController,
                                          margin: getMargin(top: 9),
                                          hintText: "lbl_ex_ui_designer".tr,
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null ||
                                                value == "") {
                                              return "Please enter a valid title";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }),
                                // Container(
                                //     margin: getMargin(top: 20),
                                //     decoration: BoxDecoration(
                                //         borderRadius:
                                //             BorderRadiusStyle.roundedBorder8),
                                //     child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         children: [
                                //           Text("lbl_employment_type".tr,
                                //               style: theme.textTheme.titleSmall),
                                //           BlocSelector<
                                //                   NewPositionBloc,
                                //                   NewPositionState,
                                //                   NewPositionModel?>(
                                //               selector: (state) =>
                                //                   state.newPositionModelObj,
                                //               builder:
                                //                   (context, newPositionModelObj) {
                                //                 return CustomDropDown(
                                //                     icon: Container(
                                //                         margin: getMargin(
                                //                             left: 30, right: 19),
                                //                         child: CustomImageView(
                                //                             svgPath: ImageConstant
                                //                                 .imgArrowdown)),
                                //                     margin: getMargin(top: 7),
                                //                     hintText:
                                //                         "lbl_please_select".tr,
                                //                     hintStyle: CustomTextStyles
                                //                         .titleMediumBluegray400,
                                //                     items: newPositionModelObj
                                //                             ?.dropdownItemList ??
                                //                         [],
                                //                     onChanged: (value) {
                                //                       context
                                //                           .read<NewPositionBloc>()
                                //                           .add(
                                //                               ChangeDropDownEvent(
                                //                                   value: value));
                                //                     });
                                //               })
                                //         ])),
                                Padding(
                                    padding: getPadding(top: 20),
                                    child: Text("lbl_company_name".tr,
                                        style: theme.textTheme
                                            .titleSmall)),
                                BlocSelector<NewPositionBloc,
                                    NewPositionState,
                                    TextEditingController?>(
                                    selector: (state) =>
                                    state.companyNameController,
                                    builder: (context,
                                        companyNameController) {
                                      return Semantics(
                                        label: "Add / Edit company name field",
                                        child: CustomTextFormField(
                                          controller: companyNameController,
                                          margin: getMargin(top: 7),
                                          hintText: "lbl_ex_shopee".tr,
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null ||
                                                value == "") {
                                              return "Please enter a valid company name";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }),
                                Padding(
                                    padding: getPadding(top: 18),
                                    child: Text("Address (City and Country)",
                                        style: theme.textTheme
                                            .titleSmall)),
                                BlocSelector<NewPositionBloc,
                                    NewPositionState,
                                    TextEditingController?>(
                                    selector: (state) =>
                                    state.locationController,
                                    builder: (context,
                                        locationController) {
                                      return Semantics(
                                        label: "Add / Edit company address field",
                                        child: CustomTextFormField(
                                          controller: locationController,
                                          margin: getMargin(top: 9),
                                          hintText:
                                          "msg_ex_singapore_singapore".tr,
                                          hintStyle: CustomTextStyles
                                              .titleMediumBluegray400,
                                          validator: (value) {
                                            if (value == null ||
                                                value == "") {
                                              return "Please enter a valid address";
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    }),
                                Padding(
                                    padding: getPadding(top: 18),
                                    child: Text(
                                      "lbl_start_date".tr,
                                      style: theme.textTheme.titleSmall,
                                    )
                                ),
                               CustomOutlinedButton(
                                          height: getVerticalSize(70),
                                          text: state.startDateLabel.toString(),
                                          margin: getMargin(top: 9),
                                          rightIcon: Container(
                                              margin: getMargin(left: 30),
                                              child: CustomImageView(
                                                  svgPath: ImageConstant
                                                      .imgCalendar)),
                                          buttonStyle: CustomButtonStyles
                                              .outlineIndigo,
                                          buttonTextStyle:
                                          CustomTextStyles
                                              .titleMediumBluegray400,
                                          onTap: () {
                                            onTapSelectDate(context);
                                          }),
                                Padding(
                                    padding: getPadding(top: 18),
                                    child: Text("lbl_end_date".tr,
                                        style: theme.textTheme
                                            .titleSmall)),

                                CustomOutlinedButton(
                                          height: getVerticalSize(70),
                                          text: state.endDateLabel.toString(),
                                          margin: getMargin(top: 9),
                                          rightIcon: Container(
                                              margin: getMargin(left: 30),
                                              child: CustomImageView(
                                                  svgPath: ImageConstant
                                                      .imgCalendar)),
                                          buttonStyle: CustomButtonStyles
                                              .outlineIndigo,
                                          buttonTextStyle:
                                          CustomTextStyles
                                              .titleMediumBluegray400,
                                          onTap: () {
                                            onTapSelectDate1(context);
                                          }
                                          ),
                                BlocSelector<
                                    NewPositionBloc,
                                    NewPositionState,
                                    bool?>(
                                    selector: (state) => state.currentlyWorkHere,
                                    builder: (context,
                                        currentlyWorkHere) {
                                      return CustomCheckboxButton(
                                          decoration: const BoxDecoration(
                                            color: Colors.white
                                          ),
                                          text: "Currently work here".tr,
                                          value: currentlyWorkHere,
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
                                                NewPositionBloc>()
                                                .add(ChangeCheckBoxEvent(
                                                value:
                                                value));
                                          });
                                    }),
                                Padding(
                                    padding: getPadding(top: 20, bottom: 10),
                                    child: Text(
                                        "Job Role Description (Bullet points)",
                                        style: theme.textTheme
                                            .titleSmall)),
                                // BlocSelector<NewPositionBloc,
                                //     NewPositionState,
                                //     TextEditingController?>(
                                //     selector: (state) =>
                                //     state.jobDescriptionController,
                                //     builder:
                                //         (context,
                                //         jobDescriptionController) {
                                //       return CustomTextFormField(
                                //           controller: jobDescriptionController,
                                //           margin: getMargin(top: 7),
                                //           hintText: "lbl_lorem_ipsun".tr,
                                //           hintStyle: CustomTextStyles
                                //               .titleMediumBluegray400,
                                //           validator: (value) {
                                //             if (value == null ||
                                //                 value == "") {
                                //               return "Please enter a valid description";
                                //             }
                                //             return null;
                                //           },
                                //           textInputAction: TextInputAction
                                //               .done,
                                //           maxLines: 6,
                                //           contentPadding: getPadding(
                                //               left: 16,
                                //               top: 20,
                                //               right: 16,
                                //               bottom: 20));
                                //     }),

                                state.richEditorController != null ? Semantics(
                                  excludeSemantics: true,
                                  child: BlocSelector<NewPositionBloc,
                                      NewPositionState,
                                      QuillEditorController?>(
                                      selector: (state) =>
                                      state.richEditorController,
                                      builder:
                                          (context, richEditorController) {
                                        return SizedBox(
                                          // height: 300,
                                          child: Column(
                                            children: [
                                              ToolBar(
                                                toolBarColor: toolbarColor,
                                                padding: const EdgeInsets.all(8),
                                                iconSize: 25,
                                                iconColor: toolbarIconColor,
                                                activeIconColor: Colors.greenAccent.shade400,
                                                controller: richEditorController as QuillEditorController,
                                                crossAxisAlignment: WrapCrossAlignment.start,
                                                direction: Axis.horizontal,
                                                customButtons: [
                                                  Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius.circular(15)),
                                                  ),
                                                  InkWell(
                                                      onTap: () => unFocusEditor(state),
                                                      child: const Icon(
                                                        Icons.favorite,
                                                        color: Colors.black,
                                                      )),
                                                  InkWell(
                                                      onTap: () async {
                                                        var selectedText = await richEditorController.getSelectedText();
                                                        // debugPrint('selectedText $selectedText');
                                                        var selectedHtmlText =
                                                        await richEditorController.getSelectedHtmlText();
                                                        debugPrint('selectedHtmlText $selectedHtmlText');
                                                      },
                                                      child: const Icon(
                                                        Icons.add_circle,
                                                        color: Colors.black,
                                                      )),
                                                ],
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0,1,0,1),
                                                // padding: const EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child: Expanded(
                                                  child: QuillHtmlEditor(
                                                    text: state.initialDescription,
                                                    hintText: 'Describe your role here',
                                                    controller: richEditorController,
                                                    isEnabled: true,
                                                    ensureVisible: true,
                                                    minHeight: 150,
                                                    autoFocus: true,
                                                    textStyle: editorTextStyle,
                                                    hintTextStyle: hintTextStyle,
                                                    hintTextAlign: TextAlign.start,
                                                    padding: const EdgeInsets.only(left: 10, top: 10),
                                                    hintTextPadding: const EdgeInsets.only(left: 20),
                                                    backgroundColor: backgroundColor,
                                                    // inputAction: InputAction.newline,
                                                    // onEditingComplete: (s) => debugPrint('Editing completed $s'),

                                                    // loadingBuilder: (context) {
                                                    //   return const Center(
                                                    //       child: CircularProgressIndicator(
                                                    //         strokeWidth: 1,
                                                    //         color: Colors.red,
                                                    //       ));
                                                    // },

                                                    onFocusChanged: (focus) {
                                                      debugPrint('has focus $focus');
                                                      // setState(() {
                                                      //   _hasFocus = focus;
                                                      // });
                                                    },
                                                    onTextChanged: (text) => debugPrint('widget text change $text'),
                                                    onEditorCreated: () {
                                                      // debugPrint('Editor has been loaded');
                                                      // setHtmlText('Testing text on load');
                                                    },
                                                    onEditorResized: (height) =>
                                                        debugPrint('Editor resized $height'),
                                                    onSelectionChanged: (sel) =>
                                                        debugPrint('index ${sel.index}, range ${sel.length}'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ) : const Text("Loading rich editor"),
                              ]))),
                ),
                bottomNavigationBar:
                CustomElevatedButton(
                    text: "lbl_save_changes".tr,
                    margin: getMargin(left: 24, right: 24, bottom: 37),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<NewPositionBloc>().add(
                          SavePositionEvent(
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

  void unFocusEditor(NewPositionState state) => state.richEditorController?.unFocus();

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
    context.read<NewPositionBloc>().add(
      SavePositionEvent(),
    );
  }

  /// Displays a date picker dialog to update the selected date
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapSelectDate(BuildContext context) async {
    var initialState = BlocProvider.of<NewPositionBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: initialState.startDate as DateTime,
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

    // initialState.startDate = dateTime;

    //Set an event to set relevant states (startDateLabel and startDate)
    if(dateTime != null)
    {
      context.read<NewPositionBloc>().add(
          SetStartDate(startDate: dateTime)
      );
    }

  }

  /// Displays a date picker dialog to update the selected date
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapSelectDate1(BuildContext context) async {
    var initialState = BlocProvider.of<NewPositionBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: initialState.endDate as DateTime,
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

    // initialState.endDate = dateTime;

    //Set an event to set relevant states (startDateLabel and startDate)
    if(dateTime != null)
    {
      context.read<NewPositionBloc>().add(
          SetEndDate(endDate: dateTime)
      );
    }
  }
}
