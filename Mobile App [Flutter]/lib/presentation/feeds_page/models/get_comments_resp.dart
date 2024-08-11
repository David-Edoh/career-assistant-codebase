import 'package:fotisia/presentation/feeds_page/models/get_feeds_resp.dart';

class CommentsResponse {
  List<Comment>? comments;

  CommentsResponse({
    this.comments,
  });

  CommentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((comment) {
        comments!.add(Comment.fromJson(comment));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (comments != null) {
      data['comments'] = comments!.map((post) => post.toJson()).toList();
    }
    return data;
  }
}