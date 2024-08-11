import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../widgets/custom_text_form_field.dart';
import '../user_profile_page/widgets/chipviewskills_item_widget.dart';
import '../user_profile_page/widgets/user_profile_item_widget.dart';
import 'bloc/single_post_bloc.dart';
import 'widgets/listlogo_one_item_widget.dart';
import 'models/listlogo_one_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_image_1.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_checkbox_button.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';

class SinglePostPage extends StatelessWidget {
   SinglePostPage({Key? key}) : super(key: key);

   int? postId;

   static Widget builder(BuildContext context) {
    return BlocProvider<SinglePostBloc>(
        create: (context)
            {
              return SinglePostBloc(SinglePostState());
            },
              // ..add(GetUserResumeDataEvent()),
        child: SinglePostPage()
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    if(postId == null){
      postId = arguments['postId'];
      context.read<SinglePostBloc>().add(SinglePostInitialEvent(postId: arguments['postId']));
    }

    return BlocBuilder<SinglePostBloc, SinglePostState>(
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
                title: AppbarTitle(text: "Post"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                state.post != null ? ListlogoOneItemWidget(
                    ListlogoOneItemModel(
                      id: state.post?.id.toString(),
                      comments: state.post?.comments,
                      usersName: state.post?.user?.username ??
                          "Anonymous",
                      firstName: state.post?.user?.firstName ??
                          "Anonymous",
                      lastName: state.post?.user?.lastName ??
                          "",
                      profilePicture: state.post?.user
                          ?.picturePath ??
                          "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                      commentText: state.post?.text ?? "",
                      images: state.post?.media,
                      video: state.post?.videoUrl,
                      reaction: state.post?.reaction,
                      reactions: state.post?.reactions,
                      post: state.post,
                      // posts: posts,
                    )
                ) : Container(),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Comments",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),

                (state.comments != null && state.comments!.isNotEmpty) ?  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    // width: MediaQuery.of(context).size.width * 0.95,

                    child: ListView(
                        physics:  const ScrollPhysics(),

                        children: state.comments!.map((comment) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap:  () {
                                              if(comment.user != null) {
                                                NavigatorService.pushNamed(
                                                  AppRoutes.userProfilePage,
                                                  arguments: {'userId': comment.user?.id},
                                                );
                                              }
                                            },
                                            child: CustomIconButton(
                                              height: getSize(40),
                                              width: getSize(40),
                                              margin: getMargin(
                                                left: 10,
                                                right: 10,
                                              ),
                                              padding: getPadding(
                                                all: 4,
                                              ),
                                              decoration: IconButtonStyleHelper.fillGrayTL16,
                                              child: CustomImageView(
                                                url: (comment.user != null && comment.user!.picturePath != null && comment.user!.picturePath!.isNotEmpty) ? comment.user!.picturePath : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                                radius: BorderRadius.circular(getHorizontalSize(44)),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap:  () {
                                              if(comment.user != null) {
                                                NavigatorService.pushNamed(
                                                  AppRoutes.userProfilePage,
                                                  arguments: {'userId': comment.user?.id},
                                                );
                                              }
                                            },
                                            child: Text(
                                              "${comment.user!.firstName} ${comment.user!.lastName}",
                                              style: CustomTextStyles.titleSmallPrimaryBold,
                                            ),
                                          ),
                                        ],
                                      ),

                                      comment.userId == state.thisUser?.id ? PopupMenuButton<int>(
                                        // color: Colors.white,
                                        offset: const Offset(10, 20),
                                        elevation: 2,
                                        itemBuilder: (context) => [
                                          // popupmenu item 1
                                          PopupMenuItem(
                                            onTap: (){
                                              context.read<SinglePostBloc>().add(DeleteCommentEvent(commentId: comment.id));
                                            },
                                            value: 1,
                                            // row has two child icon and text.
                                            child: const Row(
                                              children: [
                                                Icon(Icons.delete),
                                                SizedBox(
                                                  // sized box with width 10
                                                  width: 10,
                                                ),
                                                Text("Delete", style: TextStyle(color: Colors.black),)
                                              ],
                                            ),
                                          ),

                                        ],
                                      ) : Container(),

                                    ],
                                  ),
                                ),
                                Container(
                                    margin: getMargin(left: 12),
                                    padding: getPadding(
                                        left: 12,
                                        top: 10,
                                        right: 12,
                                        bottom: 10),
                                    decoration: AppDecoration.fillGray.copyWith(
                                        borderRadius: BorderRadius.only(
                                          // topLeft: Radius.circular(getHorizontalSize(24)),
                                          topRight: Radius.circular(getHorizontalSize(24)),
                                          bottomRight: Radius.circular(getHorizontalSize(24)),
                                          bottomLeft: Radius.circular(getHorizontalSize(24)),
                                        )),
                                    child: Container(
                                      // width: getHorizontalSize(164),
                                        margin: getMargin(right: 14),
                                        child: Text(comment.text ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: Colors.black),
                                        )
                                    )
                                ),
                                Padding(
                                    padding: getPadding(top: 15),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Divider(
                                            height: getVerticalSize(1),
                                            thickness: getVerticalSize(1),
                                            color: appTheme.indigo50
                                        )
                                    )
                                ),

                              ],
                            ),
                          );
                          //Text(comment.text ?? "here");
                        }).toList()
                    )

                ) : Container(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocSelector<SinglePostBloc, SinglePostState, TextEditingController?>(
                        selector: (state) => state.commentController,
                        builder: (context, messageController) {
                          return CustomTextFormField(
                              controller: messageController,
                              maxLines: 2,
                              margin: getMargin(left: 10, right: 10, bottom: 10),
                              hintText: "Add a comment",
                              hintStyle: CustomTextStyles.labelLargeGray600,
                              textInputAction: TextInputAction.done,
                              contentPadding: getPadding(
                                  left: 30, top: 20, right: 30, bottom: 20),
                              borderDecoration: TextFormFieldStyleHelper.fillGray,
                              fillColor: appTheme.gray20001);
                        }),
                    CustomElevatedButton(
                      text: "Send",
                      onTap: (){
                        context.read<SinglePostBloc>().add(PostCommentEvent());
                      },
                      height: getVerticalSize(46),
                      width: getHorizontalSize(137),
                      buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                      margin: getMargin(left: 10, right: 10, bottom: 30),
                    )
                  ],
                )
              ],
            ),
          )
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
