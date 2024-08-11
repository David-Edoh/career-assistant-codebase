// ignore_for_file: must_be_immutable
part of 'home_container_bloc.dart';

/// Represents the state of HomeContainer in the application.
class HomeContainerState extends Equatable {
  HomeContainerState({
    this.homeContainerModelObj,
    this.panelController,
    this.commentController,
    this.commentsWithAds,
    this.openSlideUpPanel,
    this.sendingComment,
    this.postId,
    this.comments,
    this.activePost,
    this.loadingComments = false,
    this.thisUser
  });

  HomeContainerModel? homeContainerModelObj;
  PanelController? panelController = PanelController();
  TextEditingController? commentController;
  bool? openSlideUpPanel = false;
  bool? sendingComment = false;
  bool loadingComments = false;
  int? postId;
  List<Comment>? comments;
  List<Object>? commentsWithAds;
  int? activePost;
  User? thisUser;

  @override
  List<Object?> get props => [
        homeContainerModelObj,
        panelController,
        commentController,
        openSlideUpPanel,
        sendingComment,
        postId,
        comments,
        activePost,
        loadingComments,
        thisUser,
        commentsWithAds,
      ];

  HomeContainerState copyWith({
    HomeContainerModel? homeContainerModelObj,
    PanelController? panelController,
    String? buttonText,
    TextEditingController? commentController,
    bool? openSlideUpPanel,
    bool? sendingComment,
    int? postId,
    List<Comment>? comments,
    List<Object>? commentsWithAds,
    int? activePost,
    bool? loadingComments,
    User? thisUser,
  }) {
    return HomeContainerState(
        homeContainerModelObj: homeContainerModelObj ?? this.homeContainerModelObj,
        panelController: panelController ?? this.panelController,
        commentController: commentController ?? this.commentController,
        openSlideUpPanel: openSlideUpPanel ?? this.openSlideUpPanel,
        sendingComment: sendingComment ?? this.sendingComment,
        postId: postId ?? this.postId,
        comments: comments ?? this.comments,
        activePost: activePost ?? this.activePost,
        loadingComments: loadingComments ?? this.loadingComments,
        commentsWithAds: commentsWithAds ?? this.commentsWithAds,
        thisUser: thisUser ?? this.thisUser,
    );
  }
}
