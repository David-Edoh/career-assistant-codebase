// ignore_for_file: must_be_immutable

part of 'new_career_path_popup_bloc.dart';

/// Represents the state of LogoutPopup in the application.
class NewCareerPathPopupState extends Equatable {
  NewCareerPathPopupState({this.newCareerPathPopupModelObj, this.careerNameController});

  newCareerPathPopupModel? newCareerPathPopupModelObj;
  TextEditingController? careerNameController;

  @override
  List<Object?> get props => [
        newCareerPathPopupModelObj,
    careerNameController,
      ];
  NewCareerPathPopupState copyWith({newCareerPathPopupModel? logoutPopupModelObj, TextEditingController? careerNameController}) {
    return NewCareerPathPopupState(
      newCareerPathPopupModelObj: logoutPopupModelObj ?? this.newCareerPathPopupModelObj,
      careerNameController: careerNameController ?? this.careerNameController
    );
  }
}
