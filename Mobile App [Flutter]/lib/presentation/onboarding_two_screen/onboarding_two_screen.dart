import 'package:flutter/cupertino.dart';

import '../onboarding_two_screen/widgets/sliderbetterfut_item_widget.dart';
import 'bloc/onboarding_two_bloc.dart';
import 'models/onboarding_two_model.dart';
import 'models/sliderbetterfut_item_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<OnboardingTwoBloc>(
        create: (context) => OnboardingTwoBloc(
            OnboardingTwoState(onboardingTwoModelObj: OnboardingTwoModel()))
          ..add(OnboardingTwoInitialEvent()),
        child: OnboardingTwoScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      theme.colorScheme.tertiary,
                      theme.colorScheme.primary,
                    ],
                  )
              ),
              child: Container(
                  width: double.maxFinite,
                  padding:
                      getPadding(left: 24, top: 18, right: 24, bottom: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // GestureDetector(
                        //     onTap: () {
                        //       onTapTxtMediumlabelmedi(context);
                        //     },
                        //     child: Text("lbl_skip".tr,
                        //         style: CustomTextStyles.titleSmallGray5001)),
                        Container(
                            height: getVerticalSize(672),
                            width: getHorizontalSize(327),
                            margin: getMargin(top: 19, bottom: 5),
                            child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Semantics(
                                    label: "Image of Sia",
                                    child: CustomImageView(
                                        imagePath:
                                            ImageConstant.imgImage, // bot Avatar
                                        height: getVerticalSize(369),
                                        width: getHorizontalSize(306),
                                        alignment: Alignment.topCenter),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                          height: getVerticalSize(335),
                                          width: getHorizontalSize(327),
                                          child: Stack(
                                              alignment:
                                                  Alignment.bottomCenter,
                                              children: [
                                                BlocBuilder<OnboardingTwoBloc,
                                                        OnboardingTwoState>(
                                                    builder:
                                                        (context, state) {
                                                  return CarouselSlider
                                                      .builder(
                                                          options:
                                                              CarouselOptions(
                                                                  height:
                                                                      getVerticalSize(
                                                                          335),
                                                                  initialPage:
                                                                      0,
                                                                  autoPlay:
                                                                      true,
                                                                  viewportFraction:
                                                                      1.0,
                                                                  enableInfiniteScroll:
                                                                      false,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  onPageChanged:
                                                                      (index,
                                                                          reason) {
                                                                    state.sliderIndex =
                                                                        index;
                                                                  }),
                                                          itemCount: state
                                                                  .onboardingTwoModelObj
                                                                  ?.sliderbetterfutItemList
                                                                  .length ??
                                                              0,
                                                          itemBuilder:
                                                              (context, index,
                                                                  realIndex) {
                                                            SliderbetterfutItemModel
                                                                model =
                                                                state.onboardingTwoModelObj
                                                                            ?.sliderbetterfutItemList[
                                                                        index] ??
                                                                    SliderbetterfutItemModel();
                                                            return SliderbetterfutItemWidget(
                                                                model,
                                                                onTapLabel:
                                                                    () {
                                                              onTapLabel(
                                                                  context);
                                                            });
                                                          });
                                                }),
                                                Align(
                                                    alignment: Alignment
                                                        .bottomCenter,
                                                    child: BlocBuilder<
                                                            OnboardingTwoBloc,
                                                            OnboardingTwoState>(
                                                        builder:
                                                            (context, state) {
                                                      return Container(
                                                          height:
                                                              getVerticalSize(
                                                                  10),
                                                          margin: getMargin(
                                                              bottom: 112),
                                                          child: Semantics(
                                                            excludeSemantics: true,
                                                            child: AnimatedSmoothIndicator(
                                                                activeIndex: state
                                                                    .sliderIndex,
                                                                count: state
                                                                        .onboardingTwoModelObj
                                                                        ?.sliderbetterfutItemList
                                                                        .length ??
                                                                    0,
                                                                axisDirection: Axis
                                                                    .horizontal,
                                                                effect: ScrollingDotsEffect(
                                                                    spacing: 12,
                                                                    activeDotColor: theme
                                                                        .colorScheme
                                                                        .primary,
                                                                    dotColor: theme
                                                                        .colorScheme
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.41),
                                                                    dotHeight:
                                                                        getVerticalSize(
                                                                            10),
                                                                    dotWidth:
                                                                        getHorizontalSize(10))),
                                                          ));
                                                    }))
                                              ])))
                                ]))
                      ]))),
        ));
  }

  /// Navigates to the onboardingThreeScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the onboardingThreeScreen.
  onTapLabel(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.employmentStatusScreen);
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCreateAcountScreen.
  onTapTxtMediumlabelmedi(BuildContext context) { /// Back button
    NavigatorService.pushNamed(
      AppRoutes.signUpCreateAcountScreen,
    );
  }
}
