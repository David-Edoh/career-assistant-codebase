// ignore_for_file: must_be_immutable

part of 'new_project_bloc.dart';

/// Represents the state of NewProject in the application.
class NewProjectState extends Equatable {
  NewProjectState({
    this.projectTitleController,
    this.projectDescriptionController,
    this.endDate,
    this.startDate,
    // this.selectedDropDownValue,
    this.newProjectModelObj,
    this.startDateLabel = "Select Date",
    this.endDateLabel = "Select Date",
    this.screenTitle = "",
  });

  TextEditingController? projectTitleController;


  TextEditingController? projectDescriptionController;

  // SelectionPopupModel? selectedDropDownValue;

  NewProjectModel? newProjectModelObj;

  DateTime? startDate;

  DateTime? endDate;

  String? startDateLabel;

  String? endDateLabel;

  String? screenTitle;

  @override
  List<Object?> get props => [
        projectTitleController,
        projectDescriptionController,
        startDate,
        endDate,
        // selectedDropDownValue,
        newProjectModelObj,
        startDateLabel,
        endDateLabel,
        screenTitle,
      ];
  NewProjectState copyWith({
    TextEditingController? projectTitleController,
    TextEditingController? projectDescriptionController,
    SelectionPopupModel? selectedDropDownValue,
    NewProjectModel? newProjectModelObj,
    DateTime? startDate,
    DateTime? endDate,
    String? startDateLabel,
    String? endDateLabel,
    String? screenTitle,
  }) {
    return NewProjectState(
      projectTitleController: projectTitleController ?? this.projectTitleController,
      projectDescriptionController: projectDescriptionController ?? this.projectDescriptionController,
      newProjectModelObj: newProjectModelObj ?? this.newProjectModelObj,
      startDateLabel: startDateLabel ?? this.startDateLabel,
      endDateLabel: endDateLabel ?? this.endDateLabel,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      screenTitle: screenTitle ?? this.screenTitle,
    );
  }
}
