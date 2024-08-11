// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'listenglishuk_item_model.dart';
import 'listchineses_item_model.dart';

/// This class defines the variables used in the [language_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class LanguageModel extends Equatable {
  LanguageModel({
    this.listenglishukItemList = const [],
    this.listchinesesItemList = const [],
  });

  List<ListenglishukItemModel> listenglishukItemList;

  List<ListchinesesItemModel> listchinesesItemList;

  LanguageModel copyWith({
    List<ListenglishukItemModel>? listenglishukItemList,
    List<ListchinesesItemModel>? listchinesesItemList,
  }) {
    return LanguageModel(
      listenglishukItemList:
          listenglishukItemList ?? this.listenglishukItemList,
      listchinesesItemList: listchinesesItemList ?? this.listchinesesItemList,
    );
  }

  @override
  List<Object?> get props => [listenglishukItemList, listchinesesItemList];
}
