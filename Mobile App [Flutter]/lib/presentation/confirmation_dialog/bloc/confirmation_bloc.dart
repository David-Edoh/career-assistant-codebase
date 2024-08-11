import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/confirmation_dialog/models/confirmation_model.dart';

part 'confirmation_event.dart';

part 'confirmation_state.dart';

/// A bloc that manages the state of a Confirmation according to the event that is dispatched to it.
class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc(ConfirmationState initialState) : super(initialState) {
    on<ConfirmationInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ConfirmationInitialEvent event,
    Emitter<ConfirmationState> emit,
  ) async {}
}
