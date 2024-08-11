// ignore_for_file: must_be_immutable

part of 'notifications_my_proposals_bloc.dart';

/// Represents the state of NotificationsMyProposals in the application.
class NotificationsMyProposalsState extends Equatable {
  NotificationsMyProposalsState({this.notificationsMyProposalsModelObj});

  NotificationsMyProposalsModel? notificationsMyProposalsModelObj;

  @override
  List<Object?> get props => [
        notificationsMyProposalsModelObj,
      ];
  NotificationsMyProposalsState copyWith(
      {NotificationsMyProposalsModel? notificationsMyProposalsModelObj}) {
    return NotificationsMyProposalsState(
      notificationsMyProposalsModelObj: notificationsMyProposalsModelObj ??
          this.notificationsMyProposalsModelObj,
    );
  }
}
