import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SuggestedSubjectsResponse {
  SuggestedSubjectsResponse copyWith() {
    return SuggestedSubjectsResponse();
  }

  String? message;
  List<SuggestedSubject>? suggestedSubjects;
  User? user;

  SuggestedSubjectsResponse({this.message, this.suggestedSubjects, this.user});

  SuggestedSubjectsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['suggestedSubjects'] != null) {
      suggestedSubjects = List<SuggestedSubject>.from(
          json['suggestedSubjects'].map((subject) => SuggestedSubject.fromJson(subject)));
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (suggestedSubjects != null) {
      data['suggestedSubjects'] =
          suggestedSubjects!.map((subject) => subject.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class SuggestedSubject {
  int? id;
  String? subject;
  String? description;
  String? learningDuration;
  String? level;
  List<CareerContent>? careerContents;
  int? userId;

  SuggestedSubject({this.subject, this.careerContents, this.userId, this.id, this.learningDuration, this.description, this.level});

  SuggestedSubject.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    learningDuration = json['learningDuration'];
    level = json['level'];
    subject = json['subject'];
    if (json['careercontents'] != null) {
      careerContents = List<CareerContent>.from(
          json['careercontents'].map((content) => CareerContent.fromJson(content)));
    }
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final subjectData = <String, dynamic>{};
    subjectData['subject'] = subject;
    if (careerContents != null) {
      subjectData['careercontents'] =
          careerContents!.map((content) => content.toJson()).toList();
    }
    subjectData['userId'] = userId;
    subjectData['id'] = id;
    return subjectData;
  }
}

class CareerContent {
  String? q;
  int? rating;
  String? title;
  String? description;
  String? platform;
  String? link;
  int? userId;
  double? price;
  String? imageUrl;

  CareerContent({this.q, this.rating, this.title, this.imageUrl, this.platform, this.link, this.userId, this.price, this.description});

  CareerContent.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    rating = json['rating'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    platform = json['platform'];
    link = json['link'];
    userId = json['userId'];
    description = json['description'];
    price = json['price'] != null ? double.parse(json['price'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final contentData = <String, dynamic>{};
    contentData['q'] = q;
    contentData['rating'] = rating;
    contentData['title'] = title;
    contentData['imageUrl'] = imageUrl;
    contentData['description'] = description;
    contentData['platform'] = platform;
    contentData['link'] = link;
    contentData['userId'] = userId;
    contentData['price'] = price;
    return contentData;
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
