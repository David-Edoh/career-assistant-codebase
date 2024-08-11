// ignore_for_file: must_be_immutable

part of 'notifications_my_proposals_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///NotificationsMyProposals widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NotificationsMyProposalsEvent extends Equatable {}

/// Event that is dispatched when the NotificationsMyProposals widget is first created.
class NotificationsMyProposalsInitialEvent
    extends NotificationsMyProposalsEvent {
  @override
  List<Object?> get props => [];
}
