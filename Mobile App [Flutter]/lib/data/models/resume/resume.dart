import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ResumeTemplatesResponse {
  ResumeTemplatesResponse copyWith() {
    return ResumeTemplatesResponse();
  }

  String? message;
  List<ResumeTemplate>? templates;

  ResumeTemplatesResponse({this.message, this.templates});

  ResumeTemplatesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['templates'] != null) {
      templates = List<ResumeTemplate>.from(
          json['templates'].map((subject) => ResumeTemplate.fromJson(subject)));
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (templates != null) {
      data['templates'] =
          templates!.map((template) => template.toJson()).toList();
    }

    return data;
  }
}

class ResumeTemplate {
  int? id;
  String? bodyHTML;
  String? experienceHTML;
  String? educationHTML;
  String? skillHTML;
  String? socialsHTML;
  String? projectsHTML;
  String? certificationsHTML;
  String? referencesHTML;
  String? experienceSection;
  String? educationSection;
  String? projectSection;
  String? certificationSection;
  String? referenceSection;
  String? skillsSection;
  String? websiteSection;
  String? profilePicSection;
  String? socialsSection;
  String? addressSection;
  String? phoneNumberSection;
  String? thumbnail;


  ResumeTemplate({this.id, this.bodyHTML, this.thumbnail});

  ResumeTemplate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bodyHTML = json['bodyHTML'];
    experienceHTML = json['experienceHTML'];
    educationHTML = json['educationHTML'];
    skillHTML = json['skillHTML'];
    socialsHTML = json['socialsHTML'];
    projectsHTML = json['projectsHTML'];
    certificationsHTML = json['certificationsHTML'];
    referencesHTML = json['referencesHTML'];
    experienceSection = json['experienceSection'];
    educationSection = json['educationSection'];
    projectSection = json['projectSection'];
    certificationSection = json['certificationSection'];
    referenceSection = json['referenceSection'];
    skillsSection = json['skillsSection'];
    websiteSection = json['websiteSection'];
    profilePicSection = json['profilePicSection'];
    socialsSection = json['socialsSection'];
    addressSection = json['addressSection'];
    phoneNumberSection = json['phoneNumberSection'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final template = <String, dynamic>{};
    template['id'] = id;
    template['thumbnail'] = thumbnail;
    template['bodyHTML'] = bodyHTML;
    template['experienceHTML'] = experienceHTML;
    template['educationHTML'] = educationHTML;
    template['skillHTML'] = skillHTML;
    template['socialsHTML'] = socialsHTML;
    template['projectsHTML'] = projectsHTML;
    template['certificationsHTML'] = certificationsHTML;
    template['referencesHTML'] = referencesHTML;
    template['experienceSection'] = experienceSection;
    template['educationSection'] = educationSection;
    template['referenceSection'] = referenceSection;
    template['skillsSection'] = skillsSection;
    template['websiteSection'] = websiteSection;
    template['profilePicSection'] = profilePicSection;
    template['socialsSection'] = socialsSection;
    template['projectSection'] = projectSection;
    template['certificationSection'] = certificationSection;
    template['addressSection'] = addressSection;
    template['phoneNumberSection'] = phoneNumberSection;
    return template;
  }
}

