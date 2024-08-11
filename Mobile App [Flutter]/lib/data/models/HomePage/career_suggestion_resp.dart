// import 'package:fotisia/data/models/HomePage/subject_suggestion_resp.dart';

import 'package:fotisia/data/models/HomePage/subject_suggestion_resp.dart';

class CareerSuggestionResponseObject {
  CareerSuggestionResponseObject copyWith() {
    return CareerSuggestionResponseObject();
  }

  String message;
  List<CareerToChooseFrom>? careersToChooseFrom;
  User? user;

  CareerSuggestionResponseObject({
    this.message = "",
    this.careersToChooseFrom,
    this.user,
  });

  CareerSuggestionResponseObject.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        careersToChooseFrom = (json['careersToChooseFrom'] as List)
            .map((careerJson) => CareerToChooseFrom.fromJson(careerJson))
            .toList(),
        user = User.fromJson(json['user']);
}

class CareerToChooseFrom {
  int id;
  String career;
  String description;
  String salary;
  int userId;
  Roadmap roadmap;


  CareerToChooseFrom({
    required this.id,
    required this.career,
    required this.description,
    required this.salary,
    required this.userId,
    required this.roadmap,
  });

  CareerToChooseFrom.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        career = json['career'],
        description = json['description'],
        salary = json['salary'],
        userId = json['userId'],
        roadmap = Roadmap.fromJson(json['roadmap']);
}

class Roadmap {
  int id;
  int userId;
  String description;
  List<SuggestedSubject> careerSubjects;
  List<SuggestedCertification> suggestedcertifications;
  List<SuggestedProject> suggestedprojects;

  Roadmap({
    required this.id,
    required this.userId,
    required this.description,
    required this.careerSubjects,
    required this.suggestedcertifications,
    required this.suggestedprojects,
  });

  Roadmap.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        description = json['description'],
        careerSubjects = (json['careersubjects'] as List)
            .map((subjectJson) => SuggestedSubject.fromJson(subjectJson))
            .toList(),
        suggestedcertifications = (json['suggestedcertifications'] as List)
            .map((certJson) => SuggestedCertification.fromJson(certJson))
            .toList(),
        suggestedprojects = (json['suggestedprojects'] as List)
            .map((projectJson) => SuggestedProject.fromJson(projectJson))
            .toList();
}

class SuggestedCertification {
  String certificationName;
  String level;
  String url;

  SuggestedCertification({
    required this.certificationName,
    required this.level,
    required this.url,
  });

  SuggestedCertification.fromJson(Map<String, dynamic> json)
      : certificationName = json['name'],
        level = json['level'],
        url = json['url'];
}

class SuggestedProject {
  String name;
  String level;
  String problem;
  String solutionIdea;

  SuggestedProject({
    required this.name,
    required this.level,
    required this.problem,
    required this.solutionIdea,
  });

  SuggestedProject.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        level = json['level'],
        problem = json['problem'],
        solutionIdea = json['solution'];
}

class User {
  int id;
  String username;
  String email;
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
  String? refreshToken;
  String? createdAt;
  String? updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.picturePath,
    this.gender,
    this.birthday,
    this.country,
    this.employmentStatus,
    this.educationLevel,
    this.specialization,
    this.careerGoal,
    this.keyStrength,
    this.refreshToken,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        picturePath = json['picturePath'],
        gender = json['gender'],
        birthday = json['birthday'],
        country = json['country'],
        employmentStatus = json['employmentStatus'],
        educationLevel = json['educationLevel'],
        specialization = json['specialization'],
        careerGoal = json['careerGoal'],
        keyStrength = json['keyStrength'],
        refreshToken = json['refreshToken'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
