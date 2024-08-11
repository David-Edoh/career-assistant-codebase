// ignore_for_file: must_be_immutable

part of 'feeds_page_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Feeds widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class FeedsEvent extends Equatable {}

/// Event that is dispatched when the Feeds widget is first created.
class FeedsInitialEvent extends FeedsEvent {
  @override
  List<Object?> get props => [];
}

class NextFeedsEvents extends FeedsEvent {
  @override
  List<Object?> get props => [];
}

class ShowAddPost extends FeedsEvent {
  @override
  List<Object?> get props => [];
}

class AddPost extends FeedsEvent {
  @override
  List<Object?> get props => [];
}

class ClearImagesEvent extends FeedsEvent {
  @override
  List<Object?> get props => [];
}

class SetImages extends FeedsEvent {
  SetImages({
    this.images,
  });

  List<String>? images;

  @override
  List<Object?> get props => [
    images
  ];
}

class SetVideos extends FeedsEvent {
  SetVideos({
    this.videos,
  });

  List<String>? videos;

  @override
  List<Object?> get props => [
    videos
  ];
}

class DeletePostEvent extends FeedsEvent {

  DeletePostEvent({
    this.postId,
  });

  int? postId;

  @override
  List<Object?> get props => [
    postId,
  ];
}

class CloseCreatePostWidgetEvent extends FeedsEvent {
  @override
  List<Object?> get props => [];
}

class UpdatePostEvent extends FeedsEvent {
  UpdatePostEvent({
    this.posts,
  });

  List<Post>? posts;

  @override
  List<Object?> get props => [
    posts
  ];
}