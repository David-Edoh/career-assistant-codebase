// ignore_for_file: must_be_immutable

part of 'apply_job_bloc.dart';

/// Represents the state of ApplyJob in the application.
class ApplyJobState extends Equatable {
  ApplyJobState({
    this.fullNameController,
    this.emailController,
    this.frameOneController,
    this.applyJobModelObj,
  });

  TextEditingController? fullNameController;

  TextEditingController? emailController;

  TextEditingController? frameOneController;

  ApplyJobModel? applyJobModelObj;

  @override
  List<Object?> get props => [
        fullNameController,
        emailController,
        frameOneController,
        applyJobModelObj,
      ];

  ApplyJobState copyWith({
    TextEditingController? fullNameController,
    TextEditingController? emailController,
    TextEditingController? frameOneController,
    ApplyJobModel? applyJobModelObj,
  }) {
    return ApplyJobState(
      fullNameController: fullNameController ?? this.fullNameController,
      emailController: emailController ?? this.emailController,
      frameOneController: frameOneController ?? this.frameOneController,
      applyJobModelObj: applyJobModelObj ?? this.applyJobModelObj,
    );
  }
}
