import 'package:fotisia/data/models/HomePage/career_suggestion_resp.dart';
import 'package:fotisia/data/models/HomePage/subject_suggestion_resp.dart';

class CareerRoadmapResponseObject {

  CareerRoadmapResponseObject copyWith() {
    return CareerRoadmapResponseObject();
  }

  String message;
  CareerToChooseFrom? careerRoadmap;
  User? user;

  CareerRoadmapResponseObject({
     this.message = "",
     this.careerRoadmap,
     this.user,
  });

  CareerRoadmapResponseObject.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        careerRoadmap = json['careerRoadmap'] != null ? CareerToChooseFrom.fromJson(json['careerRoadmap']) : null,
        user = User.fromJson(json['user']);
}

class CareerRoadmap {
  int id;
  bool standAlone;
  String career;
  String description;
  String salary;
  int userId;
  Roadmap roadmap;

  CareerRoadmap({
    required this.id,
    required this.career,
    required this.description,
    required this.salary,
    required this.userId,
    required this.roadmap,
    required this.standAlone,
  });

  CareerRoadmap.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        career = json['career'],
        standAlone = json['standAlone'],
        description = json['description'],
        salary = json['salary'],
        userId = json['userId'],
        roadmap = Roadmap.fromJson(json['roadmap']);
}

class Roadmap {
  int userId;
  String description;
  List<SuggestedSubject> careerSubjects;

  Roadmap({
    required this.userId,
    required this.description,
    required this.careerSubjects,
  });

  Roadmap.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        description = json['description'],
        careerSubjects = (json['careersubjects'] as List)
            .map((subjectJson) => SuggestedSubject.fromJson(subjectJson))
            .toList();
}

class CareerSubject {
  String subject;
  String level;
  String learningDuration;
  String description;
  List<CareerContent> careerContents;

  CareerSubject({
    required this.subject,
    required this.level,
    required this.learningDuration,
    required this.description,
    required this.careerContents,
  });

  CareerSubject.fromJson(Map<String, dynamic> json)
      : subject = json['subject'],
        level = json['level'],
        learningDuration = json['learningDuration'],
        description = json['description'],
        careerContents = (json['careercontents'] as List)
            .map((contentJson) => CareerContent.fromJson(contentJson))
            .toList();
}

class CareerContent {
  String? q;
  int? rating;
  String? title;
  String? imageUrl;
  double? price;
  String? source;
  String link;
  int userId;
  String? description;
  String? platform;

  CareerContent({
    this.q,
    this.rating,
    this.title,
    this.price,
    this.imageUrl,
    this.source,
    required this.link,
    required this.userId,
    this.description,
    this.platform,
  });

  CareerContent.fromJson(Map<String, dynamic> json)
      : q = json['q'],
        rating = json['rating'],
        imageUrl = json['imageUrl'],
        title = json['title'],
        source = json['source'],
        link = json['link'],
        userId = json['userId'],
        description = json['description'],
        platform = json['platform'],
        price = json['price'] != null ? double.parse(json['price'].toString()) : null;
}

class User {
  int id;
  String username;
  String email;
  // String password;
  String firstName;
  String lastName;
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
    required this.id,
    required this.username,
    required this.email,
    // required this.password,
    required this.firstName,
    required this.lastName,
    this.picturePath,
    required this.gender,
    required this.birthday,
    required this.country,
    required this.employmentStatus,
    required this.educationLevel,
    required this.specialization,
    required this.careerGoal,
    required this.keyStrength,
    this.socketIoId,
    required this.refreshToken,
    required this.createdAt,
    required this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        // password = json['password'],
        firstName = json['firstName'] ?? "",
        lastName = json['lastName'] ?? "",
        picturePath = json['picturePath'],
        gender = json['gender'],
        birthday = json['birthday'],
        country = json['country'],
        employmentStatus = json['employmentStatus'],
        educationLevel = json['educationLevel'],
        specialization = json['specialization'],
        careerGoal = json['careerGoal'],
        keyStrength = json['keyStrength'],
        socketIoId = json['socket_io_id'],
        refreshToken = json['refreshToken'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
