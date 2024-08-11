import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/logout_popup_dialog/models/logout_popup_model.dart';
part 'start_streak_popup_event.dart';
part 'start_streak_popup_state.dart';

/// A bloc that manages the state of a LogoutPopup according to the event that is dispatched to it.
class StartStreakPopupBloc extends Bloc<StartStreakPopupEvent, StartStreakPopupState> {
  StartStreakPopupBloc(StartStreakPopupState initialState) : super(initialState) {
    on<StartStreakPopupInitialEvent>(_onInitialize);
    on<SetStreakGoalEvent>(_setStreakGoal);
  }

  _onInitialize(
    StartStreakPopupInitialEvent event,
    Emitter<StartStreakPopupState> emit,
  ) async {}

  _setStreakGoal(
      SetStreakGoalEvent event,
      Emitter<StartStreakPopupState> emit,
      ) async {

    }


}
