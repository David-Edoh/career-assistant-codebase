import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/employment_status_screen/models/employment_status_model.dart';
part 'employment_status_event.dart';
part 'employment_status_state.dart';

/// A bloc that manages the state of a Employment Status according to the event that is dispatched to it.
class EmploymentStatusBloc
    extends Bloc<EmploymentStatusEvent, EmploymentStatusState> {
  EmploymentStatusBloc(EmploymentStatusState initialState) : super(initialState) {
    on<EmploymentStatusInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<ChangeRadioButtonEvent>(_changeRadioButton);
    on<SetOthersTextEvent>(_setOtherText);
    // on<ChangeRadioButton2Event>(_changeRadioButton2);
    // on<ChangeRadioButton3Event>(_changeRadioButton3);
    // on<ChangeRadioButton4Event>(_changeRadioButton4);
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<EmploymentStatusState> emit,
  ) {
    emit(state.copyWith(designcreative: event.value));
  }

  _changeRadioButton(
    ChangeRadioButtonEvent event,
    Emitter<EmploymentStatusState> emit,
  ) {
    emit(state.copyWith(radioGroup: event.value));
  }

  _setOtherText(
    SetOthersTextEvent event,
    Emitter<EmploymentStatusState> emit,
  ) {
    emit(state.copyWith(othersText: event.value));
  }

  _changeRadioButton2(
    ChangeRadioButton2Event event,
    Emitter<EmploymentStatusState> emit,
  ) {
    emit(state.copyWith(radioGroup2: event.value));
  }

  _changeRadioButton3(
      ChangeRadioButton3Event event,
      Emitter<EmploymentStatusState> emit,
      ) {
    emit(state.copyWith(radioGroup3: event.value));
  }

  _changeRadioButton4(
      ChangeRadioButton4Event event,
      Emitter<EmploymentStatusState> emit,
      ) {
    emit(state.copyWith(radioGroup4: event.value));
  }

  List<String> fillRadioList() {
    return [
      "employed full time",
      "employed part time",
      "unemployed",
      "student",
      "others",
    ];
  }

  _onInitialize(
    EmploymentStatusInitialEvent event,
    Emitter<EmploymentStatusState> emit,
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
        EmploymentStatusModelObj: state.EmploymentStatusModelObj
            ?.copyWith(radioList: fillRadioList())));
  }
}
