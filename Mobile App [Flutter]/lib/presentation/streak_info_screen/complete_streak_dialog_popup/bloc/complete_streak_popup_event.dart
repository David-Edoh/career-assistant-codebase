// ignore_for_file: must_be_immutable

part of 'complete_streak_popup_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///LogoutPopup widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CompleteStreakPopupEvent extends Equatable {}

/// Event that is dispatched when the LogoutPopup widget is first created.
class CompleteStreakPopupInitialEvent extends CompleteStreakPopupEvent {
  @override
  List<Object?> get props => [];
}
