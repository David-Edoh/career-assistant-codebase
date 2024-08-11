// ignore_for_file: must_be_immutable

part of 'new_position_bloc.dart';

/// Represents the state of NewPosition in the application.
class NewPositionState extends Equatable {
  NewPositionState({
    this.positionTitleController,
    this.companyNameController,
    this.positionController,
    this.locationController,
    this.jobDescriptionController,
    this.screenTitle = "",
    this.endDate,
    this.startDate,
    // this.selectedDropDownValue,
    this.newPositionModelObj,
    this.startDateLabel = "Select Date",
    this.endDateLabel = "Select Date",
    this.currentlyWorkHere = false,
    this.richEditorController,
    this.initialDescription,
  });

  TextEditingController? positionTitleController;
  TextEditingController? companyNameController;
  TextEditingController? positionController;
  TextEditingController? locationController;
  TextEditingController? jobDescriptionController;
  QuillEditorController? richEditorController;
  // SelectionPopupModel? selectedDropDownValue;
  NewPositionModel? newPositionModelObj;
  DateTime? startDate;
  DateTime? endDate;
  String? startDateLabel;
  String? endDateLabel;
  String? screenTitle;
  bool currentlyWorkHere;
  String? initialDescription;

  @override
  List<Object?> get props => [
        positionTitleController,
        companyNameController,
        locationController,
        jobDescriptionController,
        positionController,
        startDate,
        endDate,
        // selectedDropDownValue,
        newPositionModelObj,
        startDateLabel,
        endDateLabel,
        screenTitle,
        currentlyWorkHere,
        richEditorController,
        initialDescription,
      ];
  NewPositionState copyWith({
    TextEditingController? positionTitleController,
    TextEditingController? companyNameController,
    TextEditingController? positionController,
    TextEditingController? locationController,
    TextEditingController? jobDescriptionController,
    SelectionPopupModel? selectedDropDownValue,
    NewPositionModel? newPositionModelObj,
    QuillEditorController? richEditorController,
    String? initialDescription,
    DateTime? startDate,
    DateTime? endDate,
    String? startDateLabel,
    String? endDateLabel,
    String? screenTitle,
    bool? currentlyWorkHere,
  }) {
    return NewPositionState(
      positionTitleController: positionTitleController ?? this.positionTitleController,
      companyNameController: companyNameController ?? this.companyNameController,
      positionController: positionController ?? this.positionController,
      locationController: locationController ?? this.locationController,
      jobDescriptionController: jobDescriptionController ?? this.jobDescriptionController,
      // selectedDropDownValue: selectedDropDownValue ?? this.selectedDropDownValue,
      newPositionModelObj: newPositionModelObj ?? this.newPositionModelObj,
      startDateLabel: startDateLabel ?? this.startDateLabel,
      endDateLabel: endDateLabel ?? this.endDateLabel,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      screenTitle: screenTitle ?? this.screenTitle,
      currentlyWorkHere: currentlyWorkHere ?? this.currentlyWorkHere,
      richEditorController: richEditorController ?? this.richEditorController,
      initialDescription: initialDescription ?? this.initialDescription,
    );
  }
}
