import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/career_subjects_screen/models/career_subjects_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

part 'links_preview_event.dart';

part 'links_preview_state.dart';

/// A bloc that manages the state of a CareerSubjects according to the event that is dispatched to it.
class LinksPreviewBloc extends Bloc<LinksPreviewEvent, LinksPreviewState>
    with CodeAutoFill {
  LinksPreviewBloc(LinksPreviewState initialState) : super(initialState) {
    on<LinksPreviewInitialEvent>(_onInitialize);
    on<ChangeOTPEvent>(_changeOTP);
  }

  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }

  _changeOTP(
    ChangeOTPEvent event,
    Emitter<LinksPreviewState> emit,
  ) {
    emit(
        state.copyWith(otpController: TextEditingController(text: event.code)));
  }

  _onInitialize(
    LinksPreviewInitialEvent event,
    Emitter<LinksPreviewState> emit,
  ) async {
    emit(state.copyWith(otpController: TextEditingController()));
    listenForCode();
  }
}
