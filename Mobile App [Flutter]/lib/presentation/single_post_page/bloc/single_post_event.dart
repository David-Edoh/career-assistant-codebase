// ignore_for_file: must_be_immutable

part of 'single_post_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Profile widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SinglePostEvent extends Equatable {}

/// Event that is dispatched when the Profile widget is first created.
class SinglePostInitialEvent extends SinglePostEvent {
  SinglePostInitialEvent({required this.postId});

  int postId;

  @override
  List<Object?> get props => [
    postId,
  ];
}


class UpdatePostEvent extends SinglePostEvent {
  UpdatePostEvent({
    this.posts,
  });

  List<Post>? posts;

  @override
  List<Object?> get props => [
    posts
  ];
}

class DeletePostEvent extends SinglePostEvent {

  DeletePostEvent({
    this.postId,
  });

  int? postId;

  @override
  List<Object?> get props => [
    postId,
  ];
}

class DeleteCommentEvent extends SinglePostEvent {

  DeleteCommentEvent({
    this.commentId,
  });

  int? commentId;

  @override
  List<Object?> get props => [
    commentId,
  ];
}

class PostCommentEvent extends SinglePostEvent {
  @override
  List<Object?> get props => [];
}