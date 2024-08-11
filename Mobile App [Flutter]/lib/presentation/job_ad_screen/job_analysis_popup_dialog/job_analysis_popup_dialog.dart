import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/apiClient/api_client.dart';

import 'bloc/job_analysis_popup_bloc.dart';
import 'models/job_analysis_popup_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class JobAnalysisPopupDialog extends StatefulWidget {
  JobAnalysisPopupDialog({Key? key, required this.explanation}) : super(key: key);
  String? explanation;

  Widget builder(BuildContext context) {
    print(explanation);

    return BlocProvider<JobAnalysisPopupBloc>(
        create: (context) => JobAnalysisPopupBloc(
            JobAnalysisPopupState())
          ..add(LogoutPopupInitialEvent()),
        child: JobAnalysisPopupDialog(explanation: explanation,));
  }

  @override
  State<JobAnalysisPopupDialog> createState() => _JobAnalysisPopupDialogState();
}

class _JobAnalysisPopupDialogState extends State<JobAnalysisPopupDialog> {
  final _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    print(widget.explanation);

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
                  Text(widget.explanation ?? ""),

                  Padding(
                      padding: getPadding(top: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: CustomOutlinedButton(
                                    height: getVerticalSize(46),
                                    text: "Still Apply",
                                    margin: getMargin(right: 6),
                                    buttonStyle:
                                        CustomButtonStyles.outlinePrimaryTL20,
                                    buttonTextStyle: CustomTextStyles
                                        .titleSmallPrimarySemiBold,
                                    onTap: () {
                                      // onTapLogout(context);
                                    })),

                            Expanded(
                                child: CustomElevatedButton(
                                    height: getVerticalSize(40),
                                    text: "Close",
                                    margin: getMargin(left: 6),
                                    buttonStyle:
                                    CustomButtonStyles.fillPrimaryTL20,
                                    buttonTextStyle:
                                    CustomTextStyles.titleSmallGray5001,
                                    onTap: () {
                                      onTapCancel(context);
                                    }))
                          ]))
                ])
        ));
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
