import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/career_subjects_screen/models/career_subjects_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

part 'career_subjects_event.dart';

part 'career_subjects_state.dart';

/// A bloc that manages the state of a CareerSubjects according to the event that is dispatched to it.
class CareerSubjectsBloc extends Bloc<CareerSubjectsEvent, CareerSubjectsState>
    with CodeAutoFill {
  CareerSubjectsBloc(CareerSubjectsState initialState) : super(initialState) {
    on<CareerSubjectsInitialEvent>(_onInitialize);
    on<ChangeOTPEvent>(_changeOTP);
  }

  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }

  _changeOTP(
    ChangeOTPEvent event,
    Emitter<CareerSubjectsState> emit,
  ) {
    emit(
        state.copyWith(otpController: TextEditingController(text: event.code)));
  }

  _onInitialize(
    CareerSubjectsInitialEvent event,
    Emitter<CareerSubjectsState> emit,
  ) async {
    emit(state.copyWith(otpController: TextEditingController()));
    listenForCode();
  }
}
