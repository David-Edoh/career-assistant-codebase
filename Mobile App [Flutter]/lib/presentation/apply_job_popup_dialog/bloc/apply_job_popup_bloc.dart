import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/apply_job_popup_dialog/models/apply_job_popup_model.dart';

part 'apply_job_popup_event.dart';

part 'apply_job_popup_state.dart';

/// A bloc that manages the state of a ApplyJobPopup according to the event that is dispatched to it.
class ApplyJobPopupBloc extends Bloc<ApplyJobPopupEvent, ApplyJobPopupState> {
  ApplyJobPopupBloc(ApplyJobPopupState initialState) : super(initialState) {
    on<ApplyJobPopupInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ApplyJobPopupInitialEvent event,
    Emitter<ApplyJobPopupState> emit,
  ) async {}
}
