// ignore_for_file: must_be_immutable

part of 'job_analysis_popup_bloc.dart';

/// Represents the state of LogoutPopup in the application.
class JobAnalysisPopupState extends Equatable {
  JobAnalysisPopupState({this.logoutPopupModelObj});

  newCareerPathPopupModel? logoutPopupModelObj;

  @override
  List<Object?> get props => [
        logoutPopupModelObj,
      ];
  JobAnalysisPopupState copyWith({newCareerPathPopupModel? logoutPopupModelObj}) {
    return JobAnalysisPopupState(
      logoutPopupModelObj: logoutPopupModelObj ?? this.logoutPopupModelObj,
    );
  }
}
