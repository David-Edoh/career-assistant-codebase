class GetMeResp {
  String? status;
  String? message;
  Data? data;

  GetMeResp({this.status, this.message, this.data});

  GetMeResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (message != null) {
      data['message'] = message;
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? loginRetryLimit;
  String? username;
  String? accessToken;
  String? email;
  String? firstName;
  String? lastName;
  String? profilePic;
  String? coverPic;
  String? city;
  String? website;
  String? about;
  int? role;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? isActive;
  int? id;
  dynamic loginReactiveTime;
  int? userType;

  Data(
      {this.loginRetryLimit,
      this.username,
      this.accessToken,
      this.email,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.coverPic,
      this.role,
      this.city,
      this.website,
      this.about,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.isActive,
      this.loginReactiveTime,
      this.userType,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    loginRetryLimit = json['loginRetryLimit'];
    username = json['username'];
    accessToken = json['accessToken'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePic = json['profilePic'];
    coverPic = json['coverPic'];
    city = json['city'];
    website = json['website'];
    about = json['about'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    loginReactiveTime = json['loginReactiveTime'];
    userType = json['userType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (loginRetryLimit != null) {
      data['loginRetryLimit'] = loginRetryLimit;
    }
    if (username != null) {
      data['username'] = username;
    }
    if (accessToken != null) {
      data['accessToken'] = accessToken;
    }
    if (email != null) {
      data['email'] = email;
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
    if (city != null) {
      data['city'] = city;
    }
    if (about != null) {
      data['about'] = about;
    }
    if (website != null) {
      data['website'] = website;
    }
    if (role != null) {
      data['role'] = role;
    }
    if (createdAt != null) {
      data['createdAt'] = createdAt;
    }
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt;
    }
    if (isDeleted != null) {
      data['isDeleted'] = isDeleted;
    }
    if (isActive != null) {
      data['isActive'] = isActive;
    }
    if (id != null) {
      data['id'] = id;
    }
    if (loginReactiveTime != null) {
      data['loginReactiveTime'] = loginReactiveTime;
    }
    if (userType != null) {
      data['userType'] = userType;
    }
    return data;
  }
}
