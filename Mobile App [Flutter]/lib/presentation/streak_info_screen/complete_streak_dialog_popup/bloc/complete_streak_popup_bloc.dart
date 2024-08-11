import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/logout_popup_dialog/models/logout_popup_model.dart';
part 'complete_streak_popup_event.dart';
part 'complete_streak_popup_state.dart';

/// A bloc that manages the state of a LogoutPopup according to the event that is dispatched to it.
class CompleteStreakPopupBloc extends Bloc<CompleteStreakPopupEvent, CompleteStreakPopupState> {
  CompleteStreakPopupBloc(CompleteStreakPopupState initialState) : super(initialState) {
    on<CompleteStreakPopupInitialEvent>(_onInitialize);
  }

  _onInitialize(
    CompleteStreakPopupInitialEvent event,
    Emitter<CompleteStreakPopupState> emit,
  ) async {}
}
