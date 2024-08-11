// ignore_for_file: must_be_immutable

part of 'personal_info_bloc.dart';

/// Represents the state of PersonalInfo in the application.
class PersonalInfoState extends Equatable {
  PersonalInfoState({
    this.firstNameController,
    this.lastNameController,
    this.emailController,
    this.phoneController,
    this.locationController,
    this.userPicture,
    this.picturePath,
    this.personalInfoModelObj,
  });

  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? locationController;
  PersonalInfoModel? personalInfoModelObj;
  String? userPicture;
  String? picturePath;

  @override
  List<Object?> get props => [
        firstNameController,
        lastNameController,
        emailController,
        phoneController,
        locationController,
        personalInfoModelObj,
        userPicture,
        picturePath,
      ];
  PersonalInfoState copyWith({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    TextEditingController? locationController,
    PersonalInfoModel? personalInfoModelObj,
    String? userPicture,
    String? picturePath,
  }) {
    return PersonalInfoState(
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      locationController: locationController ?? this.locationController,
      personalInfoModelObj: personalInfoModelObj ?? this.personalInfoModelObj,
      userPicture: userPicture ?? this.userPicture,
      picturePath: picturePath ?? this.picturePath,
    );
  }
}
