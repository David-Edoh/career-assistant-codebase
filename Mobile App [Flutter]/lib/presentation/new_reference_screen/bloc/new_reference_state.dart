// ignore_for_file: must_be_immutable

part of 'new_reference_bloc.dart';

/// Represents the state of NewProject in the application.
class NewReferenceState extends Equatable {
  NewReferenceState({
    this.fullNameController,
    this.jobTitleController,
    this.addressController,
    this.companyController,
    this.phoneNumberController,
    this.emailController,
    // this.selectedDropDownValue,
    this.newReferenceModelObj,
    this.startDateLabel = "Select Date",
    this.endDateLabel = "Select Date",
    this.screenTitle = "",
  });

  TextEditingController? fullNameController;

  TextEditingController? jobTitleController;

  TextEditingController? addressController;

  // SelectionPopupModel? selectedDropDownValue;

  NewReferenceModel? newReferenceModelObj;

  TextEditingController? companyController;

  TextEditingController? phoneNumberController;

  TextEditingController? emailController;

  String? screenTitle;

  String? startDateLabel;

  String? endDateLabel;

  @override
  List<Object?> get props => [
        jobTitleController,
        addressController,
        companyController,
        fullNameController,
        // selectedDropDownValue,
        newReferenceModelObj,
        startDateLabel,
        endDateLabel,
        phoneNumberController,
        emailController,
        screenTitle,
      ];
  NewReferenceState copyWith({
    TextEditingController? fullNameController,
    TextEditingController? jobTitleController,
    TextEditingController? addressController,
    SelectionPopupModel? selectedDropDownValue,
    NewReferenceModel? newReferenceModelObj,
    TextEditingController? companyController,
    TextEditingController? phoneNumberController,
    TextEditingController? emailController,
    String? startDateLabel,
    String? endDateLabel,
    String? screenTitle,
  }) {
    return NewReferenceState(
      fullNameController: fullNameController ?? this.fullNameController,
      jobTitleController: jobTitleController ?? this.jobTitleController,
      addressController: addressController ?? this.addressController,
      newReferenceModelObj: newReferenceModelObj ?? this.newReferenceModelObj,
      startDateLabel: startDateLabel ?? this.startDateLabel,
      endDateLabel: endDateLabel ?? this.endDateLabel,
      companyController: companyController ?? this.companyController,
      phoneNumberController: phoneNumberController ?? this.phoneNumberController,
      emailController: emailController ?? this.emailController,
      screenTitle: screenTitle ?? this.screenTitle,
    );
  }
}
