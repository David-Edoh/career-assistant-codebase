import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/job_details_page/models/job_details_model.dart';
part 'job_details_event.dart';
part 'job_details_state.dart';

/// A bloc that manages the state of a JobDetails according to the event that is dispatched to it.
class JobDetailsBloc extends Bloc<JobDetailsEvent, JobDetailsState> {
  JobDetailsBloc(JobDetailsState initialState) : super(initialState) {
    on<JobDetailsInitialEvent>(_onInitialize);
  }

  _onInitialize(
    JobDetailsInitialEvent event,
    Emitter<JobDetailsState> emit,
  ) async {}
}
