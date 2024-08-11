import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fotisia/data/models/HomePage/careeer_content_link.dart';
import 'package:fotisia/presentation/links_preview_screen/links_preview_screen.dart';
import '../../core/constants/global_keys.dart';
import '../../core/utils/long_wait_animation_provider.dart';
import '../../data/models/HomePage/career_suggestion_resp.dart';
import '../../data/models/HomePage/event_suggestion_resp.dart';
import '../feeds_page/models/get_feeds_resp.dart';
import '../new_career_path_popup_dialog/new_career_path_popup_dialog.dart';
import 'bloc/home_bloc.dart';
import 'models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_circleimage.dart';
import 'package:fotisia/widgets/app_bar/appbar_subtitle.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(HomeState(homeModelObj: HomeModel()))
          ..add(GetSuggestionsEvent())
          ..add(GetUserEvent())
          ..add(GetRoadmapEvent())
          ..add(GetOpportunitiesEvent())
          ..add(GetEvents())
        ,
        child: HomePage()
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocConsumer<HomeBloc, HomeState>(

      listener: (BuildContext context, state) {
        context.read<LongLoadingProvider>().setLoadingMileStone(state.loadingMilestone);
        if(state.isEventsLoaded && state.isOpportunitiesLoaded && state.isRoadmapLoaded && state.isJobsLoaded && state.isNewCareer && state.isSuggestionsLoaded){
          context.read<LongLoadingProvider>().setLoading(false);
        }
      },

      builder: (BuildContext context, state) {
        return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {

          return SafeArea(
            child: Scaffold(
              backgroundColor: appTheme.whiteA70001,
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(
                  leadingWidth: getHorizontalSize(74),
                  height: getVerticalSize(70),
                  leading: Semantics(
                    label: "Image: An image of Sia, Your personal career assistant.",
                    child: AppbarCircleimage(
                      imagePath: ImageConstant.imgAvatar32x32,
                      margin: getMargin(
                        left: 24,
                        top: 5,
                        bottom: 5,
                      ),
                    ),
                  ),
                  title: SizedBox(
                    height: 60,
                    width: mediaQueryData.size.width * 0.75,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        autoPlayInterval: const Duration(seconds: 6),
                        enlargeCenterPage: true,
                        scrollDirection: Axis.vertical,
                        autoPlay: true,
                      ),
                      items: [
                        Semantics(
                          label: "Text: Hi ${state.userData?['firstName'] ?? ""}, I'm Sia.",
                          child: Padding(
                            padding: getPadding(
                              left: 30,
                            ),
                            child: AppbarSubtitle(
                              text: "Hi ${state.userData?['firstName'] ?? ""}, I'm Sia.",
                            ),
                          ),
                        ),
                        Semantics(
                          label: "Text: Your personal career assistant.",
                          child: Padding(
                            padding: getPadding(
                              left: 30,
                            ),
                            child: AppbarSubtitle(
                              text: "Your personal career assistant.",
                            ),
                          ),
                        ),
                        Semantics(
                          label: "Text: Welcome to your dashboard.",
                          child: Padding(
                            padding: getPadding(
                              left: 30,
                            ),
                            child: AppbarSubtitle(
                              text: "Welcome to your dashboard.",
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 10,
                          ),
                          child: Semantics(
                            label: "Text: See my findings below.",
                            child: AppbarSubtitle(
                              text: "See my findings below.",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              body: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: mediaQueryData.size.height * 0.02),
                      // Section 1 begins
                      state.getCareerRoadmapResp != null
                          ? Padding(
                        padding: getPadding(
                          left: 24,
                          top: 0,
                        ),
                        child: Text(
                          "Your Roadmap",
                          style: CustomTextStyles.titleMedium18,
                        ),
                      )
                          : Container(),
                      state.isRoadmapLoaded  ? Container(
                        child: state.getCareerRoadmapResp != null
                            ? Semantics(
                              label: (state.getCareerRoadmapResp!.careerRoadmap as CareerToChooseFrom).career,
                              child: GestureDetector(
                                                        onTap: () {
                              NavigatorService.pushNamed(
                                  AppRoutes.careerRoadmap,
                                  arguments: {
                                    'career': state.getCareerRoadmapResp!
                                        .careerRoadmap
                                    as CareerToChooseFrom
                                  });
                                                        },
                                                        child: Card(
                              elevation: 4,
                              shadowColor: Colors.black,
                              margin: getMargin(right: 25, left: 25, top: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyle.roundedBorder16,
                              ),
                              child: Container(
                                height: mediaQueryData.size.height * 0.25,
                                decoration: AppDecoration
                                    .fillWhiteA
                                    .copyWith(
                                    borderRadius: BorderRadiusStyle.roundedBorder16,
                                    image: DecorationImage(
                                      image: AssetImage(ImageConstant.cardTwoBG),
                                      fit: BoxFit.cover,
                                    )
                                ),
                                // height: MediaQuery.of(context).size.height * 0.15,
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Padding(
                                          padding: getPadding(
                                            left: 12,
                                            top: 4,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: mediaQueryData.size.width * 0.7,
                                                child: Text(
                                                  "${state.getCareerRoadmapResp?.careerRoadmap?.career} Roadmap"
                                                      .toUpperCase(),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: theme
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                    color: theme.colorScheme
                                                        .primary,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Container(
                                                  width:
                                                  getHorizontalSize(
                                                      260),
                                                  margin: getMargin(
                                                    top: 8,
                                                  ),
                                                  child: Text(
                                                    "${state.getCareerRoadmapResp?.careerRoadmap?.description}",
                                                    maxLines: 4,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: theme.textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                      color: theme
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(
                                                          0.8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  top: 9,
                                                ),
                                                child: Text(
                                                  "Possible Pay Range: ${state.getCareerRoadmapResp?.careerRoadmap?.salary}",
                                                  style: theme.textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                    color: theme
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),),
                              ),
                            )
                            : Container(),
                      )
                          : Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10.0),
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.87,
                            decoration: AppDecoration.fillTertiary.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder16,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: LoadingAnimationWidget.beat(
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Section 2 begins
                      if(state.isSuggestionsLoaded && state.getCareerSuggestionResp != null && state.getCareerSuggestionResp!.careersToChooseFrom!.isNotEmpty) Padding(
                        padding: getPadding(
                          left: 24,
                          top: 20,
                          right: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Alternative Career Path",
                              style: CustomTextStyles.titleMedium18,
                            ),

                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        content: NewCareerPathPopupDialog.builder(context),
                                        backgroundColor: Colors.transparent,
                                        contentPadding: EdgeInsets.zero,
                                        insetPadding: const EdgeInsets.only(left: 0),
                                      )).then((value) {
                                      context.read<HomeBloc>().add(GetSuggestionsEvent());
                                  });
                                },
                              icon: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  semanticLabel: "Add a career path, Enter a career your are interested in and I will create a career roadmap for you.",
                              ),
                            ),
                          ],
                        ),
                      ),

                      if(state.isSuggestionsLoaded && state.getCareerSuggestionResp != null && state.getCareerSuggestionResp!.careersToChooseFrom!.isNotEmpty) Container(
                          margin: getMargin(top: 0, right: 22, left: 24),
                          child: Text(
                              "I have carefully curated a collection of highly valuable alternative career paths related to your field.",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyles.titleSmallBluegray400_1
                                  .copyWith(height: 1.57))),

                      if(state.isSuggestionsLoaded && state.getCareerSuggestionResp != null && state.getCareerSuggestionResp!.careersToChooseFrom!.isNotEmpty) Align(
                          alignment: Alignment.centerRight,
                          child:
                          // state.isNewCareer ?
                          Padding(
                            // Suggested career widget
                            padding: getPadding(top: 10, left: 22),
                            child: state.isSuggestionsLoaded ? SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.22,
                                  width: MediaQuery.of(context).size.width,
                                  child: CarouselSlider(
                                  options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height * 0.22,
                                    initialPage: 1,
                                    enableInfiniteScroll: true,
                                    enlargeCenterPage: true,
                                    padEnds: false,
                                    enlargeFactor: 0.3,
                                    clipBehavior: Clip.none,
                                  ),
                                  items: state.getCareerSuggestionResp
                                      ?.careersToChooseFrom !=
                                      null
                                      ? state.getCareerSuggestionResp
                                      ?.careersToChooseFrom
                                      ?.map((career) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Semantics(
                                          label: "Text: Alternative career roadmap: ${career.career}",
                                          child: GestureDetector(
                                            onTap: () {
                                              NavigatorService.pushNamed(
                                                  AppRoutes.careerRoadmap,
                                                  arguments: {
                                                    'career': career
                                                  });
                                            },
                                            child: Container(
                                              padding: getPadding(
                                                all: 16,
                                              ),
                                              decoration: AppDecoration
                                                  .fillTertiary
                                                  .copyWith(
                                                  borderRadius: BorderRadiusStyle.roundedBorder16,
                                                  image: DecorationImage(
                                                    image: AssetImage(ImageConstant.cardOneBG),
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                              child: Wrap(
                                                children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                          getHorizontalSize(
                                                              230),
                                                          child: Text(
                                                            career.career
                                                                .toUpperCase(),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: CustomTextStyles
                                                                .titleSmallGray5001Bold,
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                          getHorizontalSize(
                                                              230),
                                                          margin: getMargin(
                                                            top: 8,
                                                          ),
                                                          child: Text(
                                                            career
                                                                .description,
                                                            maxLines: 4,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: CustomTextStyles
                                                                .labelLargeGray5001_1,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: getMargin(bottom: 10),
                                                          width:
                                                          getHorizontalSize(
                                                              230),
                                                          child: Padding(
                                                            padding:
                                                            getPadding(
                                                              top: 6,
                                                            ),
                                                            child: Text(
                                                              career.salary,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              maxLines: 1,
                                                              style: CustomTextStyles
                                                                  .labelLargeGray5001_1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList()
                                      : ["Not able to load career data"].map((i) {
                                    return Builder(
                                        builder: (BuildContext context) {
                                          return Center(
                                            child: Text(
                                              i,
                                            ),
                                          );
                                        });
                                  }).toList())
                                ) 
                                : Center(
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 10, 0, 10.0),
                                child: Container(
                                  height: 120,
                                  child: LoadingAnimationWidget
                                      .staggeredDotsWave(
                                    color: theme.colorScheme.secondary,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          )
                        // :
                        // Padding( //suggested subjects widget
                        //   padding: getPadding(top: 10, left: 25),
                        //   child: state.isSuggestionsLoaded ? CarouselSlider(
                        //       options: CarouselOptions(
                        //         height: MediaQuery.of(context).size.height * 0.2,
                        //         initialPage: 0,
                        //         enableInfiniteScroll: true,
                        //         enlargeCenterPage: true,
                        //         padEnds: false,
                        //         enlargeFactor: 0.3,
                        //         clipBehavior: Clip.none,
                        //       ),
                        //       items: state.getSubjectSuggstionResp?.suggestedSubjects != null ? state.getSubjectSuggstionResp?.suggestedSubjects?.map((subject) {
                        //         return Builder(
                        //           builder: (BuildContext context) {
                        //             return GestureDetector(
                        //               onTap: () {
                        //                 Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                     builder: (context) => CareerSubjectsScreen(subject: subject),
                        //                   ),
                        //                 );
                        //               },
                        //               child: Container(
                        //                 // margin: getMargin(
                        //                 //   right: 16,
                        //                 // ),
                        //                 padding: getPadding(
                        //                   all: 16,
                        //                 ),
                        //                 decoration: AppDecoration.fillSecondary.copyWith(
                        //                   borderRadius: BorderRadiusStyle.roundedBorder16,
                        //                 ),
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.center,
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: [
                        //                     Padding(
                        //                       padding: getPadding(
                        //                         left: 12,
                        //                         top: 4,
                        //                       ),
                        //                       child: Column(
                        //                         crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                         mainAxisAlignment: MainAxisAlignment
                        //                             .start,
                        //                         children: [
                        //                           Container(
                        //                             width: getHorizontalSize(230),
                        //                             child: Text(
                        //                               subject.subject.toString().capitalizeFirstLetter(),
                        //                               style: CustomTextStyles
                        //                                   .titleSmallGray5001Bold,
                        //                               overflow: TextOverflow.ellipsis,
                        //                               maxLines: 1,
                        //                             ),
                        //                           ),
                        //                           Container(
                        //                             width: getHorizontalSize(230),
                        //                             margin: getMargin(
                        //                               top: 8,
                        //                             ),
                        //                             child: Text(
                        //                               subject.description.toString(),
                        //                               maxLines: 4,
                        //                               overflow: TextOverflow.ellipsis,
                        //                               style: CustomTextStyles
                        //                                   .labelLargeGray5001_1,
                        //                             ),
                        //                           ),
                        //                           SizedBox(
                        //                             width: getHorizontalSize(230),
                        //                             child: Padding(
                        //                               padding: getPadding(
                        //                                 top: 6,
                        //                               ),
                        //                               child: Text(
                        //                                 "Level: ${removeNumbersSuffix(subject.level.toString()).capitalizeFirstLetter()}",
                        //                                 overflow: TextOverflow.ellipsis,
                        //                                 maxLines: 1,
                        //                                 style: CustomTextStyles
                        //                                     .labelLargeGray5001_1,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         );
                        //       }).toList() : ["Not able to load suggestions data"].map((i) {
                        //         return Builder(
                        //             builder: (BuildContext context) {
                        //               return  Center(
                        //                 child: Text(
                        //                   i,
                        //                 ),
                        //               );
                        //             });}).toList()
                        //   ) : Center(
                        //     child: Padding(
                        //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10.0),
                        //       child: Container(
                        //         height: 120,
                        //         child: LoadingAnimationWidget.staggeredDotsWave(
                        //           color: theme.colorScheme.secondary,
                        //           size: 60,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),

                      // Section 3 begins
                      Container(
                        margin: getMargin(left: 24, top: 20, right: 24, bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                height: getVerticalSize(250),
                                decoration: AppDecoration.fillPrimary.copyWith(
                                  borderRadius: BorderRadiusStyle.roundedBorder16,
                                  color: const Color(0XFFFFA45D),

                                ),
                                child: state.posts != null && state.posts!.isNotEmpty ? CarouselSlider(
                                  options: CarouselOptions(
                                    height: getVerticalSize(250),
                                    autoPlayInterval: const Duration(seconds: 10),
                                    viewportFraction: 1,
                                    enableInfiniteScroll: true,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                  ),
                                  items: _buildCarouselItems(
                                      context, state.posts ?? []
                                  ),
                                ) : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LoadingAnimationWidget.beat(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Finding articles for you...", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.4)))
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  NavigatorService.pushNamed(
                                      AppRoutes.personalBranding);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  height: getVerticalSize(250),
                                  padding: getPadding(
                                    all: 16,
                                  ),
                                  decoration: AppDecoration.fillSecondary.copyWith(
                                    borderRadius: BorderRadiusStyle.roundedBorder16,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Personal Brand",
                                        style:
                                        CustomTextStyles.labelLargeGray5001_1,
                                      ),
                                      Semantics(
                                        label: "Image: Personal branding icon: Image of a super hero",
                                        child: CustomImageView(
                                          imagePath: ImageConstant.imgSuperHero,
                                          height: getVerticalSize(200)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),

                      //   Section 3 begins
                      if(state.isJobsLoaded && state.jobPostings != null && state.jobPostings!.isNotEmpty) Padding(
                        padding: getPadding(
                          left: 24,
                          top: 20,
                        ),
                        child: Text(
                          "Your jobs board",
                          style: CustomTextStyles.titleMedium18,
                        ),
                      ),
                      if(state.isJobsLoaded && state.jobPostings != null && state.jobPostings!.isNotEmpty) Align(
                        child: Padding(
                          padding: getPadding(
                            top: 10,
                            left: 22,
                            bottom: 10,
                          ),
                          child: Container(
                            child: state.isJobsLoaded! ? Container(
                              child: state.jobPostings != null ? CarouselSlider(
                                  options: CarouselOptions(
                                    height:
                                    MediaQuery.of(context).size.height * 0.25,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    enlargeCenterPage: true,
                                    // padEnds: false,
                                    enlargeFactor: 0.3,
                                    clipBehavior: Clip.none,
                                  ),
                                  items: state.jobPostings?.map((job) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Semantics(
                                          label: job.title,
                                          child: GestureDetector(
                                            onTap: () {
                                              NavigatorService.pushNamed(AppRoutes.jobAdScreen, arguments: {"jobUrl": job.link});
                                            },
                                            child: Card(
                                              elevation: 4,
                                              // color: const Color(0XFFf6f7ff),
                                              shadowColor: Colors.black,
                                              margin: getMargin(right: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadiusStyle
                                                    .roundedBorder16,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    16.0),
                                                child: Center(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.50,
                                                          child: Text(
                                                            job.title
                                                                .toString()
                                                                .capitalizeFirstLetter(),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            maxLines: 3,
                                                            style: theme
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                            ),
                                                          ),
                                                        ),
                                                        Opacity(
                                                          opacity: 0.64,
                                                          child: Container(
                                                            width:
                                                            getHorizontalSize(
                                                                181),
                                                            margin:
                                                            getMargin(
                                                              top: 8,
                                                            ),
                                                            child: Text(
                                                              job.snippet.toString(),
                                                              maxLines: 4,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              style: theme
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary
                                                                    .withOpacity(0.8),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 5.0),
                                                          child: Text(job.displayLink.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList()) : Text("Could not get jobs..."),
                            ) : Center(
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 10, 0, 10.0),
                                child: Container(
                                  height: 120,
                                  child: LoadingAnimationWidget
                                      .staggeredDotsWave(
                                    color: theme.colorScheme.secondary,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //  Section 4 begins
                      if(state.isOpportunitiesLoaded && state.getSuggestedOpportunitiesResp != null && state.getSuggestedOpportunitiesResp!.opportunities!.isNotEmpty) Padding(
                        padding: getPadding(
                          left: 24,
                          top: 20,
                        ),
                        child: Text(
                          "Opportunities near you",
                          style: CustomTextStyles.titleMedium18,
                        ),
                      ),
                      if(state.isOpportunitiesLoaded && state.getSuggestedOpportunitiesResp != null && state.getSuggestedOpportunitiesResp!.opportunities!.isNotEmpty) Align(
                        child: Padding(
                          padding: getPadding(
                            top: 10,
                            left: 22,
                            bottom: 10,
                          ),
                          child: Container(
                            child: state.isOpportunitiesLoaded
                                ? CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                  MediaQuery.of(context).size.height * 0.2,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  // padEnds: false,
                                  enlargeFactor: 0.3,
                                  clipBehavior: Clip.none,
                                ),
                                items: state.getSuggestedOpportunitiesResp
                                    ?.opportunities !=
                                    null
                                    ? state.getSuggestedOpportunitiesResp
                                    ?.opportunities
                                    ?.map((opportunity) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Semantics(
                                        label: opportunity.opportunity,
                                        child: GestureDetector(
                                          onTap: () {
                                            NavigatorService.pushNamed(AppRoutes.linkPreviewScreen, arguments: {
                                              "links": opportunity
                                                  .links
                                              as List<Link>,
                                              "title": opportunity
                                                  .opportunity
                                                  .toString()
                                            });
                                          },
                                          child: Card(
                                            elevation: 3,
                                            // color: const Color(0XFFf6f7ff),
                                            shadowColor: Colors.black,
                                            margin: getMargin(right: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadiusStyle
                                                  .roundedBorder16,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                  top: 16.0,
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.50,
                                                            child: Text(
                                                              opportunity
                                                                  .opportunity
                                                                  .toString()
                                                                  .capitalizeFirstLetter(),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              maxLines: 2,
                                                              style: theme
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                            ),
                                                          ),
                                                          Opacity(
                                                            opacity: 0.64,
                                                            child: Container(
                                                              width:
                                                              getHorizontalSize(
                                                                  220),
                                                              margin:
                                                              getMargin(
                                                                top: 8,
                                                              ),
                                                              child: Text(
                                                                opportunity
                                                                    .description
                                                                    .toString(),
                                                                maxLines: 4,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: theme
                                                                    .textTheme
                                                                    .labelLarge!
                                                                    .copyWith(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .primary
                                                                      .withOpacity(
                                                                      0.8),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList()
                                    : ["Not able to load opportunity data"]
                                    .map((i) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: Text(
                                            i,
                                          ),
                                        );
                                      });
                                }).toList())
                                : Center(
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 10, 0, 10.0),
                                child: Container(
                                  height: 120,
                                  child: LoadingAnimationWidget
                                      .staggeredDotsWave(
                                    color: theme.colorScheme.secondary,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      if(state.isEventsLoaded && state.getSuggestedEventsResp != null && state.getSuggestedEventsResp!.events!.isNotEmpty) Padding(
                        padding: getPadding(
                          left: 24,
                          top: 20,
                        ),
                        child: Text(
                          "Events near you",
                          style: CustomTextStyles.titleMedium18,
                        ),
                      ),
                      if(state.isEventsLoaded && state.getSuggestedEventsResp != null && state.getSuggestedEventsResp!.events!.isNotEmpty) Align(
                        child: Padding(
                          padding: getPadding(
                            top: 10,
                            left: 22,
                            bottom: 10,
                          ),
                          child: Container(
                            child: state.isEventsLoaded
                                ? CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                  MediaQuery.of(context).size.height * 0.2,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  // padEnds: false,
                                  enlargeFactor: 0.3,
                                  clipBehavior: Clip.none,
                                ),
                                items: state.getSuggestedEventsResp?.events !=
                                    null
                                    ? state.getSuggestedEventsResp?.events
                                    ?.map((event) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Semantics(
                                        label: event.eventName,
                                        child: GestureDetector(
                                          onTap: () {
                                            NavigatorService.pushNamed(AppRoutes.linkPreviewScreen, arguments: {
                                              "links": event.links
                                              as List<Link>,
                                              "title": event
                                                  .eventName
                                                  .toString()
                                            });
                                          },
                                          child: Card(
                                            elevation: 4,
                                            // color: const Color(0XFFf6f7ff),
                                            shadowColor: Colors.black,
                                            margin: getMargin(right: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadiusStyle
                                                  .roundedBorder16,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    16.0),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.50,
                                                            child: Text(
                                                              event.eventName
                                                                  .toString()
                                                                  .capitalizeFirstLetter(),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              maxLines: 2,
                                                              style: theme
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                            ),
                                                          ),
                                                          Opacity(
                                                            opacity: 0.64,
                                                            child: Container(
                                                              width:
                                                              getHorizontalSize(
                                                                  220),
                                                              margin:
                                                              getMargin(
                                                                top: 8,
                                                              ),
                                                              child: Text(
                                                                event
                                                                    .description
                                                                    .toString(),
                                                                maxLines: 3,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: theme
                                                                    .textTheme
                                                                    .labelLarge!
                                                                    .copyWith(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .primary
                                                                      .withOpacity(
                                                                      0.8),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList()
                                    : ["Not able to load opportunity data"]
                                    .map((i) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: Text(
                                            i,
                                          ),
                                        );
                                      });
                                }).toList())
                                : Center(
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 10, 0, 10.0),
                                child: Container(
                                  height: 120,
                                  child: LoadingAnimationWidget
                                      .staggeredDotsWave(
                                    color: theme.colorScheme.secondary,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  }

  void checkForData(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "userData");

    context.read<HomeBloc>().add(ReloadHomeEvent());
  }

  List<Widget> _buildCarouselItems(BuildContext context, List<Post> posts) {
    List<Widget> carouselItems = [];

    for (int i = 0; i < (posts.length > 7 ? 7 : posts.length); i++) {
      if(posts[i].media?[0] != null){
        carouselItems.add(
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Semantics(
                  label: "Article: ${posts[i].heading}",
                  child: GestureDetector(
                    onTap: () {
                      // Handle "View More" action
                      Navigator.pushNamed(
                          GlobalKeys.navigatorKey.currentContext!, AppRoutes.feedsPage
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black.withOpacity(0.8),
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              posts[i].heading != null && posts[i].heading!.isNotEmpty ? Text(
                                posts[i].heading ?? "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white, height: 1.2),
                              ) : Container(),
                              Text(
                                posts[i].text ?? "",
                                style: const TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Semantics(
                                  label: "Article Image: ${posts[i].heading}",
                                  child: CustomImageView(
                                    url: posts[i].media?[0],
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    fit: BoxFit.cover, // Ensure the image covers the entire area
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        );
      }
    }

    if (posts.length > 5) {
        carouselItems.add(GestureDetector(
          onTap: () {
            // Handle "View More" action
            Navigator.pushNamed(
                GlobalKeys.navigatorKey.currentContext!, AppRoutes.feedsPage
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black.withOpacity(0.5),
            ),
            child: const Center(
              child:  Text(
                "More >>>",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
        )
      );
    }

    return carouselItems;
  }


