// ignore_for_file: must_be_immutable

part of 'start_streak_popup_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///LogoutPopup widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class StartStreakPopupEvent extends Equatable {}

/// Event that is dispatched when the LogoutPopup widget is first created.
class StartStreakPopupInitialEvent extends StartStreakPopupEvent {
  @override
  List<Object?> get props => [];
}

class SetStreakGoalEvent extends StartStreakPopupEvent {
  SetStreakGoalEvent({required this.careerId});

  String careerId;

  @override
  List<Object?> get props => [
    careerId,
  ];
}