// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'chipviewskills_item_model.dart';
import 'profile_item_model.dart';

/// This class defines the variables used in the [profile_page],
/// and is typically used to hold data that is passed between different parts of the application.
class ProfileModel extends Equatable {
  ProfileModel({
    this.chipviewskillsItemList = const [],
    this.profileItemList = const [],
  });

  List<ChipviewskillsItemModel> chipviewskillsItemList;

  List<ProfileItemModel> profileItemList;

  ProfileModel copyWith({
    List<ChipviewskillsItemModel>? chipviewskillsItemList,
    List<ProfileItemModel>? profileItemList,
  }) {
    return ProfileModel(
      chipviewskillsItemList:
          chipviewskillsItemList ?? this.chipviewskillsItemList,
      profileItemList: profileItemList ?? this.profileItemList,
    );
  }

  @override
  List<Object?> get props => [chipviewskillsItemList, profileItemList];
}
