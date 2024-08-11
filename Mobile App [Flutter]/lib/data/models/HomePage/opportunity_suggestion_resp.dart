import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'careeer_content_link.dart';

class SuggestedOpportunitiesResponse {
  SuggestedOpportunitiesResponse copyWith() {
    return SuggestedOpportunitiesResponse();
  }

  String? message;
  List<SuggestedOpportunity>? opportunities;
  User? user;

  SuggestedOpportunitiesResponse({this.message, this.opportunities, this.user});

  SuggestedOpportunitiesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['opportunities'] != null) {
      opportunities = List<SuggestedOpportunity>.from(
          json['opportunities'].map((opportunity) => SuggestedOpportunity.fromJson(opportunity)));
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (opportunities != null) {
      data['opportunities'] =
          opportunities!.map((opportunity) => opportunity.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class SuggestedOpportunity {
  String? opportunity;
  String? description;
  List<Link>? links;
  int? userId;

  SuggestedOpportunity({this.opportunity, this.links, this.userId, this.description});

  SuggestedOpportunity.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? "";
    opportunity = json['opportunity'];
    if (json['links'] != null) {
      links = List<Link>.from(
          json['links'].map((link) => Link.fromJson(link)));
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final opportunityData = <String, dynamic>{};
    opportunityData['opportunity'] = opportunity;
    if (links != null) {
      opportunityData['links'] =
          links!.map((link) => link.toJson()).toList();
    }
    opportunityData['userId'] = userId;
    return opportunityData;
  }
}


class User {
  int? id;
  String? username;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? picturePath;
  String? gender;
  String? birthday;
  String? country;
  String? employmentStatus;
  String? educationLevel;
  String? specialization;
  String? careerGoal;
  String? keyStrength;
  String? socketIoId;
  String? refreshToken;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.picturePath,
    this.gender,
    this.birthday,
    this.country,
    this.employmentStatus,
    this.educationLevel,
    this.specialization,
    this.careerGoal,
    this.keyStrength,
    this.socketIoId,
    this.refreshToken,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picturePath = json['picturePath'];
    gender = json['gender'];
    birthday = json['birthday'];
    country = json['country'];
    employmentStatus = json['employmentStatus'];
    educationLevel = json['educationLevel'];
    specialization = json['specialization'];
    careerGoal = json['careerGoal'];
    keyStrength = json['keyStrength'];
    socketIoId = json['socket_io_id'];
    refreshToken = json['refreshToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['id'] = id;
    userData['username'] = username;
    userData['email'] = email;
    userData['password'] = password;
    userData['firstName'] = firstName;
    userData['lastName'] = lastName;
    userData['picturePath'] = picturePath;
    userData['gender'] = gender;
    userData['birthday'] = birthday;
    userData['country'] = country;
    userData['employmentStatus'] = employmentStatus;
    userData['educationLevel'] = educationLevel;
    userData['specialization'] = specialization;
    userData['careerGoal'] = careerGoal;
    userData['keyStrength'] = keyStrength;
    userData['socket_io_id'] = socketIoId;
    userData['refreshToken'] = refreshToken;
    userData['createdAt'] = createdAt;
    userData['updatedAt'] = updatedAt;
    return userData;
  }
}
