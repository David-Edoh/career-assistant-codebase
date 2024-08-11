// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'notifications_item_model.dart';

/// This class defines the variables used in the [notifications_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class NotificationsModel extends Equatable {
  NotificationsModel({this.notificationsItemList = const []});

  List<NotificationsItemModel> notificationsItemList;

  NotificationsModel copyWith(
      {List<NotificationsItemModel>? notificationsItemList}) {
    return NotificationsModel(
      notificationsItemList:
          notificationsItemList ?? this.notificationsItemList,
    );
  }

  @override
  List<Object?> get props => [notificationsItemList];
}
