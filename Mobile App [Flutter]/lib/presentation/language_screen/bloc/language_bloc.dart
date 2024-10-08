import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/listenglishuk_item_model.dart';
import '../models/listchineses_item_model.dart';
import 'package:fotisia/presentation/language_screen/models/language_model.dart';
part 'language_event.dart';
part 'language_state.dart';

/// A bloc that manages the state of a Language according to the event that is dispatched to it.
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(LanguageState initialState) : super(initialState) {
    on<LanguageInitialEvent>(_onInitialize);
    on<ListenglishukItemEvent>(_listenglishukItem);
  }

  _onInitialize(
    LanguageInitialEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(state.copyWith(
        languageModelObj: state.languageModelObj?.copyWith(
            listenglishukItemList: fillListenglishukItemList(),
            listchinesesItemList: fillListchinesesItemList())));
  }

  _listenglishukItem(
    ListenglishukItemEvent event,
    Emitter<LanguageState> emit,
  ) {
    List<ListenglishukItemModel> newList = List<ListenglishukItemModel>.from(
        state.languageModelObj!.listenglishukItemList);
    newList[event.index] =
        newList[event.index].copyWith(englishuk: event.englishuk);
    emit(state.copyWith(
        languageModelObj:
            state.languageModelObj?.copyWith(listenglishukItemList: newList)));
  }

  List<ListenglishukItemModel> fillListenglishukItemList() {
    return List.generate(3, (index) => ListenglishukItemModel());
  }

  List<ListchinesesItemModel> fillListchinesesItemList() {
    return List.generate(6, (index) => ListchinesesItemModel());
  }
}
