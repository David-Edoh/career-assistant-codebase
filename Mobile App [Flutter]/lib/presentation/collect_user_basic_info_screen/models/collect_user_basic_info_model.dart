// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'experience_item_model.dart';

/// This class defines the variables used in the [resume_setting_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class CollectBasicUserInfoModel extends Equatable {
  CollectBasicUserInfoModel({this.resumeItemList = const []});
  List<ExperienceItemModel> resumeItemList;

  CollectBasicUserInfoModel copyWith({List<ExperienceItemModel>? resumeItemList}) {
    return CollectBasicUserInfoModel(
      resumeItemList: resumeItemList ?? this.resumeItemList,
    );
  }

  @override
  List<Object?> get props => [resumeItemList];
}
