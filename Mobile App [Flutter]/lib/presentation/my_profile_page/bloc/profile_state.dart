// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

/// Represents the state of Profile in the application.
class ProfileState extends Equatable {
  ProfileState({
    this.opentowork = false,
    this.profileModelObj,
    this.firstName,
    this.lastName,
    this.careerTitle,
    this.email,
    this.phone,
    this.location,
    this.aboutMe,
    this.skills,
    this.experiences,
    this.educations,
    this.website,
    this.projects,
    this.references,
    this.socials,
    this.userPicture,
    this.picturePath,
    this.fetchingCareerDetailsDone = false,
  });

  ProfileModel? profileModelObj;
  bool opentowork;
  String? firstName;
  String? careerTitle;
  String? lastName;
  String? email;
  String? phone;
  String? website;
  String? location;
  String? aboutMe;
  List<Experience>? experiences;
  List<Education>? educations;
  List<Project>? projects;
  List<Reference>? references;
  List<Social>? socials;
  List<String>? skills = <String>[];
  String? userPicture;
  String? picturePath;
  bool? fetchingCareerDetailsDone;

  @override
  List<Object?> get props => [
        opentowork,
        profileModelObj,
        firstName,
        lastName,
        careerTitle,
        email,
        phone,
        location,
        aboutMe,
        skills,
        educations,
        experiences,
        references,
        socials,
        projects,
        website,
        userPicture,
        picturePath,
        fetchingCareerDetailsDone,
      ];
  ProfileState copyWith({
    bool? opentowork,
    ProfileModel? profileModelObj,
    String? firstName,
    String? lastName,
    String? careerTitle,
    String? email,
    String? phone,
    String? website,
    String? location,
    String? aboutMe,
    List<Education>? educations,
    List<Experience>? experiences,
    List<Reference>? references,
    List<Project>? projects,
    List<Social>? socials,
    List<String>? skills,
    String? userPicture,
    String? picturePath,
    bool? fetchingCareerDetailsDone,
  }) {
    return ProfileState(
      opentowork: opentowork ?? this.opentowork,
      profileModelObj: profileModelObj ?? this.profileModelObj,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      location: location ?? this.location,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      references: references ?? this.references,
      projects: projects ?? this.projects,
      socials: socials ?? this.socials,
      skills: skills ?? this.skills,
      userPicture: userPicture ?? this.userPicture,
      picturePath: picturePath ?? this.picturePath,
      aboutMe: aboutMe ?? this.aboutMe,
      fetchingCareerDetailsDone: fetchingCareerDetailsDone ?? this.fetchingCareerDetailsDone,
      careerTitle : careerTitle ?? this.careerTitle,
    );
  }
}
