import '../../../data/models/loginAuth/post_login_auth_resp.dart';
class PostsResponse {
  List<Post>? posts;

  PostsResponse({
    this.posts,
  });

  PostsResponse.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((post) {
        posts!.add(Post.fromJson(post));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((post) => post.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int? id;
  String? text;
  String? createdAt;
  String? state;
  String? updatedAt;
  int? userId;
  int? commentsCount;
  int? likesCount;
  int? dislikesCount;
  User? user;
  String? videoUrl;
  List<Comment>? comments;
  List<Reaction>? reactions;
  List<String>? media;
  Reaction? reaction;

  Post({
    this.id,
    this.text,
    this.media,
    this.videoUrl,
    this.createdAt,
    this.state,
    this.updatedAt,
    this.userId,
    this.commentsCount,
    this.likesCount,
    this.dislikesCount,
    this.user,
    this.comments,
    this.reactions,
    this.reaction,
  });

  Post.fromJson(Map<String, dynamic> json) {

    id = int.parse(json['id'].toString());
    text = json['text'];
    media = (json['media'] as List<dynamic>?)?.cast<String>();
    // videoUrl = json['videoUrl'];
    createdAt = json['createdAt'];
    state = json['state'];
    updatedAt = json['updatedAt'];
    userId = int.parse(json['userId'].toString());
    commentsCount = json['commentsCount'] != null ? int.parse(json['commentsCount'].toString()) : null;
    likesCount = json['likesCount'] != null ? int.parse(json['likesCount'].toString()) : null;
    dislikesCount = json['dislikesCount'] != null ? int.parse(json['dislikesCount'].toString()) : null;
    user = json['User'] != null ? User.fromJson(json['User']) : null;
    if (json['Comments'] != null) {
      comments = <Comment>[];
      json['Comments'].forEach((comment) {
        comments!.add(Comment.fromJson(comment));
      });
    }
    if (json['Reactions'] != null) {
      reactions = <Reaction>[];
      json['Reactions'].forEach((reaction) {
        reactions!.add(Reaction.fromJson(reaction));
      });
    }
    reaction = json['reaction'] != null ? Reaction.fromJson(json['reaction']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['media'] = media;
    data['videoUrl'] = videoUrl;
    data['createdAt'] = createdAt;
    data['state'] = state;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    data['commentsCount'] = commentsCount;
    data['likesCount'] = likesCount;
    data['dislikesCount'] = dislikesCount;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    if (comments != null) {
      data['Comments'] = comments!.map((comment) => comment.toJson()).toList();
    }
    if (reactions != null) {
      data['Reactions'] = reactions!.map((reaction) => reaction.toJson()).toList();
    }
    if (reaction != null) {
      data['reaction'] = reaction!.toJson();
    }
    return data;
  }
}

class Comment {
  int? id;
  String? text;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? postId;
  User? user;

  Comment({
    this.id,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.postId,
    this.user,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    text = json['text'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = int.parse(json['userId'].toString());
    postId = int.parse(json['postId'].toString());
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    data['postId'] = postId;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}

class Reaction {
  int? id;
  String? state;
  String? createdAt;
  String? updatedAt;
  int? postId;
  int? userId;
  User? user;

  Reaction({
    this.id,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.postId,
    this.userId,
    this.user,
  });

  Reaction.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    postId = int.parse(json['postId'].toString());
    userId = int.parse(json['userId'].toString());
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['postId'] = postId;
    data['userId'] = userId;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}


