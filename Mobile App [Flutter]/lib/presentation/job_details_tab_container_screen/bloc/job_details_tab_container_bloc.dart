import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/listwallet_one_item_model.dart';
import 'package:fotisia/presentation/job_details_tab_container_screen/models/job_details_tab_container_model.dart';
part 'job_details_tab_container_event.dart';
part 'job_details_tab_container_state.dart';

/// A bloc that manages the state of a JobDetailsTabContainer according to the event that is dispatched to it.
class JobDetailsTabContainerBloc
    extends Bloc<JobDetailsTabContainerEvent, JobDetailsTabContainerState> {
  JobDetailsTabContainerBloc(JobDetailsTabContainerState initialState)
      : super(initialState) {
    on<JobDetailsTabContainerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    JobDetailsTabContainerInitialEvent event,
    Emitter<JobDetailsTabContainerState> emit,
  ) async {
    emit(state.copyWith(
        jobDetailsTabContainerModelObj:
            state.jobDetailsTabContainerModelObj?.copyWith(
      listwalletOneItemList: fillListwalletOneItemList(),
    )));
  }

  List<ListwalletOneItemModel> fillListwalletOneItemList() {
    return List.generate(3, (index) => ListwalletOneItemModel());
  }
}
