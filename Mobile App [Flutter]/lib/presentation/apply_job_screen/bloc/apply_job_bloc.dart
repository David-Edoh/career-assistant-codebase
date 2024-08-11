import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/apply_job_screen/models/apply_job_model.dart';

part 'apply_job_event.dart';

part 'apply_job_state.dart';

/// A bloc that manages the state of a ApplyJob according to the event that is dispatched to it.
class ApplyJobBloc extends Bloc<ApplyJobEvent, ApplyJobState> {
  ApplyJobBloc(ApplyJobState initialState) : super(initialState) {
    on<ApplyJobInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ApplyJobInitialEvent event,
    Emitter<ApplyJobState> emit,
  ) async {
    emit(state.copyWith(
        fullNameController: TextEditingController(),
        emailController: TextEditingController(),
        frameOneController: TextEditingController()));
  }
}
