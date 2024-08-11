// ignore_for_file: must_be_immutable

part of 'collect_user_basic_info_bloc.dart';

/// Represents the state of ResumeEdit in the application.
class CollectBasicUserInfoState extends Equatable {
  CollectBasicUserInfoState({
    this.collectBasicUserInfoModelObj,
    this.firstNameController,
    this.lastNameController,
    this.preferredDesignationController,
    this.emailController,
    this.phoneController,
    this.locationController,
    this.aboutMeController,
    this.hobbies,
    required this.hobbiesController,
    this.experiences,
    this.educations,
    this.websiteController,
    this.projects,
    this.references,
    this.socials,
    this.userPicture,
    this.picturePath,
    this.disabilityController,
    this.uploadedResume,
  });

  CollectBasicUserInfoModel? collectBasicUserInfoModelObj;
  TextEditingController? firstNameController;
  TextEditingController? disabilityController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? websiteController;
  TextEditingController? locationController;
  TextEditingController? aboutMeController;
  TextfieldTagsController hobbiesController;
  TextEditingController? preferredDesignationController;
  List<Experience>? experiences;
  List<Education>? educations;
  List<Project>? projects;
  List<Reference>? references;
  List<Social>? socials;
  List<String>? hobbies = <String>[];
  String? userPicture;
  String? picturePath;
  String? uploadedResume;

  @override
  List<Object?> get props => [
        collectBasicUserInfoModelObj,
        firstNameController,
        lastNameController,
    disabilityController,
    preferredDesignationController,
        emailController,
        phoneController,
        locationController,
        aboutMeController,
        hobbiesController,
        hobbies,
        educations,
        experiences,
        references,
        socials,
        projects,
        websiteController,
        userPicture,
        picturePath,
    uploadedResume,
      ];



  CollectBasicUserInfoState copyWith(
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
        TextEditingController? disabilityController,
        TextEditingController? preferredDesignationController,
        List<Education>? educations,
        List<Experience>? experiences,
        List<Reference>? references,
        List<Project>? projects,
        List<Social>? socials,
        List<String>? hobbies,
        String? userPicture,
        String? picturePath,
        String? uploadedResume,
      }) {
    return CollectBasicUserInfoState(
      collectBasicUserInfoModelObj:
      resumeEditModelObj ?? this.collectBasicUserInfoModelObj,
      firstNameController: firstNameController ?? this.firstNameController,
      uploadedResume: uploadedResume ?? this.uploadedResume,
      lastNameController: lastNameController ?? this.lastNameController,
      preferredDesignationController: preferredDesignationController ?? this.preferredDesignationController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      websiteController: websiteController ?? this.websiteController,
      locationController: locationController ?? this.locationController,
      hobbiesController: skillsController ?? this.hobbiesController,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      references: references ?? this.references,
      projects: projects ?? this.projects,
      socials: socials ?? this.socials,
      hobbies: hobbies ?? this.hobbies,
      userPicture: userPicture ?? this.userPicture,
      picturePath: picturePath ?? this.picturePath,
      aboutMeController: aboutMeController ?? this.aboutMeController,
      disabilityController: disabilityController ?? this.disabilityController,
    );
  }
}
