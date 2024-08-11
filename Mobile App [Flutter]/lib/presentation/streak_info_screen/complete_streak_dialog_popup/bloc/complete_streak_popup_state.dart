// ignore_for_file: must_be_immutable

part of 'complete_streak_popup_bloc.dart';

/// Represents the state of LogoutPopup in the application.
class CompleteStreakPopupState extends Equatable {
  CompleteStreakPopupState({
    this.completeStreakPopupModelObj,
    this.scoreReceived,
  });

  newCareerPathPopupModel? completeStreakPopupModelObj;
  bool? scoreReceived;

  @override
  List<Object?> get props => [
    completeStreakPopupModelObj,
    scoreReceived,
      ];
  CompleteStreakPopupState copyWith({
    newCareerPathPopupModel? completePopupModelObj,
    bool? scoreReceived,
  }) {
    return CompleteStreakPopupState(
      completeStreakPopupModelObj: completePopupModelObj ?? this.completeStreakPopupModelObj,
        scoreReceived: scoreReceived ?? this.scoreReceived
    );
  }
}
