import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostLoginAuthResp {
  String? status;
  String? message;
  User? user;

  PostLoginAuthResp({this.status, this.message, this.user});

  PostLoginAuthResp.fromJson(Map<String, dynamic> json) {
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

  PostLoginAuthResp.saveToSecureStorage(Map<String, dynamic> jsonData){
    const storage = FlutterSecureStorage();
    // json['user']['address'] = json['user']['address'].toString().replaceAll(",", "");
    storage.write(key: "userData", value: json.encode(jsonData['user']));
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
  // int? loginRetryLimit;
  String? username;
  String? accessToken;
  String? email;
  String? authType;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? disability;
  List<String>? hobbies = [];
  String? profilePic;
  String? coverPic;
  String? picturePath;
  String? employmentStatus;
  String? educationLevel;
  String? specialization;
  String? careerGoal;
  String? keyStrength;
  String? city;
  String? website;
  String? about;
  String? fcmToken;
  // int? role;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? isActive;
  int? id;

  User(
      {
        // this.loginRetryLimit,
      this.username,
      this.accessToken,
      this.email,
      this.fcmToken,
      this.authType,
      this.phoneNumber,
      this.address,
      this.disability,
      this.hobbies,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.picturePath,
      this.coverPic,
      // this.role,
      this.city,
      this.website,
      this.about,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.isActive,
      this.employmentStatus,
      this.educationLevel,
      this.specialization,
      this.careerGoal,
      this.keyStrength,
      this.id
      });

  User.fromJson(Map<String, dynamic> json) {
    // loginRetryLimit = int.parse(json['loginRetryLimit'].toString());
    username = json['username'];
    accessToken = json['accessToken'];
    email = json['email'];
    fcmToken = json['fcmToken'];
    authType = json['authType'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    disability = json['disability'];
    hobbies = ((json['hobbies'] ?? List.empty()) as List)
        .map((hobbies) => hobbies.toString())
        .toList();
    profilePic = json['profilePic'];
    picturePath = json['picturePath'];
    coverPic = json['coverPic'];
    city = json['city'];
    website = json['website'];
    about = json['about'];
    // role = int.parse(json['role'].toString());
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    employmentStatus = json['employmentStatus'];
    educationLevel = json['educationLevel'];
    specialization = json['specialization'];
    careerGoal = json['careerGoal'];
    keyStrength = json['keyStrength'];
    id = int.parse(json['id'].toString());
  }

  Map<String, dynamic> toJson() {
    final user = <String, dynamic>{};
    // if (loginRetryLimit != null) {
    //   user['loginRetryLimit'] = loginRetryLimit;
    // }
    if (username != null) {
      user['username'] = username;
    }
    if (phoneNumber != null) {
      user['phoneNumber'] = phoneNumber;
    }
    if (address != null) {
      user['address'] = address;
    }
    if (disability != null) {
      user['disability'] = disability;
    }
    if (hobbies != null) {
      user['hobbies'] = hobbies;
    }
    if (employmentStatus != null) {
      user['employmentStatus'] = employmentStatus;
    }
    if (educationLevel != null) {
      user['educationLevel'] = educationLevel;
    }
    if (specialization != null) {
      user['specialization'] = specialization;
    }
    if (careerGoal != null) {
      user['careerGoal'] = careerGoal;
    }
    if (keyStrength != null) {
      user['keyStrength'] = keyStrength;
    }
    if (accessToken != null) {
      user['accessToken'] = accessToken;
    }
    if (email != null) {
      user['email'] = email;
    }
    if(authType != null){
      user['authType'] = authType;
    }
    if (firstName != null) {
      user['firstName'] = firstName;
    }
    if (lastName != null) {
      user['lastName'] = lastName;
    }
    if (fcmToken != null) {
      user['fcmToken'] = fcmToken;
    }
    if (profilePic != null) {
      user['profilePic'] = profilePic;
    }
    if (picturePath != null) {
      user['picturePath'] = picturePath;
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
    // if (role != null) {
    //   user['role'] = role;
    // }
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
