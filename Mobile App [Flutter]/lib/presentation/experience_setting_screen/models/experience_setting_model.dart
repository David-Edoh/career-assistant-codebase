// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'experience_item_model.dart';

/// This class defines the variables used in the [experience_setting_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ExperienceSettingModel extends Equatable {
  ExperienceSettingModel({this.experienceItemList = const []});

  List<ExperienceItemModel> experienceItemList;

  ExperienceSettingModel copyWith(
      {List<ExperienceItemModel>? experienceItemList}) {
    return ExperienceSettingModel(
      experienceItemList: experienceItemList ?? this.experienceItemList,
    );
  }

  @override
  List<Object?> get props => [experienceItemList];
}
