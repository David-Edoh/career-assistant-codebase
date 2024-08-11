// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'listlogo_one_item_model.dart';

/// This class defines the variables used in the [feeds_page],
/// and is typically used to hold data that is passed between different parts of the application.
class FeedsModel extends Equatable {
  FeedsModel({this.listlogoOneItemList = const []});

  List<ListlogoOneItemModel> listlogoOneItemList;

  FeedsModel copyWith(
      {List<ListlogoOneItemModel>? listlogoOneItemList}) {
    return FeedsModel(
      listlogoOneItemList: listlogoOneItemList ?? this.listlogoOneItemList,
    );
  }

  @override
  List<Object?> get props => [listlogoOneItemList];
}
