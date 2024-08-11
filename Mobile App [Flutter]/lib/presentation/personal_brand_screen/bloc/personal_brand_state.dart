// ignore_for_file: must_be_immutable

part of 'personal_brand_bloc.dart';

/// Represents the state of PersonalBrand in the application.
class PersonalBrandState extends Equatable {
  PersonalBrandState({
    this.otpController,
    this.personalBrandModelObj,
  });

  TextEditingController? otpController;

  PersonalBrandModel? personalBrandModelObj;

  @override
  List<Object?> get props => [
        otpController,
        personalBrandModelObj,
      ];
  PersonalBrandState copyWith({
    TextEditingController? otpController,
    PersonalBrandModel? careerSubjectsModelObj,
  }) {
    return PersonalBrandState(
      otpController: otpController ?? this.otpController,
      personalBrandModelObj: careerSubjectsModelObj ?? this.personalBrandModelObj,
    );
  }
}
