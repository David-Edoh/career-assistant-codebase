// ignore_for_file: must_be_immutable

part of 'speciallization_bloc.dart';

/// Represents the state of Speciallization in the application.
class SpeciallizationState extends Equatable {
  SpeciallizationState({
    this.designcreative = false,
    this.radioGroup = "",
    this.radioGroup1 = "",
    this.radioGroup2 = "",
    this.radioGroup3 = "",
    this.radioGroup4 = "",
    this.radioGroup5 = "",
    this.othersTextController,
    this.othersText,
    this.speciallizationModelObj,
  });

  SpeciallizationModel? speciallizationModelObj;

  bool designcreative;

  String radioGroup;

  String radioGroup1;

  String radioGroup2;

  String radioGroup3;

  String radioGroup4;

  String radioGroup5;

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
        radioGroup5,
        othersText,
        othersTextController,
        speciallizationModelObj,
      ];
  SpeciallizationState copyWith({
    bool? designcreative,
    String? radioGroup,
    String? radioGroup1,
    String? radioGroup2,
    String? radioGroup3,
    String? radioGroup4,
    String? othersText,
    String? radioGroup5,
    TextEditingController? othersTextController,
    SpeciallizationModel? speciallizationModelObj,
  }) {
    return SpeciallizationState(
      designcreative: designcreative ?? this.designcreative,
      radioGroup: radioGroup ?? this.radioGroup,
      radioGroup1: radioGroup1 ?? this.radioGroup1,
      radioGroup2: radioGroup2 ?? this.radioGroup2,
      radioGroup3: radioGroup3 ?? this.radioGroup3,
      radioGroup4: radioGroup4 ?? this.radioGroup4,
      radioGroup5: radioGroup5 ?? this.radioGroup5,
      othersText: othersText ?? this.othersText,
      speciallizationModelObj:
          speciallizationModelObj ?? this.speciallizationModelObj,
    );
  }
}
