// ignore_for_file: must_be_immutable

part of 'experience_setting_bloc.dart';

/// Represents the state of ExperienceSetting in the application.
class ExperienceSettingState extends Equatable {
  ExperienceSettingState({
    this.experienceSettingModelObj,
    // this.firstNameController,
    // this.lastNameController,
    // this.emailController,
    this.preferredDesignationController,
    this.phoneController,
    this.locationController,
    this.aboutMeController,
    this.skills,
    required this.skillsController,
    this.experiences,
    this.educations,
    this.websiteController,
    this.projects,
    this.references,
    this.socials,
    this.userPicture,
    // this.picturePath,
  });

  ExperienceSettingModel? experienceSettingModelObj;
  // TextEditingController? firstNameController;
  // TextEditingController? lastNameController;
  // TextEditingController? emailController;
  TextEditingController? preferredDesignationController;
  TextEditingController? phoneController;
  TextEditingController? websiteController;
  TextEditingController? locationController;
  TextEditingController? aboutMeController;
  TextfieldTagsController skillsController;
  List<Experience>? experiences;
  List<Education>? educations;
  List<Project>? projects;
  List<Reference>? references;
  List<Social>? socials;
  List<String>? skills = <String>[];
  String? userPicture;
  // String? picturePath;

  @override
  List<Object?> get props => [
        experienceSettingModelObj,
        // firstNameController,
        // lastNameController,
        // emailController,
    preferredDesignationController,
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
        websiteController,
        userPicture,
        // picturePath,
      ];
  ExperienceSettingState copyWith(
      {
        ExperienceSettingModel? experienceSettingModelObj,
        TextEditingController? firstNameController,
        TextEditingController? lastNameController,
        TextEditingController? emailController,
        TextEditingController? preferredDesignationController,
        TextEditingController? phoneController,
        TextEditingController? websiteController,
        TextEditingController? locationController,
        TextEditingController? aboutMeController,
        TextfieldTagsController? skillsController,
        List<Education>? educations,
        List<Experience>? experiences,
        List<Reference>? references,
        List<Project>? projects,
        List<Social>? socials,
        List<String>? skills,
        String? userPicture,
        String? picturePath,
      }) {
    return ExperienceSettingState(
      experienceSettingModelObj:
          experienceSettingModelObj ?? this.experienceSettingModelObj,
      // firstNameController: firstNameController ?? this.firstNameController,
      // lastNameController: lastNameController ?? this.lastNameController,
      // emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      preferredDesignationController: preferredDesignationController ?? this.preferredDesignationController,
      websiteController: websiteController ?? this.websiteController,
      locationController: locationController ?? this.locationController,
      skillsController: skillsController ?? this.skillsController,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      references: references ?? this.references,
      projects: projects ?? this.projects,
      socials: socials ?? this.socials,
      skills: skills ?? this.skills,
      userPicture: userPicture ?? this.userPicture,
      // picturePath: picturePath ?? this.picturePath,
      aboutMeController: aboutMeController ?? this.aboutMeController,
    );
  }
}
