// ignore_for_file: must_be_immutable

part of 'single_post_bloc.dart';

/// Represents the state of Profile in the application.
class SinglePostState extends Equatable {
  SinglePostState({
    this.opentowork = false,
    this.post,
    this.thisUser,
    this.activePost,
    this.comments,
    this.commentController,
    this.sendingComment,
    this.postId,
  });

  bool opentowork;
  Post? post;
  int? activePost;
  User? thisUser;
  List<Comment>? comments;
  TextEditingController? commentController;
  int? postId;
  bool? sendingComment = false;

  @override
  List<Object?> get props => [
        opentowork,
        post,
        activePost,
        thisUser,
        comments,
    commentController,
    sendingComment,
    postId,
  ];

  SinglePostState copyWith({
    bool? opentowork,
    Post? post,
    int? activePost,
    User? thisUser,
    bool? sendingComment,
    int? postId,
    List<Comment>? comments,
    TextEditingController? commentController,

  }) {
    return SinglePostState(
      opentowork: opentowork ?? this.opentowork,
      post: post ?? this.post,
      activePost: activePost ?? this.activePost,
      thisUser: thisUser ?? this.thisUser,
      sendingComment: sendingComment ?? this.sendingComment,
      postId: postId ?? this.postId,
      comments: comments ?? this.comments,
      commentController: commentController ?? this.commentController,

    );
  }
}
