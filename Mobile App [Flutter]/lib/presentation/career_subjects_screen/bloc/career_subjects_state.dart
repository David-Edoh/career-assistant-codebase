// ignore_for_file: must_be_immutable

part of 'career_subjects_bloc.dart';

/// Represents the state of CareerSubjects in the application.
class CareerSubjectsState extends Equatable {
  CareerSubjectsState({
    this.otpController,
    this.enterOtpModelObj,
  });

  TextEditingController? otpController;

  JobAdModel? enterOtpModelObj;

  @override
  List<Object?> get props => [
        otpController,
        enterOtpModelObj,
      ];
  CareerSubjectsState copyWith({
    TextEditingController? otpController,
    JobAdModel? careerSubjectsModelObj,
  }) {
    return CareerSubjectsState(
      otpController: otpController ?? this.otpController,
      enterOtpModelObj: careerSubjectsModelObj ?? this.enterOtpModelObj,
    );
  }
}
