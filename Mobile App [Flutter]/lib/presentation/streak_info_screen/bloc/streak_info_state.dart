// ignore_for_file: must_be_immutable

part of 'streak_info_bloc.dart';

/// Represents the state of Chat in the application.
class StreakInfoState extends Equatable {
  StreakInfoState({
    this.messageController,
    this.streakInfoModelObj,
  });

  TextEditingController? messageController;

  StreakInfoModel? streakInfoModelObj;

  @override
  List<Object?> get props => [
        messageController,
        streakInfoModelObj,
      ];

  StreakInfoState copyWith({
    TextEditingController? messageController,
    StreakInfoModel? streakInfoModelObj,
  }) {
    return StreakInfoState(
      messageController: messageController ?? this.messageController,
      streakInfoModelObj: streakInfoModelObj ?? this.streakInfoModelObj,
    );
  }
}
