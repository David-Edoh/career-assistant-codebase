// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'listwallet_one_item_model.dart';

/// This class defines the variables used in the [job_details_tab_container_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class JobDetailsTabContainerModel extends Equatable {
  JobDetailsTabContainerModel({this.listwalletOneItemList = const []});

  List<ListwalletOneItemModel> listwalletOneItemList;

  JobDetailsTabContainerModel copyWith(
      {List<ListwalletOneItemModel>? listwalletOneItemList}) {
    return JobDetailsTabContainerModel(
      listwalletOneItemList:
          listwalletOneItemList ?? this.listwalletOneItemList,
    );
  }

  @override
  List<Object?> get props => [listwalletOneItemList];
}
