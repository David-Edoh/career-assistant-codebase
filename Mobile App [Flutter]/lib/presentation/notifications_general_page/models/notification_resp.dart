class NotificationApiResponse {
  List<NotificationItem>? notifications;

  NotificationApiResponse({this.notifications});

  NotificationApiResponse.fromJson(List<dynamic> json) {
    notifications = json
        .map((notification) =>
        NotificationItem.fromJson(notification))
        .toList();
  }

  List<Map<String, dynamic>> toJson() {
    return notifications?.map((notification) => notification.toJson()).toList() ??
        [];
  }
}

class NotificationItem {
  int? id;
  String? type;
  int? targetUserId;
  bool? isSeen;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? postId;
  User? user;
  Post? post;

  NotificationItem({
    this.id,
    this.type,
    this.targetUserId,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.postId,
    this.user,
    this.post,
  });

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    targetUserId = json['targetUserId'];
    isSeen = json['isSeen'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    postId = json['postId'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
    post = json['Post'] != null ? Post.fromJson(json['Post']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['targetUserId'] = targetUserId;
    data['isSeen'] = isSeen;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    data['postId'] = postId;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    if (post != null) {
      data['Post'] = post!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? picturePath;

  User({this.id, this.username, this.firstName, this.lastName, this.picturePath});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picturePath = json['picturePath'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['picturePath'] = picturePath;
    return data;
  }
}

class Post {
  int? id;
  String? text;
  String? media;
  String? createdAt;
  String? state;
  String? updatedAt;
  int? userId;

  Post({
    this.id,
    this.text,
    this.media,
    this.createdAt,
    this.state,
    this.updatedAt,
    this.userId,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    media = json['media'];
    createdAt = json['createdAt'];
    state = json['state'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['media'] = media;
    data['createdAt'] = createdAt;
    data['state'] = state;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}
