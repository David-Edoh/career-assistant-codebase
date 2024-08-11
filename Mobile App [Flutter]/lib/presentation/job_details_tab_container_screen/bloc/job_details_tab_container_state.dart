// ignore_for_file: must_be_immutable

part of 'job_details_tab_container_bloc.dart';

/// Represents the state of JobDetailsTabContainer in the application.
class JobDetailsTabContainerState extends Equatable {
  JobDetailsTabContainerState({this.jobDetailsTabContainerModelObj});

  JobDetailsTabContainerModel? jobDetailsTabContainerModelObj;

  @override
  List<Object?> get props => [
        jobDetailsTabContainerModelObj,
      ];
  JobDetailsTabContainerState copyWith(
      {JobDetailsTabContainerModel? jobDetailsTabContainerModelObj}) {
    return JobDetailsTabContainerState(
      jobDetailsTabContainerModelObj:
          jobDetailsTabContainerModelObj ?? this.jobDetailsTabContainerModelObj,
    );
  }
}
