class PostRegisterDeviceAuthReq {
  String? username;
  String? password;
  String? email;
  String? fcmToken;
  String? firstName;
  String? lastName;
  String? profilePic;
  int? role;

  PostRegisterDeviceAuthReq(
      {this.username,
      this.password,
      this.email,
      this.fcmToken,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.role});

  PostRegisterDeviceAuthReq.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    fcmToken = json['fcmToken'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePic = json['profile'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (username != null) {
      data['username'] = username;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (fcmToken != null) {
      data['fcmToken'] = fcmToken;
    }
    if (firstName != null) {
      data['firstName'] = firstName;
    }
    if (lastName != null) {
      data['lastName'] = lastName;
    }
    if (profilePic != null) {
      data['profilePic'] = profilePic;
    }
    if (role != null) {
      data['role'] = role;
    }
    return data;
  }
}
