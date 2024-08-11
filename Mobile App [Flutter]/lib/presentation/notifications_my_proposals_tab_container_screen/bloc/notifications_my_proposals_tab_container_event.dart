// ignore_for_file: must_be_immutable

part of 'notifications_my_proposals_tab_container_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///NotificationsMyProposalsTabContainer widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NotificationsMyProposalsTabContainerEvent extends Equatable {}

/// Event that is dispatched when the NotificationsMyProposalsTabContainer widget is first created.
class NotificationsMyProposalsTabContainerInitialEvent
    extends NotificationsMyProposalsTabContainerEvent {
  @override
  List<Object?> get props => [];
}
