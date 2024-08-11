import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/education_level_screen/models/education_level_model.dart';
part 'education_level_event.dart';
part 'education_level_state.dart';

/// A bloc that manages the state of a Education Level according to the event that is dispatched to it.
class EducationLevelBloc
    extends Bloc<EducationLevelEvent, EducationLevelState> {
  EducationLevelBloc(EducationLevelState initialState) : super(initialState) {
    on<EducationLevelInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<ChangeRadioButtonEvent>(_changeRadioButton);
    on<SetOthersTextEvent>(_setOtherText);
    on<ChangeRadioButton1Event>(_changeRadioButton1);
    on<ChangeRadioButton2Event>(_changeRadioButton2);
    on<ChangeRadioButton3Event>(_changeRadioButton3);
    on<ChangeRadioButton4Event>(_changeRadioButton4);
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<EducationLevelState> emit,
  ) {
    emit(state.copyWith(designcreative: event.value));
  }

  _changeRadioButton(
    ChangeRadioButtonEvent event,
    Emitter<EducationLevelState> emit,
  ) {
    emit(state.copyWith(radioGroup: event.value));
  }

  _setOtherText(
      SetOthersTextEvent event,
      Emitter<EducationLevelState> emit,
      ) {
    emit(state.copyWith(othersText: event.value));
  }

  _changeRadioButton1(
    ChangeRadioButton1Event event,
    Emitter<EducationLevelState> emit,
  ) {
    emit(state.copyWith(radioGroup1: event.value));
  }

  _changeRadioButton2(
    ChangeRadioButton2Event event,
    Emitter<EducationLevelState> emit,
  ) {
    emit(state.copyWith(radioGroup2: event.value));
  }

  _changeRadioButton3(
      ChangeRadioButton3Event event,
      Emitter<EducationLevelState> emit,
      ) {
    emit(state.copyWith(radioGroup3: event.value));
  }

  _changeRadioButton4(
      ChangeRadioButton4Event event,
      Emitter<EducationLevelState> emit,
      ) {
    emit(state.copyWith(radioGroup4: event.value));
  }

  List<String> fillRadioList() {
    return [
      "high school diploma/GED",
      "associate degree",
      "bachelor degree",
      "master degree",
      "others",
    ];
  }

  _onInitialize(
    EducationLevelInitialEvent event,
    Emitter<EducationLevelState> emit,
  ) async {
    emit(state.copyWith(
        designcreative: false,
        radioGroup: "",
        radioGroup1: "",
        radioGroup2: "",
        radioGroup3: "",
        radioGroup4: "",
    ));
    emit(state.copyWith(
        educationLevelModelObj: state.EducationLevelModelObj
            ?.copyWith(radioList: fillRadioList())));
  }
}
