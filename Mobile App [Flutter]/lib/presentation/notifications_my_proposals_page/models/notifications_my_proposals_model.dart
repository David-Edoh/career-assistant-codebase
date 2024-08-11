// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'listlocation_item_model.dart';

/// This class defines the variables used in the [notifications_my_proposals_page],
/// and is typically used to hold data that is passed between different parts of the application.
class NotificationsMyProposalsModel extends Equatable {
  NotificationsMyProposalsModel({this.listlocationItemList = const []});

  List<ListlocationItemModel> listlocationItemList;

  NotificationsMyProposalsModel copyWith(
      {List<ListlocationItemModel>? listlocationItemList}) {
    return NotificationsMyProposalsModel(
      listlocationItemList: listlocationItemList ?? this.listlocationItemList,
    );
  }

  @override
  List<Object?> get props => [listlocationItemList];
}
