// ignore_for_file: must_be_immutable

part of 'user_profile_bloc.dart';

/// Represents the state of Profile in the application.
class UserProfileState extends Equatable {
  UserProfileState({
    this.opentowork = false,
    this.profileModelObj,
    this.firstName,
    this.lastName,
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
    this.friendshipState,
    this.changingFriendshipStateDone = true,
    this.fetchingCareerDetailsDone = false,
    this.relationship,
    this.currentUserId,
  });

  ProfileModel? profileModelObj;
  bool opentowork;
  String? firstName;
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
  String? friendshipState;
  bool? changingFriendshipStateDone;
  bool? fetchingCareerDetailsDone;
  Relationship? relationship;
  int? currentUserId;

  @override
  List<Object?> get props => [
        opentowork,
        profileModelObj,
        firstName,
        lastName,
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
        friendshipState,
        changingFriendshipStateDone,
        fetchingCareerDetailsDone,
    relationship,
    currentUserId,
      ];
  UserProfileState copyWith({
    bool? opentowork,
    ProfileModel? profileModelObj,
    String? firstName,
    String? lastName,
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
    String? friendshipState,
    bool? changingFriendshipStateDone,
    bool? fetchingCareerDetailsDone,
    Relationship? relationship,
    int? currentUserId,
  }) {
    return UserProfileState(
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
      friendshipState: friendshipState ?? this.friendshipState,
      changingFriendshipStateDone: changingFriendshipStateDone ?? this.changingFriendshipStateDone,
      fetchingCareerDetailsDone: fetchingCareerDetailsDone ?? this.fetchingCareerDetailsDone,
      relationship: relationship ?? this.relationship,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }
}
