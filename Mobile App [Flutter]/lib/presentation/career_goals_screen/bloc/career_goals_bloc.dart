import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/career_goals_screen/models/career_goals_model.dart';
part 'career_goals_event.dart';
part 'career_goals_state.dart';

/// A bloc that manages the state of a career goals according to the event that is dispatched to it.
class CareerGoalsBloc
    extends Bloc<CareerGoalsEvent, CareerGoalsState> {
  CareerGoalsBloc(CareerGoalsState initialState) : super(initialState) {
    on<CareerGoalsInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<SetOthersTextEvent>(_setOtherText);
    on<ChangeRadioButtonEvent>(_changeRadioButton);
    on<ChangeRadioButton1Event>(_changeRadioButton1);
    on<ChangeRadioButton2Event>(_changeRadioButton2);
    on<ChangeRadioButton3Event>(_changeRadioButton3);
    on<ChangeRadioButton4Event>(_changeRadioButton4);
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<CareerGoalsState> emit,
  ) {
    emit(state.copyWith(designcreative: event.value));
  }

  _changeRadioButton(
    ChangeRadioButtonEvent event,
    Emitter<CareerGoalsState> emit,
  ) {
    emit(state.copyWith(radioGroup: event.value));
  }

  _setOtherText(
      SetOthersTextEvent event,
      Emitter<CareerGoalsState> emit,
      ) {
    emit(state.copyWith(othersText: event.value));
  }

  _changeRadioButton1(
    ChangeRadioButton1Event event,
    Emitter<CareerGoalsState> emit,
  ) {
    emit(state.copyWith(radioGroup1: event.value));
  }

  _changeRadioButton2(
    ChangeRadioButton2Event event,
    Emitter<CareerGoalsState> emit,
  ) {
    emit(state.copyWith(radioGroup2: event.value));
  }

  _changeRadioButton3(
      ChangeRadioButton3Event event,
      Emitter<CareerGoalsState> emit,
      ) {
    emit(state.copyWith(radioGroup3: event.value));
  }

  _changeRadioButton4(
      ChangeRadioButton4Event event,
      Emitter<CareerGoalsState> emit,
      ) {
    emit(state.copyWith(radioGroup4: event.value));
  }

  List<String> fillRadioList() {
    return [
      "advance within current field",
      "switch to new field",
      "start your own business",
      "work life balance",
      "others",
    ];
  }

  _onInitialize(
    CareerGoalsInitialEvent event,
    Emitter<CareerGoalsState> emit,
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
        careerGoalsModelObj: state.careerGoalsModelObj
            ?.copyWith(radioList: fillRadioList())));
  }
}
