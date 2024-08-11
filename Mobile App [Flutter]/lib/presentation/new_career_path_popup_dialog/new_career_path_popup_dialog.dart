import '../../widgets/custom_text_form_field.dart';
import 'bloc/new_career_path_popup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';


class NewCareerPathPopupDialog extends StatelessWidget {
   const NewCareerPathPopupDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<NewCareerPathPopupBloc>(
        create: (context) => NewCareerPathPopupBloc(NewCareerPathPopupState())
          ..add(NewCareerPathPopupInitialEvent()
          ),
        child: const NewCareerPathPopupDialog()
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);


    return SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            // margin: getMargin(bottom: 241),
            padding: getPadding(all: 32),
            decoration: AppDecoration.fillOnPrimaryContainer
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Semantics(
                    label: "back to previous page",
                    child: SizedBox(
                      height: 48,
                      child: CustomImageView(
                          svgPath: ImageConstant.imgClose2,
                          color: Colors.black,
                          height: getSize(32),
                          width: getSize(32),
                          alignment: Alignment.centerRight,
                          margin: getMargin(left: 1),
                          onTap: () {
                            onTapCancel(context);
                          }),
                    ),
                  ),
                  Container(
                      width: getHorizontalSize(229),
                      margin: getMargin(left: 6, top: 8, right: 5, bottom: 30),
                      child: Text(
                          "Sia: Enter a career of your choice and I will generate a complete roadmap with courses for each section.",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.titleSmallBluegray400.copyWith(height: 1.57)
                      )
                  ),

                  // Text("Enter a career:",
                  //     style: CustomTextStyles.titleSmallPrimary),
                  BlocSelector<NewCareerPathPopupBloc, NewCareerPathPopupState,
                      TextEditingController?>(
                      selector: (state) =>
                      state.careerNameController,
                      builder: (context, careerNameController) {
                        return Semantics(
                          label: "Enter career here",
                          child: CustomTextFormField(
                              controller: careerNameController,
                              margin: getMargin(top: 9),
                              hintText: "Enter career here",
                              hintStyle: CustomTextStyles
                                  .titleMediumBluegray400),
                        );
                      }),

                  Padding(
                      padding: getPadding(top: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: CustomOutlinedButton(
                                    height: getVerticalSize(70),
                                    text: "Generate roadmap",
                                    margin: getMargin(right: 6),
                                    buttonStyle:
                                        CustomButtonStyles.outlinePrimaryTL20,
                                    buttonTextStyle: CustomTextStyles
                                        .titleSmallPrimarySemiBold,
                                    onTap: () {
                                      onTapGenerateRoadmap(context);
                                    })),
                          ]))
                ])));
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCreateAcountScreen.
  onTapGenerateRoadmap(BuildContext context) async {
    context.read<NewCareerPathPopupBloc>().add(GenerateNewCareerPathEvent());
  }

  /// Navigates to the settingsScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the settingsScreen.
  onTapCancel(BuildContext context) {
    Navigator.pop(context);
  }
}
