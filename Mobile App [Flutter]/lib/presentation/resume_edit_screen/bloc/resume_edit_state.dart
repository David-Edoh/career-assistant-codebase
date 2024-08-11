// ignore_for_file: must_be_immutable

part of 'resume_edit_bloc.dart';

/// Represents the state of ResumeEdit in the application.
class ResumeEditState extends Equatable {
  ResumeEditState({
    this.resumeEditModelObj,
    this.firstNameController,
    this.lastNameController,
    this.preferredDesignationController,
    this.emailController,
    this.phoneController,
    this.locationController,
    this.aboutMeController,
    this.skills,
    required this.skillsController,
    this.experiences,
    this.educations,
    this.websiteController,
    this.projects,
    this.certifications,
    this.references,
    this.socials,
    this.userPicture,
    this.picturePath,
  });

  CollectBasicUserInfoModel? resumeEditModelObj;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? websiteController;
  TextEditingController? locationController;
  TextEditingController? aboutMeController;
  TextfieldTagsController skillsController;
  TextEditingController? preferredDesignationController;
  List<Experience>? experiences;
  List<Education>? educations;
  List<Project>? projects;
  List<TrainingsCoursesCertifications>? certifications;
  List<Reference>? references;
  List<Social>? socials;
  List<String>? skills = <String>[];
  String? userPicture;
  String? picturePath;

  @override
  List<Object?> get props => [
        resumeEditModelObj,
        firstNameController,
        lastNameController,
        preferredDesignationController,
        emailController,
        phoneController,
        locationController,
        aboutMeController,
        skillsController,
        skills,
        educations,
        experiences,
        references,
        socials,
        projects,
        certifications,
        websiteController,
        userPicture,
        picturePath,
      ];



  ResumeEditState copyWith(
      {
        CollectBasicUserInfoModel? resumeEditModelObj,
        TextEditingController? firstNameController,
        TextEditingController? lastNameController,
        TextEditingController? emailController,
        TextEditingController? phoneController,
        TextEditingController? websiteController,
        TextEditingController? locationController,
        TextEditingController? aboutMeController,
        TextfieldTagsController? skillsController,
        TextEditingController? preferredDesignationController,
        List<Education>? educations,
        List<Experience>? experiences,
        List<Reference>? references,
        List<Project>? projects,
        List<TrainingsCoursesCertifications>? certifications,
        List<Social>? socials,
        List<String>? skills,
        String? userPicture,
        String? picturePath,
      }) {
    return ResumeEditState(
      resumeEditModelObj:
      resumeEditModelObj ?? this.resumeEditModelObj,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      preferredDesignationController: preferredDesignationController ?? this.preferredDesignationController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      websiteController: websiteController ?? this.websiteController,
      locationController: locationController ?? this.locationController,
      skillsController: skillsController ?? this.skillsController,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      references: references ?? this.references,
      projects: projects ?? this.projects,
      certifications: certifications ?? this.certifications,
      socials: socials ?? this.socials,
      skills: skills ?? this.skills,
      userPicture: userPicture ?? this.userPicture,
      picturePath: picturePath ?? this.picturePath,
      aboutMeController: aboutMeController ?? this.aboutMeController,
    );
  }
}
