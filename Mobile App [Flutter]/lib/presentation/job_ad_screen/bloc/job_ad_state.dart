// ignore_for_file: must_be_immutable

part of 'job_ad_bloc.dart';

/// Represents the state of CareerSubjects in the application.
class JobAdState extends Equatable {
  JobAdState({
    this.otpController,
    this.enterOtpModelObj,
    this.qualificationScore,
    this.jobIsOpen,
    this.gettingQualificationScore,
    this.explanation,
    this.jobTitle,
    this.jobCompany,
  });

  TextEditingController? otpController;

  JobAdModel? enterOtpModelObj;

  int? qualificationScore;

  bool? gettingQualificationScore;

  String? explanation;

  String? jobTitle;

  String? jobCompany;

  bool? jobIsOpen;

  String? message;

  @override
  List<Object?> get props => [
    otpController,
    enterOtpModelObj,
    qualificationScore,
    jobIsOpen,
    gettingQualificationScore,
    explanation,
    jobTitle,
    jobCompany

      ];
  JobAdState copyWith({
    TextEditingController? otpController,
    JobAdModel? careerSubjectsModelObj,
    int? qualificationScore,
    bool? jobIsOpen,
    bool? gettingQualificationScore,
    String? explanation,
    String? jobTitle,
    String? jobCompany,
  }) {
    return JobAdState(
      otpController: otpController ?? this.otpController,
      enterOtpModelObj: careerSubjectsModelObj ?? this.enterOtpModelObj,
      qualificationScore: qualificationScore ?? this.qualificationScore,
      jobIsOpen: jobIsOpen ?? this.jobIsOpen,
      gettingQualificationScore: gettingQualificationScore ?? this.gettingQualificationScore,
      explanation: explanation ?? this.explanation,
      jobTitle: jobTitle ?? this.jobTitle,
      jobCompany: jobCompany ?? this.jobCompany,
    );
  }
}
