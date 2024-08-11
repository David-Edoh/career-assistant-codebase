// ignore_for_file: must_be_immutable

part of 'new_social_link_bloc.dart';

/// Represents the state of NewProject in the application.
class NewSocialLinkState extends Equatable {
  NewSocialLinkState({
    this.socialNameController,
    this.socialLinkController,
    this.socialUsernameController,
    this.screenTitle = "",
    this.newSocialLinkModelObj,
  });

  TextEditingController? socialNameController;
  TextEditingController? socialLinkController;
  TextEditingController? socialUsernameController;
  NewSocialLinkModel? newSocialLinkModelObj;
  String? screenTitle;

  @override
  List<Object?> get props => [
        socialNameController,
        socialLinkController,
        screenTitle,
        newSocialLinkModelObj,
        socialUsernameController,
      ];
  NewSocialLinkState copyWith({
    TextEditingController? socialNameController,
    TextEditingController? socialLinkController,
    TextEditingController? socialUsernameController,
    NewSocialLinkModel? newSocialLinkModelObj,
    String? screenTitle,
  }) {
    return NewSocialLinkState(
      socialNameController: socialNameController ?? this.socialNameController,
      socialLinkController: socialLinkController ?? this.socialLinkController,
      socialUsernameController: socialUsernameController ?? this.socialUsernameController,
      newSocialLinkModelObj: newSocialLinkModelObj ?? this.newSocialLinkModelObj,
      screenTitle: screenTitle ?? this.screenTitle,
    );
  }
}
