class Comment {
  String createdAt;
  String updatedAt;
  int id;
  int userId;
  String postId;
  String text;

  Comment({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.postId,
    required this.text,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      id: json['id'] as int,
      userId: json['userId'] as int,
      postId: json['postId'].toString(),
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
      'userId': userId,
      'postId': postId,
      'text': text,
    };
  }
}
