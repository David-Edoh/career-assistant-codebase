// ignore_for_file: must_be_immutable

part of 'streak_info_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Chat widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class StreakInfoEvent extends Equatable {}

/// Event that is dispatched when the Chat widget is first created.
class StreakInfoInitialEvent extends StreakInfoEvent {
  @override
  List<Object?> get props => [];
}
