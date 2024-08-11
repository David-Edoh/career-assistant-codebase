import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../models/personal_brand_model.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/career_subjects_screen/models/career_subjects_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

part 'personal_brand_event.dart';

part 'personal_brand_state.dart';

/// A bloc that manages the state of a PersonalBrand according to the event that is dispatched to it.
class PersonalBrandBloc extends Bloc<PersonalBrandEvent, PersonalBrandState>
    with CodeAutoFill {
  PersonalBrandBloc(PersonalBrandState initialState) : super(initialState) {
    on<PersonalBrandInitialEvent>(_onInitialize);
    // on<ChangeOTPEvent>(_changeOTP);
  }

  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }


  _onInitialize(
    PersonalBrandInitialEvent event,
    Emitter<PersonalBrandState> emit,
  ) async {
    emit(state.copyWith(otpController: TextEditingController()));
    listenForCode();
  }
}
