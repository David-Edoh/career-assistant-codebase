
class UserResumeResponseObject {

  UserResumeResponseObject copyWith() {
    return UserResumeResponseObject();
  }

  String message;
  UserResumeDetails? userResumeDetails;

  UserResumeResponseObject({
    this.message = "",
    this.userResumeDetails,
  });

  UserResumeResponseObject.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        userResumeDetails = json['userResumeDetails'];
}


class UserResumeDetails {

  UserResumeDetails copyWith() {
    return UserResumeDetails();
  }

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  // String? preferredDesignation;
  String? userPicture;
  String? picturePath;
  String? about;
  String? address;
  String? website;
  String? phoneNumber;
  String? gender;
  String? birthday;
  String? country;
  String? employmentStatus;
  String? educationLevel;
  String? specialization;
  String? careerGoal;
  String? keyStrength;
  String? state;
  Relationship? relationship;
  List<Experience>? experiences = [];
  List<Education>? educations = [];
  List<String>? skills = [];
  List<Project>? projects = [];
  List<TrainingsCoursesCertifications>? trainings_courses_certifications = [];
  List<Reference>? references = [];
  List<Social>? socials = [];
  String? createdAt;
  String? updatedAt;

  UserResumeDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    // this.preferredDesignation,
    this.about,
    this.address,
    this.website,
    this.phoneNumber,
    this.userPicture,
    this.picturePath,
    this.gender,
    this.birthday,
    this.country,
    this.relationship,
    this.employmentStatus,
    this.educationLevel,
    this.specialization,
    this.careerGoal,
    this.keyStrength,
    this.experiences,
    this.educations,
    this.skills,
    this.projects,
    this.trainings_courses_certifications,
    this.references,
    this.socials,
    this.createdAt,
    this.updatedAt,
    this.state,
  });

  UserResumeDetails.fromJson(Map<String, dynamic> json)
      : id = int.parse((json['id'] ?? 0).toString()),
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        // preferredDesignation = json['preferredDesignation'] ?? "",
        address = json['address'] ?? "",
        about = json['about'] ?? "",
        website = json['website'] ?? "",
        phoneNumber = json['phoneNumber'] ?? "",
        userPicture = json['userPicture'] ?? "",
        picturePath = json['picturePath'] ?? "",
        gender = json['gender'] ?? "",
        birthday = json['birthday'],
        country = json['country'] ?? "",
        state = json['state'] ?? "Not Friends",
        relationship = json['relationship'] != null ? Relationship.fromJson(json['relationship']) : null,
        employmentStatus = json['employmentStatus'] ?? "",
        educationLevel = json['educationLevel'] ?? "",
        skills = ((json['skills'] ?? List.empty()) as List)
            .map((skill) => skill.toString())
            .toList(),
        specialization = json['specialization'] ?? "",
        careerGoal = json['careerGoal'] ?? "",
        keyStrength = json['keyStrength'] ?? "",
        experiences = ((json['experiences'] ?? List.empty()) as List)
            .map((experience) => Experience.fromJson(experience))
            .toList(),
        educations = ((json['educations'] ?? List.empty()) as List)
            .map((education) => Education.fromJson(education))
            .toList(),
        projects = ((json['projects'] ?? List.empty()) as List)
            .map((project) => Project.fromJson(project))
            .toList(),
        trainings_courses_certifications = ((json['trainings_courses_certifications'] ?? List.empty()) as List)
            .map((item) => TrainingsCoursesCertifications.fromJson(item))
            .toList(),
        references = ((json['references'] ?? List.empty()) as List)
            .map((reference) => Reference.fromJson(reference))
            .toList(),
        socials = ((json['socials'] ?? List.empty()) as List)
            .map((social) => Social.fromJson(social))
            .toList(),
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      // 'preferredDesignation': preferredDesignation,
      'about': about,
      'address': address,
      'website': website,
      'phoneNumber': phoneNumber,
      'userPicture': userPicture,
      'picturePath': picturePath,
      'gender': gender,
      'state': state,
      'birthday': birthday,
      'country': country,
      'employmentStatus': employmentStatus,
      'educationLevel': educationLevel,
      'specialization': specialization,
      'careerGoal': careerGoal,
      'keyStrength': keyStrength,
      'relationship': relationship?.toJson(),
      'experiences': experiences?.map((experience) => experience.toJson()).toList(),
      'educations': educations?.map((education) => education.toJson()).toList(),
      'projects': projects?.map((project) => project.toJson()).toList(),
      'trainings_courses_certifications': trainings_courses_certifications?.map((item) => item.toJson()).toList(),
      'references': references?.map((reference) => reference.toJson()).toList(),
      'socials': socials?.map((social) => social.toJson()).toList(),
      'skills': skills,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Experience {
  int? id;
  String? company;
  String? address;
  String? position;
  String? description;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  bool? currentlyWorkHere;


  Experience({
    this.id,
    this.company,
    this.address,
    this.position,
    this.description,
    this.startDate,
    this.endDate,
    this.currentlyWorkHere,
    this.createdAt,
    this.updatedAt,
  });


  Experience.fromJson(Map<String, dynamic> json)
      : id = int.parse((json['id'] ?? 0).toString()),
      company = json['company'] ?? "",
      address = json['address'] ?? "",
      position = json['position'] ?? "",
      description = json['description'] ?? "",
      startDate = json['startDate'] ?? "",
      endDate = json['endDate'] ?? "",
      currentlyWorkHere = bool.tryParse(json['currentlyWorkHere'].toString()) ?? false,
      createdAt = json['createdAt'],
      updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'company': company,
      'address': address,
      'position': position,
      'description': description,
      'currentlyWorkHere': currentlyWorkHere,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

}

class Education {
  int? id;
  String? school;
  String? schoolAddress;
  String? discipline;
  String? description;
  String? level;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  bool? currentlySchoolHere;


  Education({
    this.id,
    this.school,
    this.schoolAddress,
    this.discipline,
    this.level,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.currentlySchoolHere
  });

  Education.fromJson(Map<String, dynamic> json)
      : id = int.parse((json['id'] ?? 0).toString()),
      school = json['school'] ?? "",
      schoolAddress = json['schoolAddress'] ?? "",
      discipline = json['discipline'] ?? "",
      description = json['description'] ?? "",
      level = json['level'] ?? "",
      startDate = json['startDate'] ?? "",
      endDate = json['endDate'] ?? "",
      currentlySchoolHere = bool.tryParse(json['currentlySchoolHere'].toString()) ?? false,
      createdAt = json['createdAt'],
      updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'school': school,
      'schoolAddress': schoolAddress,
      'discipline': discipline,
      'description': description,
      'level': level,
      'currentlySchoolHere': currentlySchoolHere,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}


class Project {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;


  Project({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,

  });

  Project.fromJson(Map<String, dynamic> json)
      : id = int.parse((json['id'] ?? 0).toString()),
        title = json['title'] ?? "",
        description = json['description'] ?? "",
        startDate = json['startDate'] ?? "",
        endDate = json['endDate'] ?? "",
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class TrainingsCoursesCertifications {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;


  TrainingsCoursesCertifications({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,

  });

  TrainingsCoursesCertifications.fromJson(Map<String, dynamic> json)
      : id = int.parse((json['id'] ?? 0).toString()),
        title = json['title'] ?? "",
        description = json['description'] ?? "",
        startDate = json['startDate'] ?? "",
        endDate = json['endDate'] ?? "",
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Reference {
  int? id;
  String? name;
  String? company;
  String? position;
  String? phoneNumber;
  String? address;
  String? email;
  String? description;
  String? createdAt;
  String? updatedAt;


  Reference({
    this.id,
    this.name,
    this.company,
    this.position,
    this.phoneNumber,
    this.address,
    this.email,
    this.description,
    this.createdAt,
    this.updatedAt,

  });

  Reference.fromJson(Map<String, dynamic> json)
      : id = int.parse((json['id'] ?? 0).toString()),
        name = json['name'] ?? "",
        company = json['company'] ?? "",
        position = json['position'] ?? "",
        phoneNumber = json['phoneNumber'] ?? "",
        address = json['address'] ?? "",
        email = json['email'] ?? "",
        description = json['description'] ?? "",
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'name': name,
      'company': company,
      'position': position,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}


class Social {
  int? id;
  String? name;
  String? url;
  String? username;
  String? createdAt;
  String? updatedAt;


  Social({
    this.id,
    this.name,
    this.url,
    this.username,
    this.createdAt,
    this.updatedAt,

  });

  Social.fromJson(Map<String, dynamic> json)
      : id = int.parse((json['id'] ?? 0).toString()),
        name = json['name'] ?? "",
        url = json['url'] ?? "",
        username = json['username'] ?? "",
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'name': name,
      'url': url,
      'username': username,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Relationship {
  int? id;
  int? firstUserId;
  int? secondUserId;
  String? state;
  String? createdAt;
  String? updatedAt;

  Relationship({
    this.id,
    this.firstUserId,
    this.secondUserId,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  Relationship.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstUserId = json['firstUserId'];
    secondUserId = json['secondUserId'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstUserId'] = firstUserId;
    data['secondUserId'] = secondUserId;
    data['state'] = state;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}