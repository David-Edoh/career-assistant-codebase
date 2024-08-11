// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class is used in the [chipviewjobs_item_widget] screen.
class ChipviewjobsItemModel extends Equatable {
  ChipviewjobsItemModel({
    this.jobsoneTxt = "Part Time",
    this.isSelected = false,
  });

  String jobsoneTxt;

  bool isSelected;

  ChipviewjobsItemModel copyWith({
    String? jobsoneTxt,
    bool? isSelected,
  }) {
    return ChipviewjobsItemModel(
      jobsoneTxt: jobsoneTxt ?? this.jobsoneTxt,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [jobsoneTxt, isSelected];
}
