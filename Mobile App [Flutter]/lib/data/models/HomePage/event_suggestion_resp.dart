import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'careeer_content_link.dart';

class SuggestedEventsResponse {
  SuggestedEventsResponse copyWith() {
    return SuggestedEventsResponse();
  }

  String? message;
  List<SuggestedEvent>? events;
  User? user;

  SuggestedEventsResponse({this.message, this.events, this.user});

  SuggestedEventsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['events'] != null) {
      events = List<SuggestedEvent>.from(
          json['events'].map((event) => SuggestedEvent.fromJson(event)));
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (events != null) {
      data['events'] =
          events!.map((event) => event.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class SuggestedEvent {
  String? eventName;
  String? description;
  List<Link>? links;
  int? userId;

  SuggestedEvent({this.eventName, this.links, this.userId, this.description});

  SuggestedEvent.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? "";
    eventName = json['eventName'];
    if (json['links'] != null) {
      links = List<Link>.from(
          json['links'].map((link) => Link.fromJson(link)));
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final eventData = <String, dynamic>{};
    eventData['event'] = eventName;
    if (links != null) {
      eventData['links'] =
          links!.map((link) => link.toJson()).toList();
    }
    eventData['userId'] = userId;
    return eventData;
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
