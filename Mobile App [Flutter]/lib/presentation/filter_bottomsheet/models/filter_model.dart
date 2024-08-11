// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'chipviewjobs_item_model.dart';

/// This class defines the variables used in the [filter_bottomsheet],
/// and is typically used to hold data that is passed between different parts of the application.
class FilterModel extends Equatable {
  FilterModel({this.chipviewjobsItemList = const []});

  List<ChipviewjobsItemModel> chipviewjobsItemList;

  FilterModel copyWith({List<ChipviewjobsItemModel>? chipviewjobsItemList}) {
    return FilterModel(
      chipviewjobsItemList: chipviewjobsItemList ?? this.chipviewjobsItemList,
    );
  }

  @override
  List<Object?> get props => [chipviewjobsItemList];
}
