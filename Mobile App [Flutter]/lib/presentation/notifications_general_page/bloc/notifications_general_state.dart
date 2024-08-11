// ignore_for_file: must_be_immutable

part of 'notifications_general_bloc.dart';

/// Represents the state of NotificationsGeneral in the application.
class NotificationsGeneralState extends Equatable {
  NotificationsGeneralState({
    this.notificationsGeneralModelObj,
    this.notifications,
  });

  NotificationsGeneralModel? notificationsGeneralModelObj;
  List<NotificationItem>? notifications;

  @override
  List<Object?> get props => [
        notificationsGeneralModelObj,
    notifications,
      ];

  NotificationsGeneralState copyWith(
      {
        NotificationsGeneralModel? notificationsGeneralModelObj,
        List<NotificationItem>? notifications,
      }) {
    return NotificationsGeneralState(
      notificationsGeneralModelObj: notificationsGeneralModelObj ?? this.notificationsGeneralModelObj,
      notifications: notifications ?? notifications,
    );
  }
}
