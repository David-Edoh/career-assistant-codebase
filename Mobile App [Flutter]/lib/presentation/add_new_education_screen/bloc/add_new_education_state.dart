// ignore_for_file: must_be_immutable

part of 'add_new_education_bloc.dart';

/// Represents the state of AddNewEducation in the application.
class AddNewEducationState extends Equatable {
  AddNewEducationState({
    this.schoolNameController,
    this.disciplineController,
    this.startDateLabel = "Select Date",
    this.endDateLabel = "Select Date",
    this.educationLevelController,
    this.screenTitle = "",
    this.descriptionController,
    this.endDate,
    this.startDate,
    // this.selectedDropDownValue,
    this.addNewEducationModelObj,
    this.currentlySchoolHere = false,
  });

  TextEditingController? schoolNameController;
  TextEditingController? disciplineController;
  TextEditingController? educationLevelController;
  TextEditingController? descriptionController;
  // SelectionPopupModel? selectedDropDownValue;
  AddNewEducationModel? addNewEducationModelObj;
  String? startDateLabel;
  String? endDateLabel;
  DateTime? startDate;
  DateTime? endDate;
  String? screenTitle;
  bool? currentlySchoolHere;

  @override
  List<Object?> get props => [
        schoolNameController,
        disciplineController,
        educationLevelController,
        descriptionController,
        // selectedDropDownValue,
        addNewEducationModelObj,
        startDateLabel,
        endDateLabel,
        startDate,
        endDate,
        screenTitle,
        currentlySchoolHere,
      ];

  AddNewEducationState copyWith({
    TextEditingController? schoolNameController,
    TextEditingController? disciplineController,
    TextEditingController? educationLevelController,
    TextEditingController? descriptionController,
    SelectionPopupModel? selectedDropDownValue,
    AddNewEducationModel? addNewEducationModelObj,
    String? startDateLabel,
    String? endDateLabel,
    DateTime? startDate,
    DateTime? endDate,
    String? screenTitle,
    bool? currentlySchoolHere,
  }) {
    return AddNewEducationState(
      schoolNameController: schoolNameController ?? this.schoolNameController,
      disciplineController: disciplineController ?? this.disciplineController,
      educationLevelController: educationLevelController ?? this.educationLevelController,
      descriptionController: descriptionController ?? this.descriptionController,
      // selectedDropDownValue: selectedDropDownValue ?? this.selectedDropDownValue,
      addNewEducationModelObj: addNewEducationModelObj ?? this.addNewEducationModelObj,
      startDateLabel: startDateLabel ?? this.startDateLabel,
      endDateLabel: endDateLabel ?? this.endDateLabel,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      screenTitle: screenTitle ?? this.screenTitle,
      currentlySchoolHere: currentlySchoolHere ?? this.currentlySchoolHere,
    );
  }
}
