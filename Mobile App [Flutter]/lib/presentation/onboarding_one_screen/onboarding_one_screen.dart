import '../onboarding_one_screen/widgets/sliderthebestap_item_widget.dart';
import 'bloc/onboarding_one_bloc.dart';
import 'models/onboarding_one_model.dart';
import 'models/sliderthebestap_item_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<OnboardingOneBloc>(
        create: (context) => OnboardingOneBloc(
            OnboardingOneState(onboardingOneModelObj: OnboardingOneModel()))
          ..add(OnboardingOneInitialEvent()),
        child: OnboardingOneScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
        extendBody: true,
        extendBodyBehindAppBar: true,
        // appBar: CustomAppBar(height: getVerticalSize(50), actions: [
        //   AppbarSubtitle1(
        //       text: "lbl_skip".tr,
        //       margin: getMargin(left: 24, top: 13, right: 24, bottom: 13),
        //       onTap: () {
        //         onTapMediumlabelmedi(context);
        //       })
        // ]),
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
                  getPadding(left: 24, top: 29, right: 24, bottom: 29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: getVerticalSize(672),
                        width: getHorizontalSize(327),
                        margin: getMargin(top: 19, bottom: 5),
                        child:
                        Stack(alignment: Alignment.bottomCenter, children: [
                          Semantics(
                            label: "Image of SIA",
                            child: CustomImageView(
                                imagePath: ImageConstant.imgImage, //bot avatar
                                height: getVerticalSize(369),
                                width: getHorizontalSize(306),
                                alignment: Alignment.topCenter),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                  height: getVerticalSize(335),
                                  width: getHorizontalSize(327),
                                  // margin: getMargin(bottom: 5),
                                  child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        BlocBuilder<OnboardingOneBloc,
                                                OnboardingOneState>(
                                            builder: (context, state) {
                                          return CarouselSlider.builder(
                                              options: CarouselOptions(
                                                  height: getVerticalSize(335),
                                                  initialPage: 0,
                                                  autoPlay: true,
                                                  viewportFraction: 1.0,
                                                  enableInfiniteScroll: false,
                                                  scrollDirection: Axis.horizontal,
                                                  onPageChanged: (index, reason) {
                                                    state.sliderIndex = index;
                                                  }),
                                              itemCount: state
                                                      .onboardingOneModelObj
                                                      ?.sliderthebestapItemList
                                                      .length ??
                                                  0,
                                              itemBuilder:
                                                  (context, index, realIndex) {
                                                SliderthebestapItemModel model = state
                                                            .onboardingOneModelObj
                                                            ?.sliderthebestapItemList[
                                                        index] ??
                                                    SliderthebestapItemModel();
                                                return SliderthebestapItemWidget(
                                                    model, onTapLabel: () {
                                                  onTapLabel(context);
                                                });
                                              });
                                        }),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: BlocBuilder<OnboardingOneBloc,
                                                    OnboardingOneState>(
                                                builder: (context, state) {
                                              return Container(
                                                  height: getVerticalSize(10),
                                                  margin: getMargin(bottom: 112),
                                                  child: Semantics(
                                                    excludeSemantics: true,
                                                    child: AnimatedSmoothIndicator(
                                                        activeIndex:
                                                            state.sliderIndex,
                                                        count: state
                                                                .onboardingOneModelObj
                                                                ?.sliderthebestapItemList
                                                                .length ??
                                                            0,
                                                        axisDirection:
                                                            Axis.horizontal,
                                                        effect: ScrollingDotsEffect(
                                                            spacing: 12,
                                                            activeDotColor: theme
                                                                .colorScheme.primary,
                                                            dotColor: theme
                                                                .colorScheme.primary
                                                                .withOpacity(0.41),
                                                            dotHeight:
                                                                getVerticalSize(10),
                                                            dotWidth:
                                                                getHorizontalSize(
                                                                    10))),
                                                  ));
                                            }))
                                      ])))
                        ]),
                      ),
                    ],
                  ))

          ),
        ));
  }

  /// Navigates to the onboardingTwoScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the onboardingTwoScreen.
  onTapLabel(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.onboardingTwoScreen);
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCreateAcountScreen.
  onTapMediumlabelmedi(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signUpCreateAcountScreen,
    );
  }
  onTapTxtMediumlabelmedi(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signUpCreateAcountScreen,
    );
  }
}
