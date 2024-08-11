// ignore_for_file: must_be_immutable

part of 'applied_job_bloc.dart';

/// Represents the state of AppliedJob in the application.
class AppliedJobState extends Equatable {
  AppliedJobState({this.appliedJobModelObj});

  AppliedJobModel? appliedJobModelObj;

  @override
  List<Object?> get props => [
        appliedJobModelObj,
      ];

  AppliedJobState copyWith({AppliedJobModel? appliedJobModelObj}) {
    return AppliedJobState(
      appliedJobModelObj: appliedJobModelObj ?? this.appliedJobModelObj,
    );
  }
}
