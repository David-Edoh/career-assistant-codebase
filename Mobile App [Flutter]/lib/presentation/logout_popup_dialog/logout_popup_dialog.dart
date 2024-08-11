import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/apiClient/api_client.dart';

import 'bloc/logout_popup_bloc.dart';
import 'models/logout_popup_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPopupDialog extends StatelessWidget {
   LogoutPopupDialog({Key? key}) : super(key: key);

  final _apiClient = ApiClient();

  static Widget builder(BuildContext context) {
    return BlocProvider<LogoutPopupBloc>(
        create: (context) => LogoutPopupBloc(
            LogoutPopupState(logoutPopupModelObj: newCareerPathPopupModel()))
          ..add(LogoutPopupInitialEvent()),
        child: LogoutPopupDialog());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);


    return SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            margin: getMargin(left: 34, right: 34, bottom: 241),
            padding: getPadding(all: 32),
            decoration: AppDecoration.fillOnPrimaryContainer
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Semantics(
                    label: "Are you sure you want to logout Image.",
                    child: CustomImageView(
                        svgPath: ImageConstant.imgQuestion,
                        height: getSize(82),
                        width: getSize(82),
                        margin: getMargin(top: 9)),
                  ),
                  Padding(
                      padding: getPadding(top: 35),
                      child: Text("lbl_are_you_sure".tr,
                          style: CustomTextStyles.titleMediumBold)),
                  Container(
                      width: getHorizontalSize(229),
                      margin: getMargin(left: 6, top: 8, right: 5),
                      child: Text("You will miss out on career opportunities your personal assistant is searching for you.",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.titleSmallBluegray400
                              .copyWith(height: 1.57))),
                  Padding(
                      padding: getPadding(top: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: CustomOutlinedButton(
                                    height: 48,
                                    text: "lbl_log_out2".tr,
                                    margin: getMargin(right: 6),
                                    buttonStyle:
                                        CustomButtonStyles.outlinePrimaryTL20,
                                    buttonTextStyle: CustomTextStyles
                                        .titleSmallPrimarySemiBold,
                                    onTap: () {
                                      onTapLogout(context);
                                    })),
                            Expanded(
                                child: CustomElevatedButton(
                                    height: 48,
                                    text: "lbl_cancel".tr,
                                    margin: getMargin(left: 6),
                                    buttonStyle:
                                        CustomButtonStyles.fillPrimaryTL20,
                                    buttonTextStyle:
                                        CustomTextStyles.titleSmallGray5001,
                                    onTap: () {
                                      onTapCancel(context);
                                    }))
                          ]))
                ])));
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCreateAcountScreen.
  onTapLogout(BuildContext context) async {
    var storage = const FlutterSecureStorage();

    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/auth/logout";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false
    ).then((value) async {
      debugPrint(value.toString());

      storage.deleteAll();
      NavigatorService.pushNamedAndRemoveUntil(
        AppRoutes.loginScreen,
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    }).onError((error, stackTrace) {
      print(error);
    });
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
