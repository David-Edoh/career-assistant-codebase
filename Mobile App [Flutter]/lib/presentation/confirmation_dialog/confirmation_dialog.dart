import 'bloc/confirmation_bloc.dart';
import 'models/confirmation_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ConfirmationBloc>(
        create: (context) => ConfirmationBloc(
            ConfirmationState(confirmationModelObj: ConfirmationModel()))
          ..add(ConfirmationInitialEvent()),
        child: ConfirmationDialog());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Container(
        width: getHorizontalSize(331),
        padding: getPadding(left: 25, top: 39, right: 25, bottom: 39),
        decoration: AppDecoration.fillWhiteA700
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: getHorizontalSize(279),
                  margin: getMargin(top: 3),
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "lbl_i_agree_to_the".tr,
                            style: CustomTextStyles.titleMediumBluegray400_2),
                        TextSpan(
                            text: "msg_terms_of_service".tr,
                            style: theme.textTheme.titleMedium),
                        TextSpan(
                            text: "lbl_and".tr,
                            style: CustomTextStyles.titleMediumBluegray400_2),
                        TextSpan(
                            text: "msg_conditions_of_use".tr,
                            style: theme.textTheme.titleMedium),
                        TextSpan(
                            text: "msg_including_consent".tr,
                            style: CustomTextStyles.titleMediumBluegray400_2)
                      ]),
                      textAlign: TextAlign.center)),
              CustomElevatedButton(
                  height: getVerticalSize(46),
                  width: getHorizontalSize(181),
                  text: "msg_agree_and_continue".tr,
                  margin: getMargin(top: 21),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                  buttonTextStyle: CustomTextStyles.titleSmallGray5001,
                  onTap: () {
                    onTapAgreeand(context);
                  }),
              Padding(
                  padding: getPadding(top: 28),
                  child: Text("lbl_disgree".tr,
                      style: CustomTextStyles.titleSmallRedA200))
            ]));
  }

  /// Navigates to the homeContainerScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the homeContainerScreen.
  onTapAgreeand(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.homeContainerScreen,
    );
  }
}
