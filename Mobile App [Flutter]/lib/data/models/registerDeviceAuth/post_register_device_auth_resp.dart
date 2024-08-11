import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostRegisterDeviceAuthResp {
  String? status;
  String? message;
  User? user;

  PostRegisterDeviceAuthResp({this.status, this.message, this.user});

  PostRegisterDeviceAuthResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (message != null) {
      data['message'] = message;
    }
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    return data;
  }

  PostRegisterDeviceAuthResp.saveToSecureStorage(Map<String, dynamic> json){
    const storage = FlutterSecureStorage();
    storage.write(key: "userData", value: _convertToJsonStringQuotes(raw: json['user'].toString()));
  }

  String _convertToJsonStringQuotes({required String raw}) {
    String jsonString = raw;

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(': ', '": "');
    jsonString = jsonString.replaceAll(', ', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }
}

class User {
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

  User(
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
      this.id});

  User.fromJson(Map<String, dynamic> json) {
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
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final user = <String, dynamic>{};
    if (loginRetryLimit != null) {
      user['loginRetryLimit'] = loginRetryLimit;
    }
    if (username != null) {
      user['username'] = username;
    }
    if (accessToken != null) {
      user['accessToken'] = accessToken;
    }
    if (email != null) {
      user['email'] = email;
    }
    if (firstName != null) {
      user['firstName'] = firstName;
    }
    if (lastName != null) {
      user['lastName'] = lastName;
    }
    if (profilePic != null) {
      user['profilePic'] = profilePic;
    }
    if (city != null) {
      user['city'] = city;
    }
    if (about != null) {
      user['about'] = about;
    }
    if (website != null) {
      user['website'] = website;
    }
    if (role != null) {
      user['role'] = role;
    }
    if (createdAt != null) {
      user['createdAt'] = createdAt;
    }
    if (updatedAt != null) {
      user['updatedAt'] = updatedAt;
    }
    if (isDeleted != null) {
      user['isDeleted'] = isDeleted;
    }
    if (isActive != null) {
      user['isActive'] = isActive;
    }
    if (id != null) {
      user['id'] = id;
    }
    return user;
  }
}
