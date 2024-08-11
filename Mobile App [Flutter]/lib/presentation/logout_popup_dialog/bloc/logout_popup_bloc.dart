import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/logout_popup_dialog/models/logout_popup_model.dart';
part 'logout_popup_event.dart';
part 'logout_popup_state.dart';

/// A bloc that manages the state of a LogoutPopup according to the event that is dispatched to it.
class LogoutPopupBloc extends Bloc<LogoutPopupEvent, LogoutPopupState> {
  LogoutPopupBloc(LogoutPopupState initialState) : super(initialState) {
    on<LogoutPopupInitialEvent>(_onInitialize);
  }

  _onInitialize(
    LogoutPopupInitialEvent event,
    Emitter<LogoutPopupState> emit,
  ) async {}
}
