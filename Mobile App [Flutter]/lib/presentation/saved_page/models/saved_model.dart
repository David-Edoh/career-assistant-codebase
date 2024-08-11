// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'saved_item_model.dart';

/// This class defines the variables used in the [saved_page],
/// and is typically used to hold data that is passed between different parts of the application.
class SavedModel extends Equatable {
  SavedModel({this.savedItemList = const []});

  List<SavedItemModel> savedItemList;

  SavedModel copyWith({List<SavedItemModel>? savedItemList}) {
    return SavedModel(
      savedItemList: savedItemList ?? this.savedItemList,
    );
  }

  @override
  List<Object?> get props => [savedItemList];
}
