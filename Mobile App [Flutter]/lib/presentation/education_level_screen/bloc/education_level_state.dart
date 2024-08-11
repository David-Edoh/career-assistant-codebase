// ignore_for_file: must_be_immutable

part of 'education_level_bloc.dart';

/// Represents the state of EducationLevel in the application.
class EducationLevelState extends Equatable {
  EducationLevelState({
    this.designcreative = false,
    this.radioGroup = "",
    this.radioGroup1 = "",
    this.radioGroup2 = "",
    this.radioGroup3 = "",
    this.radioGroup4 = "",
    this.othersTextController,
    this.othersText,
    this.EducationLevelModelObj,
  });

  EducationLevelModel? EducationLevelModelObj;

  bool designcreative;

  String radioGroup;

  String radioGroup1;

  String radioGroup2;

  String radioGroup3;

  String radioGroup4;

  TextEditingController? othersTextController;

  String? othersText;

  @override
  List<Object?> get props => [
        designcreative,
        radioGroup,
        radioGroup1,
        radioGroup2,
        radioGroup3,
        radioGroup4,
        othersText,
        othersTextController,
        EducationLevelModelObj,
      ];
  EducationLevelState copyWith({
    bool? designcreative,
    String? radioGroup,
    String? radioGroup1,
    String? radioGroup2,
    String? radioGroup3,
    String? radioGroup4,
    String? othersText,
    TextEditingController? othersTextController,
    EducationLevelModel? educationLevelModelObj,
  }) {
    return EducationLevelState(
      designcreative: designcreative ?? this.designcreative,
      radioGroup: radioGroup ?? this.radioGroup,
      radioGroup1: radioGroup1 ?? this.radioGroup1,
      radioGroup2: radioGroup2 ?? this.radioGroup2,
      radioGroup3: radioGroup3 ?? this.radioGroup3,
      radioGroup4: radioGroup4 ?? this.radioGroup4,
      othersText: othersText ?? this.othersText,
      EducationLevelModelObj:
          educationLevelModelObj ?? this.EducationLevelModelObj,
    );
  }
}
