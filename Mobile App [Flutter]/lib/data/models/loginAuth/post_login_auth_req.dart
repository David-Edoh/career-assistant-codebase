class PostLoginAuthReq {
  String? password;
  String? email;
  String? fcmToken;


  PostLoginAuthReq(
      {
        this.password,
        this.email,
        this.fcmToken,
      });

  PostLoginAuthReq.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json['email'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (password != null) {
      data['password'] = password;
    }

    if (email != null) {
      data['email'] = email;
    }

    if (fcmToken != null) {
      data['fcmToken'] = fcmToken;
    }

    return data;
  }
}
