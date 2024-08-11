import 'get_feeds_resp.dart';

/// This class is used in the [listlogo_one_item_widget] screen.
class ListlogoOneItemModel {
  ListlogoOneItemModel({
    required this.usersName,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    this.commentText,
    this.externalUrl,
    this.comments,
    this.images,
    this.likesCount,
    this.commentsCount,
    this.video,
    this.id,
    this.reactions,
    this.reaction,
    this.post,
    this.posts,
});
  String usersName;
  String firstName;
  String lastName;
  String profilePicture;
  String? externalUrl;
  String? commentText;
  List<String>? images = [];
  List<Comment>? comments = [];
  List<Reaction>? reactions = [];
  int? likesCount;
  int? commentsCount;
  Reaction? reaction;
  String? video;
  String? id = "";
  Post? post;
  List<Post>? posts;
}
