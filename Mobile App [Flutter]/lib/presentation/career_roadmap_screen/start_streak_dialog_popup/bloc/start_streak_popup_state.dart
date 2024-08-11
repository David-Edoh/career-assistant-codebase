// ignore_for_file: must_be_immutable

part of 'start_streak_popup_bloc.dart';

/// Represents the state of LogoutPopup in the application.
class StartStreakPopupState extends Equatable {
  StartStreakPopupState({this.startStreakPopupModelObj});

  newCareerPathPopupModel? startStreakPopupModelObj;

  @override
  List<Object?> get props => [
        startStreakPopupModelObj,
      ];
  StartStreakPopupState copyWith({newCareerPathPopupModel? logoutPopupModelObj}) {
    return StartStreakPopupState(
      startStreakPopupModelObj: logoutPopupModelObj ?? this.startStreakPopupModelObj,
    );
  }
}
