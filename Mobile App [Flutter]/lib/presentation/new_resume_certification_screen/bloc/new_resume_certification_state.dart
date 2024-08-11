// ignore_for_file: must_be_immutable

part of 'new_resume_certification_bloc.dart';

/// Represents the state of NewProject in the application.
class NewCertificationState extends Equatable {
  NewCertificationState({
    this.titleController,
    this.descriptionController,
    this.endDate,
    this.startDate,
    this.selectedDropDownValue,
    this.newCertificationModelObj,
    this.startDateLabel = "Select Date",
    this.endDateLabel = "Select Date",
    this.screenTitle = "",
  });

  TextEditingController? titleController;


  TextEditingController? descriptionController;

  SelectionPopupModel? selectedDropDownValue;

  NewCertificationModel? newCertificationModelObj;

  DateTime? startDate;

  DateTime? endDate;

  String? startDateLabel;

  String? endDateLabel;

  String? screenTitle;

  @override
  List<Object?> get props => [
        titleController,
        descriptionController,
        startDate,
        endDate,
        selectedDropDownValue,
        newCertificationModelObj,
        startDateLabel,
        endDateLabel,
        screenTitle,
      ];
  NewCertificationState copyWith({
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    SelectionPopupModel? selectedDropDownValue,
    NewCertificationModel? newCertificationModelObj,
    DateTime? startDate,
    DateTime? endDate,
    String? startDateLabel,
    String? endDateLabel,
    String? screenTitle,
  }) {
    return NewCertificationState(
      titleController: titleController ?? this.titleController,
      descriptionController: descriptionController ?? this.descriptionController,
      newCertificationModelObj: newCertificationModelObj ?? this.newCertificationModelObj,
      startDateLabel: startDateLabel ?? this.startDateLabel,
      endDateLabel: endDateLabel ?? this.endDateLabel,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      screenTitle: screenTitle ?? this.screenTitle,
    );
  }
}
