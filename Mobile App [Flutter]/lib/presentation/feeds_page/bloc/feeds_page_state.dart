// ignore_for_file: must_be_immutable

part of 'feeds_page_bloc.dart';

/// Represents the state of Feeds in the application.
class FeedsState extends Equatable {
  FeedsState({
    this.FeedsModelObj,
    this.page,
    this.posts,
    this.postsWithAds,
    this.newPostTextController,
    this.addPost,
    this.sendingPost,
    this.images,
    this.videos,
    this.loadingPosts = false,
    this.hasMoreFeeds = true,
    this.scrollController,
  });

  FeedsModel? FeedsModelObj;
  int? page = 1;
  List<Post>? posts;
  List<Object>? postsWithAds;
  TextEditingController? newPostTextController;
  bool? addPost = false;
  bool? sendingPost = false;
  bool loadingPosts = false;
  bool hasMoreFeeds = true;
  List<String>? images;
  List<String>? videos;
  ScrollController? scrollController;

  @override
  List<Object?> get props => [
        FeedsModelObj,
        page,
        posts,
        newPostTextController,
        addPost,
        sendingPost,
        images,
        videos,
        loadingPosts,
        scrollController,
        hasMoreFeeds,
        postsWithAds,
      ];
  FeedsState copyWith(
      {
        FeedsModel? FeedsModelObj,
        int? page,
        List<Post>? posts,
        TextEditingController? newPostTextController,
        bool? addPost,
        bool? sendingPost,
        List<String>? images,
        List<String>? videos,
        bool? loadingPosts,
        ScrollController? scrollController,
        bool? hasMoreFeeds,
        List<Object>? postsWithAds,
      }) {
    return FeedsState(
      FeedsModelObj: FeedsModelObj ?? this.FeedsModelObj,
      page: page ?? this.page,
      posts: posts ?? this.posts,
      newPostTextController: newPostTextController ?? this.newPostTextController,
      addPost: addPost ?? this.addPost,
      sendingPost: sendingPost ?? this.sendingPost,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      postsWithAds: postsWithAds ?? this.postsWithAds,
      loadingPosts: loadingPosts ?? this.loadingPosts,
      scrollController: scrollController ?? this.scrollController,
      hasMoreFeeds: hasMoreFeeds ?? this.hasMoreFeeds,
    );
  }
}
