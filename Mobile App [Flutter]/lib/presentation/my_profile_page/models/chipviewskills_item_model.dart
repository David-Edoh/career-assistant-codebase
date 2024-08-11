// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class is used in the [chipviewskills_item_widget] screen.
class ChipviewskillsItemModel extends Equatable {
  ChipviewskillsItemModel({
    this.skillsoneTxt = "Design & Creative",
    this.isSelected = false,
  });

  String skillsoneTxt;

  bool isSelected;

  ChipviewskillsItemModel copyWith({
    String? skillsoneTxt,
    bool? isSelected,
  }) {
    return ChipviewskillsItemModel(
      skillsoneTxt: skillsoneTxt ?? this.skillsoneTxt,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [skillsoneTxt, isSelected];
}
