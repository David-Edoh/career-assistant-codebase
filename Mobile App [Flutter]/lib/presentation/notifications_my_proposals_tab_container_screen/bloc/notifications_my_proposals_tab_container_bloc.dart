import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/notifications_my_proposals_tab_container_screen/models/notifications_my_proposals_tab_container_model.dart';
part 'notifications_my_proposals_tab_container_event.dart';
part 'notifications_my_proposals_tab_container_state.dart';

/// A bloc that manages the state of a NotificationsMyProposalsTabContainer according to the event that is dispatched to it.
class NotificationsMyProposalsTabContainerBloc extends Bloc<
    NotificationsMyProposalsTabContainerEvent,
    NotificationsMyProposalsTabContainerState> {
  NotificationsMyProposalsTabContainerBloc(
      NotificationsMyProposalsTabContainerState initialState)
      : super(initialState) {
    on<NotificationsMyProposalsTabContainerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    NotificationsMyProposalsTabContainerInitialEvent event,
    Emitter<NotificationsMyProposalsTabContainerState> emit,
  ) async {}
}
