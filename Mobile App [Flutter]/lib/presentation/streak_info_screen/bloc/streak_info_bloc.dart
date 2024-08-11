import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/chat_screen/models/chat_model.dart';

part 'streak_info_event.dart';

part 'streak_info_state.dart';

/// A bloc that manages the state of a Chat according to the event that is dispatched to it.
class StreakInfoBloc extends Bloc<StreakInfoEvent, StreakInfoState> {
  StreakInfoBloc(StreakInfoState initialState) : super(initialState) {
    on<StreakInfoInitialEvent>(_onInitialize);
  }

  _onInitialize(
    StreakInfoInitialEvent event,
    Emitter<StreakInfoState> emit,
  ) async {
    emit(state.copyWith(messageController: TextEditingController()));
  }
}
