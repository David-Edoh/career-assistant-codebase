// ignore_for_file: must_be_immutable

part of 'notifications_my_proposals_tab_container_bloc.dart';

/// Represents the state of NotificationsMyProposalsTabContainer in the application.
class NotificationsMyProposalsTabContainerState extends Equatable {
  NotificationsMyProposalsTabContainerState(
      {this.notificationsMyProposalsTabContainerModelObj});

  NotificationsMyProposalsTabContainerModel?
      notificationsMyProposalsTabContainerModelObj;

  @override
  List<Object?> get props => [
        notificationsMyProposalsTabContainerModelObj,
      ];
  NotificationsMyProposalsTabContainerState copyWith(
      {NotificationsMyProposalsTabContainerModel?
          notificationsMyProposalsTabContainerModelObj}) {
    return NotificationsMyProposalsTabContainerState(
      notificationsMyProposalsTabContainerModelObj:
          notificationsMyProposalsTabContainerModelObj ??
              this.notificationsMyProposalsTabContainerModelObj,
    );
  }
}
