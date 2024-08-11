// ignore_for_file: must_be_immutable

part of 'links_preview_bloc.dart';

/// Represents the state of CareerSubjects in the application.
class LinksPreviewState extends Equatable {
  LinksPreviewState({
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
  LinksPreviewState copyWith({
    TextEditingController? otpController,
    JobAdModel? careerSubjectsModelObj,
  }) {
    return LinksPreviewState(
      otpController: otpController ?? this.otpController,
      enterOtpModelObj: careerSubjectsModelObj ?? this.enterOtpModelObj,
    );
  }
}
