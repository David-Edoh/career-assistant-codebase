import 'package:fotisia/presentation/search_screen/widgets/listlogo_one_item_widget.dart';
import '../../core/constants/global_keys.dart';
import '../../widgets/custom_icon_button.dart';
import '../search_screen/widgets/search_item_widget.dart';
import 'bloc/search_bloc.dart';
import 'models/listlogo_one_item_model.dart';
import 'models/search_user_model.dart';
import 'models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_search_view.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SearchBloc>(
        create: (context) =>
            SearchBloc(SearchState(searchModelObj: SearchModel()))
              ..add(SearchInitialEvent()),
        child: SearchScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        appBar: CustomAppBar(
            leadingWidth: getHorizontalSize(50),
            height: getVerticalSize(70),
            leading: Semantics(
              label: "Button: Go back to feeds page",
              child: AppbarImage(
                  svgPath: ImageConstant.imgGroup162799,
                  margin: getMargin(left: 24, top: 13, bottom: 13),
                  onTap: () {
                    // onTapArrowbackone(context);
                    Navigator.pushNamed(
                        GlobalKeys.navigatorKey.currentContext!, AppRoutes.feedsPage);
                  }),
            ),
            centerTitle: true,
            title: AppbarTitle(
                text: "Search",
                margin: EdgeInsets.only(right: getHorizontalSize(50)),
            )
        ),
        body: Container(
            width: double.maxFinite,
            padding: getPadding(left: 24, right: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocSelector<SearchBloc, SearchState,
                          TextEditingController?>(
                      selector: (state) => state.searchController,
                      builder: (context, searchController) {
                        return CustomSearchView(
                            margin: getMargin(top: 30),
                            controller: searchController,
                            onChanged: (text){
                              context.read<SearchBloc>().add(FindEvent(keyword: text));
                            },
                            hintText: "lbl_search".tr,
                            hintStyle:
                                CustomTextStyles.titleMediumBluegray400,
                            prefix: Container(
                                margin: getMargin(
                                    left: 16,
                                    top: 17,
                                    right: 8,
                                    bottom: 17),
                                child: CustomImageView(
                                    svgPath: ImageConstant.imgSearch)
                            ),
                            prefixConstraints: BoxConstraints(
                                maxHeight: getVerticalSize(70)),

                            suffixConstraints: BoxConstraints(
                                maxHeight: getVerticalSize(70))
                        );
                      }),

                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: getVerticalSize(500),
                    child: ContainedTabBarView(
                      tabs: const [
                        SizedBox(
                            height: 48,
                            child: Align(
                              alignment: Alignment.center,
                                child: Text('People', style: TextStyle(color: Colors.black),)
                            )
                        ),
                        SizedBox(
                            height: 48,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Posts', style: TextStyle(color: Colors.black),)
                            )
                        ),
                      ],
                      views: [
                        Container(
                          height: mediaQueryData.size.height * 0.6,
                          child: (state.users != null && state.users!.isNotEmpty) ? ListView(
                              children: state.users!.map((user) {

                              return GestureDetector(
                                onTap:  () {
                                  if(user != null) {
                                    NavigatorService.pushNamed(
                                      AppRoutes.userProfilePage,
                                      arguments: {'userId': user.id},
                                    );
                                  }
                                },
                                child: Container(
                                  padding: getPadding(
                                    all: 16,
                                  ),
                                  margin: getMargin(bottom: 5, top: 5),
                                  decoration: AppDecoration.outlineIndigo.copyWith(
                                    borderRadius: BorderRadiusStyle.roundedBorder16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomIconButton(
                                        height: getSize(48),
                                        width: getSize(48),
                                        padding: getPadding(
                                          all: 7,
                                        ),
                                        child: CustomImageView(
                                          url: user.picturePath ?? "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",

                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          left: 12,
                                          top: 4,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${user.firstName} ${user.lastName}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              }).toList(),
                          ) : const Center(
                              child: Text("No result found")
                          ),
                        ),



                        Container(
                          child: (state.posts != null && state.posts!.isNotEmpty) ? ListView(
                            children: state.posts!.map((post) {

                              return GestureDetector(
                                onTap:  () {
                                  // if(post != null) {
                                  //   NavigatorService.pushNamed(
                                  //     AppRoutes.singlePostScreen,
                                  //     arguments: {'postId': post.id},
                                  //   );
                                  // }
                                },
                                child: ListlogoOneItemWidget(
                                    ListlogoOneItemModel(
                                      id: post.id.toString(),
                                      comments: post.comments,
                                      usersName: post.user?.username ??
                                          "Anonymous",
                                      firstName: post.user?.firstName ??
                                          "Anonymous",
                                      lastName: post.user?.lastName ??
                                          "",
                                      profilePicture: post.user
                                          ?.picturePath ??
                                          "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                      commentText: post.text ?? "",
                                      images: post.media,
                                      video: post.videoUrl,
                                      reaction: post.reaction,
                                      reactions: post.reactions,
                                      post: post,
                                      posts: state.posts,
                                    )
                                ),
                              );
                            }).toList(),
                          ) : const Center(
                              child: Text("No result found")
                          ),
                        ),
                      ],
                      onChange: (index) => print(index),
                    ),
                  ),

                ])
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

  /// Navigates to the jobDetailsTabContainerScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the jobDetailsTabContainerScreen.
  onTapView(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.jobDetailsTabContainerScreen,
    );
  }
}
