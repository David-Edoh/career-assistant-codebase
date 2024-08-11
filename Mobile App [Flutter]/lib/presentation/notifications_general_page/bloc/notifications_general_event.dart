// ignore_for_file: must_be_immutable

part of 'notifications_general_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///NotificationsGeneral widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NotificationsGeneralEvent extends Equatable {}

/// Event that is dispatched when the NotificationsGeneral widget is first created.
class NotificationsGeneralInitialEvent extends NotificationsGeneralEvent {
  @override
  List<Object?> get props => [];
}
