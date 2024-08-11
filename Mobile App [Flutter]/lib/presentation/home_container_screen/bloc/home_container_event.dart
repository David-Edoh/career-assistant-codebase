// ignore_for_file: must_be_immutable

part of 'home_container_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///HomeContainer widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class HomeContainerEvent extends Equatable {}

/// Event that is dispatched when the HomeContainer widget is first created.
class HomeContainerInitialEvent extends HomeContainerEvent {
  @override
  List<Object?> get props => [];
}


class TogglePanelController extends HomeContainerEvent {

  TogglePanelController({
    this.postId,
    // this.comments
  });

  int? postId;
  // List<Comment>? comments;

  @override
  List<Object?> get props => [
    postId,
    // comments
  ];
}

class TogglePostReactionEvent extends HomeContainerEvent {

  TogglePostReactionEvent({
    this.postId,
  });

  int? postId;

  @override
  List<Object?> get props => [
    postId,
  ];
}

class DeletePostReactionEvent extends HomeContainerEvent {

  DeletePostReactionEvent({
    this.reactionId,
  });

  int? reactionId;

  @override
  List<Object?> get props => [
    reactionId,
  ];
}

class DeleteCommentEvent extends HomeContainerEvent {

  DeleteCommentEvent({
    this.commentId,
  });

  int? commentId;

  @override
  List<Object?> get props => [
    commentId,
  ];
}


class SetCloseSlideUpPanel extends HomeContainerEvent {
  @override
  List<Object?> get props => [];
}

class PostCommentEvent extends HomeContainerEvent {
  @override
  List<Object?> get props => [];
}