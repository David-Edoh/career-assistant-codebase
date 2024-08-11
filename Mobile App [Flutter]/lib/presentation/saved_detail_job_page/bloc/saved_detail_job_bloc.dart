import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/saved_detail_job_page/models/saved_detail_job_model.dart';
part 'saved_detail_job_event.dart';
part 'saved_detail_job_state.dart';

/// A bloc that manages the state of a SavedDetailJob according to the event that is dispatched to it.
class SavedDetailJobBloc
    extends Bloc<SavedDetailJobEvent, SavedDetailJobState> {
  SavedDetailJobBloc(SavedDetailJobState initialState) : super(initialState) {
    on<SavedDetailJobInitialEvent>(_onInitialize);
  }

  _onInitialize(
    SavedDetailJobInitialEvent event,
    Emitter<SavedDetailJobState> emit,
  ) async {}
}
