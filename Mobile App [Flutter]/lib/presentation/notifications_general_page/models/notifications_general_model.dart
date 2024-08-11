// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'listlogo_one_item_model.dart';

/// This class defines the variables used in the [notifications_general_page],
/// and is typically used to hold data that is passed between different parts of the application.
class NotificationsGeneralModel extends Equatable {
  NotificationsGeneralModel({this.listlogoOneItemList = const []});

  List<ListlogoOneItemModel> listlogoOneItemList;

  NotificationsGeneralModel copyWith(
      {List<ListlogoOneItemModel>? listlogoOneItemList}) {
    return NotificationsGeneralModel(
      listlogoOneItemList: listlogoOneItemList ?? this.listlogoOneItemList,
    );
  }

  @override
  List<Object?> get props => [listlogoOneItemList];
}
