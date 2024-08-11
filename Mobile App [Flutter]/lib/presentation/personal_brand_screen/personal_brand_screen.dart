import 'dart:math';
import 'package:any_link_preview/any_link_preview.dart';
import '../../data/models/HomePage/career_suggestion_resp.dart';
import '../../data/models/HomePage/event_suggestion_resp.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/personal_brand_bloc.dart';
import 'models/personal_brand_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_pin_code_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graphview/GraphView.dart';


class PersonalBrandScreen extends StatelessWidget {
  PersonalBrandScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<PersonalBrandBloc>(
        create: (context) => PersonalBrandBloc(
            PersonalBrandState(personalBrandModelObj: PersonalBrandModel()))
          ..add(PersonalBrandInitialEvent()),
        child: PersonalBrandScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: getHorizontalSize(50),
            leading: Semantics(
              label: "Back to home page",
              child: Center(
                child: AppbarImage(
                    svgPath: ImageConstant.imgGroup162799,
                    margin: getMargin(left: 24, top: 13, bottom: 14),
                    onTap: () {
                      onTapArrowbackone(context);
                    }),
              ),
            ),
            centerTitle: true,
            title: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              child: Center(
                child: AppbarTitle(
                    text: "Personal Branding"
                ),
              ),
            )
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            NavigatorService.pushNamed(AppRoutes.resumeMaker);
                          },
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.42,
                            height: MediaQuery
                                .of(context)
                                .size
                                .width * 0.6,
                            padding: getPadding(
                              all: 16,
                            ),
                            decoration: AppDecoration.fillSecondary.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Resume Builder",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.resume,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42,
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillTertiary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Online Presence",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "(Coming soon)",
                                style: CustomTextStyles
                                    .labelLargeGray5001_1,
                              ),
                              // CustomImageView(
                              //   imagePath: ImageConstant.imgSuperHero,
                              //   height: MediaQuery
                              //       .of(context)
                              //       .size
                              //       .width * 0.45,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42,
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillPrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Soft Skills",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "(Coming soon)",
                                style: CustomTextStyles
                                    .labelLargeGray5001_1,
                              ),
                              // CustomImageView(
                              //   imagePath: ImageConstant.imgSuperHero,
                              //   height: MediaQuery
                              //       .of(context)
                              //       .size
                              //       .width * 0.45,
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42,
                        )
                      ],
                    ),
                  )
                ],
              ),

            ),
          ),
        ));

  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapImgImage(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the jobTypeScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the jobTypeScreen.
  onTapContinue(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.jobTypeScreen,
    );
  }

  onTapArrowbackone(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.homeContainerScreen);
  }

}
