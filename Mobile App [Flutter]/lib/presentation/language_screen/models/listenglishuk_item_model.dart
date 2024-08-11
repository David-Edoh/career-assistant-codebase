// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class is used in the [listenglishuk_item_widget] screen.
class ListenglishukItemModel extends Equatable {
  ListenglishukItemModel({
    this.englishuk = false,
    this.id,
  });

  bool englishuk;

  String? id;

  ListenglishukItemModel copyWith({
    bool? englishuk,
    String? id,
  }) {
    return ListenglishukItemModel(
      englishuk: englishuk ?? this.englishuk,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [englishuk, id];
}
