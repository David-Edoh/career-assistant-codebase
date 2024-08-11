import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../user_profile_page/widgets/chipviewskills_item_widget.dart';
import '../user_profile_page/widgets/user_profile_item_widget.dart';
import 'bloc/user_profile_bloc.dart';
import 'models/chipviewskills_item_model.dart';
import 'models/user_profile_item_model.dart';
import 'models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_image_1.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_checkbox_button.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';

class UserProfilePage extends StatelessWidget {
   UserProfilePage({Key? key}) : super(key: key);


   static Widget builder(BuildContext context) {
    return BlocProvider<UserProfileBloc>(
        create: (context)
            {
              // final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
              // print(arguments['userId']);
              // int userId = arguments['userId'];

              return UserProfileBloc(UserProfileState(profileModelObj: ProfileModel()));
                // ..add(UserProfileInitialEvent(userId: 2));
            },
              // ..add(GetUserResumeDataEvent()),
        child: UserProfilePage()
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    context.read<UserProfileBloc>().add(UserProfileInitialEvent(userId: arguments['userId']));

    return BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return  Scaffold(
        backgroundColor: appTheme.whiteA70001,
            appBar: CustomAppBar(
                leadingWidth: getHorizontalSize(50),
                height: getVerticalSize(70),
                leading: AppbarImage(
                    svgPath: ImageConstant.imgGroup162799,
                    margin: getMargin(left: 24, top: 13, bottom: 14),
                    onTap: () {
                      onTapArrowbackone(context);
                    }),
                centerTitle: true,
                title: AppbarTitle(text: "lbl_profile".tr),
                actions: [
                  (state.currentUserId == arguments['userId']) ? AppbarImage1(
                      svgPath: ImageConstant.imgGroup162903,
                      margin:
                          getMargin(left: 24, top: 13, right: 24, bottom: 13),
                      onTap: () {
                        onTapImage(context);
                      }) : Container()
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
                                      CustomImageView(
                                          imagePath: ImageConstant.imgBg,
                                          height: getVerticalSize(120),
                                          width: getHorizontalSize(327),
                                          radius: BorderRadius.circular(
                                              getHorizontalSize(8)),
                                          alignment: Alignment.topCenter),
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
                                                    CustomImageView(
                                                        url: (state.picturePath != null && state.picturePath!.isNotEmpty) ? state.picturePath : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                                        height: getSize(150),
                                                        width: getSize(150),
                                                        radius: BorderRadius.circular(getHorizontalSize(100))
                                                    ),
                                                    Padding(
                                                        padding: getPadding(
                                                            top: 9),
                                                        child: Text(
                                                            "${state.firstName ?? "..."} ${state.lastName ?? ""}",
                                                            style: CustomTextStyles
                                                                .titleMediumErrorContainer)
                                                    ),

                                                  ]
                                              )
                                          )
                                      )
                                    ]
                                )
                            ),

                            (state.friendshipState == "pending" && state.currentUserId == state.relationship?.secondUserId) ? const Text('Wants to be your friend') : Container(),

                            (state.currentUserId != arguments['userId']) ? SizedBox(
                              width: mediaQueryData.size.width * .63,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    state.friendshipState == "Not Friends" && state.firstName != "Anonymous" ? CustomElevatedButton(
                                        onTap: () {
                                          context.read<UserProfileBloc>().add(AddFriend(userId: arguments['userId']));
                                        },
                                        // isDisabled: !(state.changingFriendshipStateDone ?? true),
                                        height: getVerticalSize(55),
                                        width: getHorizontalSize(137),
                                        text: 'Make Friend',
                                        leftIcon: Container(
                                          margin: getMargin(right: 4),
                                          child: CustomImageView(svgPath: ImageConstant.imgPlusGray5001),
                                        ),
                                        buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                                        buttonTextStyle: CustomTextStyles
                                            .titleSmallGray5001) : Container(),

                                    (state.friendshipState == "pending" && state.currentUserId == state.relationship?.firstUserId) ? CustomElevatedButton(
                                        onTap: () {
                                          context.read<UserProfileBloc>().add(CancelFriendRequest(relationshipId: state.relationship?.id));
                                        },
                                        height: getVerticalSize(55),
                                        width: getHorizontalSize(137),
                                        text: 'Cancel Request',
                                        // leftIcon: Container(
                                        //   margin: getMargin(right: 4),
                                        //   child: const Icon(
                                        //     Icons.cancel,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                        buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                                        buttonTextStyle: CustomTextStyles
                                            .titleSmallGray5001) : Container(),

                                    (state.friendshipState == "pending" && state.currentUserId == state.relationship?.secondUserId) ?  SizedBox(
                                      width: 170,
                                      child:  DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                                          // the menu padding when button's width is not specified.
                                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          // Add more decoration..
                                        ),
                                        hint: const Text(
                                          'Respond',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: 'accept',
                                            child: const Text(
                                              'Accept Request',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            onTap: (){
                                              context.read<UserProfileBloc>().add(AcceptFriendRequest(relationshipId: state.relationship?.id));
                                            },
                                          ),

                                          DropdownMenuItem<String>(
                                            value: 'reject',
                                            child: const Text(
                                              'Reject Request',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            onTap: (){
                                              context.read<UserProfileBloc>().add(RejectFriendRequest(relationshipId: state.relationship?.id));
                                            },
                                          ),
                                        ],
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select gender.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          //Do something when selected item is changed.
                                        },
                                        // onSaved: (value) {
                                        //   selectedValue = value.toString();
                                        // },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    ) : Container(),


                                    state.friendshipState == "friends" ?
                                    SizedBox(
                                      width: 170,
                                      child:  DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                                          // the menu padding when button's width is not specified.
                                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          // Add more decoration..
                                        ),
                                        hint: const Text(
                                          'Friends',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: 'unfriend',
                                            child: const Text(
                                              'Remove Friend',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            onTap: (){
                                              context.read<UserProfileBloc>().add(UnFriend(userId: arguments['userId']));
                                            },
                                          ),
                                        ],
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select gender.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          //Do something when selected item is changed.
                                        },
                                        // onSaved: (value) {
                                        //   selectedValue = value.toString();
                                        // },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    )
                                        : Container(),



                                      state.firstName != "Anonymous" ? CustomElevatedButton(
                                        onTap: () {

                                        },

                                        height: getVerticalSize(53),
                                        width: getHorizontalSize(50),
                                        text: '',
                                        leftIcon: Container(
                                          // margin: getMargin(right: 4),
                                          child: const Icon(
                                              Icons.mail,
                                            color: Colors.white,
                                          ),
                                        ),
                                        buttonStyle: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(getHorizontalSize(20.00)),
                                          ),
                                        ),
                                        buttonTextStyle: CustomTextStyles
                                            .titleSmallGray5001
                                    ) : Container(),

                                  ],
                                ),
                              ),
                            ) : Container(),

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
                                              (state.aboutMe != null && state.aboutMe!.isNotEmpty) ? state.aboutMe! : "Not set",
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
                                                  "Phone Number: ${(state.phone != null && state.phone!.isNotEmpty) ? state.phone! : "Not set"}",
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray400_1
                                                      .copyWith(height: 1.57)
                                              ),
                                              Text(
                                                  "Address: ${(state.location != null && state.location!.isNotEmpty) ? state.location! : "Not set"}",
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray400_1
                                                      .copyWith(height: 1.57)
                                              ),
                                            ],
                                          ))
                                    ])),

                            state.fetchingCareerDetailsDone! ? Container(
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
                                            "Not set",
                                          ),
                                        ),
                                      )
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
                            state.fetchingCareerDetailsDone! ? Container(
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
                                            "Not set",
                                          ),
                                        ),
                                      ),
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
                          ])))
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
    // context.read<UserProfileBloc>().add(UserProfileInitialEvent());
    // context.read<UserProfileBloc>().add(GetUserResumeDataEvent());
  }
}
