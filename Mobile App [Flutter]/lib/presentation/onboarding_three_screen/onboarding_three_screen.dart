import '../onboarding_three_screen/widgets/sliderapplicati_item_widget.dart';
import 'bloc/onboarding_three_bloc.dart';
import 'models/onboarding_three_model.dart';
import 'models/sliderapplicati_item_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingThreeScreen extends StatelessWidget {
  const OnboardingThreeScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<OnboardingThreeBloc>(
        create: (context) => OnboardingThreeBloc(OnboardingThreeState(
            onboardingThreeModelObj: OnboardingThreeModel()))
          ..add(OnboardingThreeInitialEvent()),
        child: OnboardingThreeScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                )),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        getPadding(left: 24, top: 29, right: 24, bottom: 29),
                    child: Container(
                        height: getVerticalSize(699),
                        width: getHorizontalSize(327),
                        margin: getMargin(bottom: 5),
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgImage, //Bot avatar
                              height: getVerticalSize(422),
                              width: getHorizontalSize(313),
                              alignment: Alignment.topCenter),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                  height: getVerticalSize(367),
                                  width: getHorizontalSize(327),
                                  child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        BlocBuilder<OnboardingThreeBloc,
                                                OnboardingThreeState>(
                                            builder: (context, state) {
                                          return CarouselSlider.builder(
                                              options: CarouselOptions(
                                                  height: getVerticalSize(367),
                                                  initialPage: 0,
                                                  autoPlay: true,
                                                  viewportFraction: 1.0,
                                                  enableInfiniteScroll: false,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    state.sliderIndex = index;
                                                  }),
                                              itemCount: state
                                                      .onboardingThreeModelObj
                                                      ?.sliderapplicatiItemList
                                                      .length ??
                                                  0,
                                              itemBuilder:
                                                  (context, index, realIndex) {
                                                SliderapplicatiItemModel model =
                                                    state.onboardingThreeModelObj
                                                                ?.sliderapplicatiItemList[
                                                            index] ??
                                                        SliderapplicatiItemModel();
                                                return SliderapplicatiItemWidget(
                                                    model, onTapLabel: () {
                                                  onTapLabel(context);
                                                });
                                              });
                                        }),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: BlocBuilder<
                                                    OnboardingThreeBloc,
                                                    OnboardingThreeState>(
                                                builder: (context, state) {
                                              return Container(
                                                  height: getVerticalSize(10),
                                                  margin:
                                                      getMargin(bottom: 112),
                                                  child: AnimatedSmoothIndicator(
                                                      activeIndex:
                                                          state.sliderIndex,
                                                      count: state
                                                              .onboardingThreeModelObj
                                                              ?.sliderapplicatiItemList
                                                              .length ??
                                                          0,
                                                      axisDirection:
                                                          Axis.horizontal,
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
                                                              getHorizontalSize(
                                                                  10))));
                                            }))
                                      ])))
                        ]))))));
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCreateAcountScreen.
  onTapLabel(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signUpCreateAcountScreen,
    );
  }
}
