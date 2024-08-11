import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/applied_job_page/models/applied_job_model.dart';

part 'applied_job_event.dart';

part 'applied_job_state.dart';

/// A bloc that manages the state of a AppliedJob according to the event that is dispatched to it.
class AppliedJobBloc extends Bloc<AppliedJobEvent, AppliedJobState> {
  AppliedJobBloc(AppliedJobState initialState) : super(initialState) {
    on<AppliedJobInitialEvent>(_onInitialize);
  }

  _onInitialize(
    AppliedJobInitialEvent event,
    Emitter<AppliedJobState> emit,
  ) async {}
}
