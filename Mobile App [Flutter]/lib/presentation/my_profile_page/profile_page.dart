import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'bloc/profile_bloc.dart';
import 'models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image_1.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
        create: (context) =>
            ProfileBloc(ProfileState(profileModelObj: ProfileModel()))
              ..add(ProfileInitialEvent())
              ..add(GetUserResumeDataEvent()),
        child: const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return  Scaffold(
        backgroundColor: appTheme.whiteA70001,
            appBar: CustomAppBar(
                leadingWidth: getHorizontalSize(50),
                height: getVerticalSize(70),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_profile".tr,
                    margin: EdgeInsets.only(left: getHorizontalSize(50)),
                ),
                actions: [
                  Semantics(
                    label: "button: Edit your profile",
                    child: AppbarImage1(
                        svgPath: ImageConstant.imgGroup162903,
                        margin:
                            getMargin(left: 3, top: 22, right: 3, bottom: 22),
                        onTap: () {
                          onTapImage(context);
                        }),
                  )
            ]
        ),
        body: SafeArea(
          child: SizedBox(
              width: mediaQueryData.size.width,
              child: SingleChildScrollView(
                  padding: getPadding(top: 30),
                  child: Padding(
                      padding: getPadding(bottom: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: getVerticalSize(225),
                                width: getHorizontalSize(327),
                                child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Semantics(
                                        label: 'Image: users cover photo',
                                        child: CustomImageView(
                                            imagePath: ImageConstant.imgBg,
                                            height: getVerticalSize(120),
                                            width: getHorizontalSize(327),
                                            radius: BorderRadius.circular(
                                                getHorizontalSize(8)),
                                            alignment: Alignment.topCenter),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 87, right: 87),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Semantics(
                                                      label: "Image: User's profile picture",
                                                      child: CustomImageView(
                                                          url: state.picturePath != null && state.picturePath!.isNotEmpty && state.picturePath != "null" ? state.picturePath : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                                          height: getSize(89),
                                                          width: getSize(89),
                                                          radius: BorderRadius.circular(getHorizontalSize(44))
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: getPadding(
                                                            top: 9),
                                                        child: Text(
                                                            "${state.firstName ?? "..."} ${state.lastName ?? ""}",
                                                            style: CustomTextStyles
                                                                .titleMediumErrorContainer)),

                                                    Padding(
                                                        padding: getPadding(
                                                            top: 9),
                                                        child: Text(
                                                            (state.careerTitle != null && state.careerTitle!.isNotEmpty) ? "(${state.careerTitle})" : "",
                                                            style: TextStyle(color: Colors.black, ),
                                                            textAlign: TextAlign.center
                                                        )
                                                    ),
                                                    // BlocSelector<
                                                    //         ProfileBloc,
                                                    //         ProfileState,
                                                    //         bool?>(
                                                    //     selector: (state) =>
                                                    //         state.opentowork,
                                                    //     builder: (context,
                                                    //         opentowork) {
                                                    //       return CustomCheckboxButton(
                                                    //           text:
                                                    //               "lbl_open_to_work"
                                                    //                   .tr,
                                                    //           value:
                                                    //               opentowork,
                                                    //           margin:
                                                    //               getMargin(
                                                    //                   top: 5),
                                                    //           textStyle:
                                                    //               CustomTextStyles
                                                    //                   .titleSmallPoppinsBluegray300,
                                                    //           onChange:
                                                    //               (value) {
                                                    //             context
                                                    //                 .read<
                                                    //                     ProfileBloc>()
                                                    //                 .add(ChangeCheckBoxEvent(
                                                    //                     value:
                                                    //                         value));
                                                    //           });
                                                    //     })
                                                  ])))
                                    ])),
                            // Container(
                            //     width: getHorizontalSize(272),
                            //     margin:
                            //         getMargin(left: 52, top: 15, right: 50),
                            //     child: Text("Earnings: 0\$",
                            //         maxLines: 2,
                            //         overflow: TextOverflow.ellipsis,
                            //         textAlign: TextAlign.center,
                            //         style: theme.textTheme.bodyMedium!
                            //             .copyWith(height: 1.57))),
                            Padding(
                                padding: getPadding(top: 24),
                                child: Divider(color: appTheme.indigo50)
                            ),
                            state.fetchingCareerDetailsDone! ? Container(
                                margin:
                                    getMargin(left: 24, top: 22, right: 24),
                                padding: getPadding(
                                    left: 16, top: 14, right: 16, bottom: 14),
                                decoration: AppDecoration.outlineIndigo
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.circleBorder12),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                                padding: getPadding(
                                                    top: 2, bottom: 1),
                                                child: Text("lbl_about_me".tr,
                                                    style: CustomTextStyles
                                                        .titleMediumInter)),
                                          ]),
                                      Container(
                                          width: getHorizontalSize(272),
                                          margin:
                                              getMargin(top: 14, right: 22),
                                          child: Text(
                                              state.aboutMe ?? "Could not retrieve an about statement",
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTextStyles
                                                  .titleSmallBluegray400_1
                                                  .copyWith(height: 1.57)))
                                    ])) : Container(
                                      margin:
                                      getMargin(left: 24, top: 22, right: 24),
                                      padding: getPadding(
                                          left: 16, top: 14, right: 16, bottom: 14),
                                      decoration: AppDecoration.outlineIndigo
                                          .copyWith(
                                          borderRadius:
                                          BorderRadiusStyle.circleBorder12),
                                      child: LoadingAnimationWidget.inkDrop(
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                    ),
                            Container(
                                margin:
                                getMargin(left: 24, top: 22, right: 24),
                                padding: getPadding(
                                    left: 16, top: 14, right: 16, bottom: 14),
                                decoration: AppDecoration.outlineIndigo
                                    .copyWith(
                                    borderRadius:
                                    BorderRadiusStyle.circleBorder12),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                                padding: getPadding(
                                                    top: 2, bottom: 1),
                                                child: Text("Contact",
                                                    style: CustomTextStyles
                                                        .titleMediumInter)),
                                          ]),
                                      Container(
                                          width: getHorizontalSize(272),
                                          margin:
                                          getMargin(top: 14, right: 22),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Email: ${state.email}",
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray400_1
                                                      .copyWith(height: 1.57)
                                              ),
                                              Text(
                                                  "Phone Number: ${state.phone}",
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray400_1
                                                      .copyWith(height: 1.57)
                                              ),
                                              Text(
                                                  "Address: ${state.location}",
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray400_1
                                                      .copyWith(height: 1.57)
                                              ),
                                            ],
                                          ))
                                    ])),

                            if(state.fetchingCareerDetailsDone! && state.skills!.isNotEmpty) Container(
                                margin:
                                    getMargin(left: 23, top: 24, right: 23),
                                padding: getPadding(
                                    left: 9, top: 16, right: 9, bottom: 16),
                                decoration: AppDecoration.outlineIndigo
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.circleBorder12),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              getPadding(left: 7, right: 7),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                    padding: getPadding(
                                                        top: 1, bottom: 2),
                                                    child: Text(
                                                        "lbl_skills".tr,
                                                        style: CustomTextStyles
                                                            .titleMediumInter)),
                                              ])
                                      ),
                                      state.skills!.isNotEmpty ? Padding(
                                          padding:
                                              getPadding(top: 12, bottom: 17),
                                          child: BlocSelector<
                                                  ProfileBloc,
                                                  ProfileState,
                                                  List<String>?>(
                                              selector: (state) =>
                                                  state.skills,
                                              builder:
                                                  (context, skills) {
                                                return Wrap(
                                                    runSpacing: getVerticalSize(12),
                                                    spacing: getHorizontalSize(12),
                                                    children: List<Widget>.generate(
                                                        skills?.length ?? 0, (index) {
                                                      String skill = skills?[index] ?? "";
                                                      return RawChip(
                                                        padding: getPadding(
                                                          left: 16,
                                                          top: 14,
                                                          right: 16,
                                                          bottom: 14,
                                                        ),
                                                        showCheckmark: false,
                                                        labelPadding: EdgeInsets.zero,
                                                        label: Text(
                                                          skill,
                                                          style: TextStyle(
                                                            color: theme.colorScheme.primary,
                                                            fontSize: getFontSize(
                                                              12,
                                                            ),
                                                            fontFamily: 'Plus Jakarta Sans',
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                                                        selectedColor: Colors.transparent,
                                                      );
                                                    }));
                                              })) : const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Add skills",
                                                    ),
                                                  ),
                                                ),
                                    ])),
                            if(state.fetchingCareerDetailsDone! && state.experiences != null && state.experiences!.isNotEmpty) Container(
                                margin:
                                    getMargin(left: 24, top: 24, right: 24),
                                padding: getPadding(
                                    left: 16, top: 15, right: 16, bottom: 15),
                                decoration: AppDecoration.outlineIndigo
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.circleBorder12),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                                padding: getPadding(top: 2),
                                                child: Text(
                                                    "lbl_experience".tr,
                                                    style: CustomTextStyles
                                                        .titleMediumBold)),
                                          ]),
                                      state.experiences != null && state.experiences!.isNotEmpty ? Column(
                                          children: state.experiences!.map((experience) {
                                            return Builder(
                                              builder: (BuildContext context3) {
                                                return Padding(
                                                    padding:
                                                    getPadding(top: 24, right: 0),
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                              child: Padding(
                                                                  padding: getPadding(
                                                                      left: 12, top: 5),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                            experience.position.toString(),
                                                                            style: CustomTextStyles
                                                                                .titleSmallPrimarySemiBold),
                                                                        Padding(
                                                                            padding:
                                                                            getPadding(
                                                                                top: 6),
                                                                            child: Padding(
                                                                                padding: getPadding(
                                                                                    top:
                                                                                    1),
                                                                                child: Text(
                                                                                    experience.company.toString(),
                                                                                    style: theme
                                                                                        .textTheme
                                                                                        .labelLarge))
                                                                        ),
                                                                        Padding(
                                                                            padding:
                                                                            getPadding(
                                                                                top: 6),
                                                                            child: Text(
                                                                                "${experience.startDate.toString()} - ${experience.currentlyWorkHere == true ? "Present" : experience.endDate.toString()}",
                                                                                style: theme
                                                                                    .textTheme
                                                                                    .labelLarge)
                                                                        )
                                                                      ]))
                                                          ),

                                                        ]
                                                    )
                                                );
                                              },
                                            );
                                          }).toList()
                                      ) : const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Add your experiences",
                                          ),
                                        ),
                                      )
                                    ])),
                            if(state.fetchingCareerDetailsDone! && state.educations != null && state.educations!.isNotEmpty) Container(
                                margin:
                                    getMargin(left: 24, top: 24, right: 24),
                                padding: getPadding(all: 16),
                                decoration: AppDecoration.outlineBluegray50
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.circleBorder12),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                                padding: getPadding(top: 2),
                                                child: Text(
                                                    "lbl_education".tr,
                                                    style: CustomTextStyles
                                                        .titleMediumBold_1)),
                                          ]),
                                      state.educations != null && state.educations!.isNotEmpty ? Column(
                                        children: state.educations!.map((education) {
                                          return Builder(
                                            builder: (BuildContext context1) {
                                              return Padding(
                                                  padding:
                                                  getPadding(top: 24, right: 0),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                            child: Padding(
                                                                padding: getPadding(
                                                                    left: 12, top: 5),
                                                                child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                          education.school.toString(),
                                                                          style: CustomTextStyles
                                                                              .titleSmallPrimarySemiBold),
                                                                      Padding(
                                                                          padding:
                                                                          getPadding(
                                                                              top: 6),
                                                                          child: Padding(
                                                                              padding: getPadding(
                                                                                  top:
                                                                                  1),
                                                                              child: Text(
                                                                                  "${education.level!.toString()}. ${education.discipline.toString()}",
                                                                                  style: theme
                                                                                      .textTheme
                                                                                      .labelLarge))
                                                                      ),
                                                                      Padding(
                                                                          padding:
                                                                          getPadding(
                                                                              top: 6),
                                                                          child: Text(
                                                                              "${education.startDate.toString()} - ${education.currentlySchoolHere == true ? "Present" : education.endDate.toString()}",
                                                                              style: theme
                                                                                  .textTheme
                                                                                  .labelLarge)
                                                                      ),
                                                                    ]))
                                                        )
                                                      ]
                                                  )
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ) : const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Add your education",
                                          ),
                                        ),
                                      ),
                                    ])),
                          ])
                  ))
          ),
        ));
        });
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

  /// Navigates to the settingsScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the settingsScreen.
  onTapImage(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.settingsScreen,
    ).then((_){
      refreshData(context);
    });
  }

  refreshData(BuildContext context){
    context.read<ProfileBloc>().add(ProfileInitialEvent());
    context.read<ProfileBloc>().add(GetUserResumeDataEvent());
  }
}
