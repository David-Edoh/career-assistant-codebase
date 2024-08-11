import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:fotisia/presentation/feeds_page/widgets/list_item_with_media.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/constants/global_keys.dart';
import '../../widgets/AdmobAdLarge.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/photo_grid.dart';
import '../feeds_page/widgets/listlogo_one_item_widget.dart';
import 'bloc/feeds_page_bloc.dart';
import 'models/get_feeds_resp.dart';
import 'models/listlogo_one_item_model.dart';
import 'models/feeds_page_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/app_bar/appbar_subtitle.dart';
import 'package:fotisia/widgets/app_bar/appbar_image_1.dart';
import 'package:image/image.dart' as img;

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  FeedsPageState createState() =>
      FeedsPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<FeedsBloc>(
        create: (context) => FeedsBloc(FeedsState(
            FeedsModelObj: FeedsModel()))
          ..add(FeedsInitialEvent()),
        child: FeedsPage());
  }
}

class FeedsPageState extends State<FeedsPage>
    with AutomaticKeepAliveClientMixin<FeedsPage> {
    @override
    bool get wantKeepAlive => true;

    // final ScrollController scrollController = ScrollController();

    // @override
    // initState(){
    //   super.initState();
    //
    //   scrollController.addListener(() {
    //     if(scrollController.position.maxScrollExtent == scrollController.offset){
    //
    //     }
    //   });
    //
    // }

    // @override
    // void dispose() {
    //   scrollController.dispose();
    //
    //   super.dispose();
    // }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<FeedsBloc, FeedsState>(
        builder: (context, state)
    {
      return Scaffold(
          backgroundColor: appTheme.whiteA70001,
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              // padding: EdgeInsets.zero,
              children: [
                // ListTile(
                //   textColor: Colors.black,
                //   iconColor: Colors.black,
                //   title: const Text('Inbox'),
                //   leading: CustomImageView(
                //     svgPath: ImageConstant.imgMailInbox,
                //     height: 20,
                //     width: 20,
                //   ),
                //   onTap: () {
                //     // Update the state of the app
                //     NavigatorService.pushNamed(AppRoutes.messagePage);
                //
                //     // Then close the drawer
                //     Navigator.pop(context);
                //   },
                // ),
                ListTile(
                  title: const Text('Notifications'),
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  leading: CustomImageView(
                    svgPath: ImageConstant.imgNotification,
                    height: 20,
                    width: 20,
                  ),
                  // selected: _selectedIndex == 1,
                  onTap: () {
                    // Update the state of the app
                    NavigatorService.pushNamed(
                        AppRoutes.notificationsGeneralPage);

                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                 // Padding(
                 //   padding: const EdgeInsets.only(top:15.0),
                 //   child: SizedBox(
                 //     height: 350,
                 //     child: DrawerHeader(
                 //      decoration: const BoxDecoration(
                 //        color: Colors.white,
                 //      ),
                 //      child: AdMobAdLarge(),
                 //     ),
                 //   ),
                 // ),
              ],
            ),
          ),
          appBar: AppBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 1.0,
              title: Padding(
                padding: getPadding(
                  left: 10,
                ),
                child: Text(
                  "Fotisia",
                  style: CustomTextStyles.titleSmallPrimaryBold.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              actions: [
                Semantics(
                  label: "Search button: search for articles, posts, or users.",
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(GlobalKeys.navigatorKey.currentContext!, AppRoutes.searchScreen);
                    },
                    icon: const Icon(
                        Icons.search,
                      semanticLabel: "Search button: search for articles, posts, or users.",
                    ),
                  )
                  // AppbarImage1(
                  //     svgPath: ImageConstant.imgSearch,
                  //     margin: getMargin(left: 3, top: 15, right: 3, bottom: 15),
                  //     onTap: () {
                  //       // NavigatorService.pushNamed(AppRoutes.searchScreen);
                  //       Navigator.pushNamed(GlobalKeys.navigatorKey.currentContext!, AppRoutes.searchScreen);
                  //     }),
                )
              ]
          ),

          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<FeedsBloc>().add(FeedsInitialEvent());
              },
              child: Container(
                // width: double.maxFinite,
                // decoration: AppDecoration.fillWhiteA70001,
                  child: Column(
                    children: [
                      (state.addPost ?? false) ? Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Semantics(
                              label: "button: close create post window button",
                              child: TextButton(
                                onPressed: () {
                                  context.read<FeedsBloc>().add(CloseCreatePostWidgetEvent());
                                  },
                                child: Semantics(
                                  label: "Image: close create post window button",
                                  child: CustomImageView(
                                    svgPath: ImageConstant.imgClose2,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocSelector<FeedsBloc,
                                  FeedsState,
                                  TextEditingController?>(
                                  selector: (state) => state.newPostTextController,
                                  builder: (context, newPostTextController) {
                                    return CustomTextFormField(
                                        maxLines: 2,
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        controller: newPostTextController,
                                        margin: getMargin(left: 10, right: 10, bottom: 10, top: 10),
                                        hintText: "Type an update...",
                                        hintStyle: CustomTextStyles.labelLargeGray600,
                                        textInputAction: TextInputAction.done,
                                        contentPadding: getPadding(left: 30, top: 20, right: 30, bottom: 20),
                                        borderDecoration: TextFormFieldStyleHelper.fillGray,
                                        fillColor: appTheme.gray20001,
                                        // validator: ,

                                    );
                                  }),
                              Semantics(
                                label: "Button: Upload a media button (Image or video allowed)",
                                child: GestureDetector(
                                  onTap: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
                                    allowMultiple: true,
                                  );

                                  List<String> images = [];
                                  List<String> videos = [];

                                  if (result != null) {
                                    List<PlatformFile> files = result.files;

                                    for (var file in files) {
                                      if (isImage(file.path!)) {
                                        images.add(file.path!);
                                      } else {
                                        videos.add(file.path!);
                                      }
                                    }

                                    context.read<FeedsBloc>().add(SetImages(images: images));
                                    context.read<FeedsBloc>().add(SetVideos(videos: videos));
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                  child: CustomImageView(
                                    svgPath: ImageConstant.imgUploadPrimary,
                                    width: 48,
                                    height: 48,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          (state.images != null && state.images!.isNotEmpty) ? Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: state.images!.length > 2 ? 380 : 200,
                                child: PhotoGrid(
                                  imageUrls: state.images ?? [],
                                  onImageClicked: (i) => print('Image $i was clicked!'),
                                  onExpandClicked: () => print('Expand Image was clicked'),
                                  maxImages: 4,
                                ),
                              ),
                            ),
                          ) : Container(),

                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (state.images != null && state.images!.isNotEmpty) ? TextButton(onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context2)
                                  {
                                    return AlertDialog(
                                      title: const Text(
                                          'Clear Images'),
                                      content:
                                      const Text('Are you sure you want to remove the selected items?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context2, 'Cancel'),
                                          child:
                                          const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () {
                                                context.read<FeedsBloc>().add(ClearImagesEvent());
                                                Navigator.pop(context2, 'Removed');
                                          },
                                          child:
                                          const Text('Remove'),
                                        ),
                                      ],
                                    );
                                  },
                                ), child: Text("Clear Images")
                                ) : Container(),

                                Semantics(
                                  label: "Button: Submit this post button",
                                  child: CustomElevatedButton(
                                      onTap: () => context.read<FeedsBloc>().add(AddPost()),
                                      margin: getMargin(bottom: 10, right: 10),
                                      isDisabled: state.sendingPost,
                                      height: 48,
                                      width: getHorizontalSize(137),
                                      text: !(state.sendingPost ?? false) ? "Post" : "",
                                      leftIcon: (state.sendingPost ?? false)! ? Container(
                                          margin: getMargin(right: 4),
                                          child: LoadingAnimationWidget.staggeredDotsWave(
                                            color: theme.colorScheme.secondary,
                                            size: 20,
                                          )
                                      ) : Container(),
                                      buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                                      buttonTextStyle: CustomTextStyles
                                          .titleSmallGray5001),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: appTheme.indigo50
                              )
                          ),

                        ],
                      ) : Container(),

                      !state.loadingPosts ?
                      Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                  padding: getPadding(top: 24),
                                  child: BlocSelector<
                                      FeedsBloc,
                                      FeedsState,
                                      List<Object>?>(
                                      selector: (state) => state.postsWithAds,
                                      builder: (context, posts) {
                                        return (posts != null && posts.isNotEmpty) ?
                                        ListView.builder(
                                          // physics: BouncingScrollPhysics(),
                                          // shrinkWrap: true,
                                          controller: state.scrollController,
                                          itemCount: posts!.length + 1,
                                          itemBuilder: (context, index) {
                                            if(index < posts!.length){

                                              Object post = posts[index];
                                              if(post is Post){
                                              return  post.media != null && post.media!.isNotEmpty ? ListOneItemWithMediaWidget(
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
                                                      externalUrl: post.externalUrl,
                                                      images: post.media,
                                                      video: post.videoUrl,
                                                      reaction: post.reaction,
                                                      reactions: post.reactions,
                                                      likesCount: post.likesCount,
                                                      commentsCount: post.commentsCount,
                                                      post: post,
                                                      posts: state.posts,
                                                    )
                                                ) : ListlogoOneItemWidget(
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
                                                      externalUrl: post.externalUrl,
                                                      images: post.media,
                                                      video: post.videoUrl,
                                                      reaction: post.reaction,
                                                      reactions: post.reactions,
                                                      likesCount: post.likesCount,
                                                      commentsCount: post.commentsCount,
                                                      post: post,
                                                      posts: state.posts,
                                                    )
                                                );
                                              } else {
                                                return Container(
                                                  height: 320,
                                                    child: AdMobAdLarge()
                                                );
                                              }
                                            } else {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Center(
                                                    child: state.hasMoreFeeds ? const CircularProgressIndicator() : const Text("you've reached the end", )
                                                ),
                                              );
                                            }
                                          },

                                        )
                                            : const Center(
                                            child: Text("No post found")
                                        );
                                      })
                              ),
                              // if (state.addPost != true) Align(
                              //   alignment: Alignment.bottomRight,
                              //   child: CustomElevatedButton(
                              //       onTap: () => context.read<FeedsBloc>().add(ShowAddPost()),
                              //       margin: getMargin(bottom: 10, right: 10),
                              //       height: getVerticalSize(70),
                              //       width: getHorizontalSize(150),
                              //       text: "Post an Update",
                              //       leftIcon: Container(
                              //           margin: getMargin(right: 4),
                              //           child: CustomImageView(svgPath: ImageConstant.imgPlusGray5001),
                              //       ),
                              //       buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                              //       buttonTextStyle: CustomTextStyles.titleSmallGray5001
                              //   ),
                              // ),
                            ],
                          ),
                        )
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: LoadingAnimationWidget.beat(
                                  color: theme.colorScheme.primary,
                                  size: 20,
                              ),
                            ),
                          ),
                    ],
                  )),
            ),
          )
      );
    });
  }

  onTapImage(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.messagePage,
    );
  }


  bool isImage(String filePath) {
    List<int> bytes = File(filePath).readAsBytesSync();
    img.Image? image = img.decodeImage(Uint8List.fromList(bytes));

    return image != null;
  }
}
