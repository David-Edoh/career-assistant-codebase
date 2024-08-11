import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/Streak/streak.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/career_roadmap_screen/models/career_roadmap_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

part 'career_roadmap_event.dart';

part 'career_roadmap_state.dart';

/// A bloc that manages the state of a CareerRoadmap according to the event that is dispatched to it.
class CareerRoadmapBloc extends Bloc<CareerRoadmapEvent, CareerRoadmapState>
    with CodeAutoFill {
  CareerRoadmapBloc(CareerRoadmapState initialState) : super(initialState) {
    on<CareerRoadmapInitialEvent>(_onInitialize);
    on<ChangeOTPEvent>(_changeOTP);
  }

  final _apiClient = ApiClient();


  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }

  _changeOTP(
    ChangeOTPEvent event,
    Emitter<CareerRoadmapState> emit,
  ) {
    emit(
        state.copyWith(otpController: TextEditingController(text: event.code)));
  }

  _onInitialize(
    CareerRoadmapInitialEvent event,
    Emitter<CareerRoadmapState> emit,
  ) async {
    print("here streak");
    await getStreak();

    emit(state.copyWith(otpController: TextEditingController()));
    listenForCode();
  }

  getStreak() async {
    emit(state.copyWith(
      isStreakLoading: true,
    ));

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/streak/${userData['id']}";

    await _apiClient.getData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
      showLoading: false,
      useCache: false,
    ).then((value) async {

      Streak streak = Streak.fromJson(value);

      emit(state.copyWith(
        isStreakLoading: false,
        streak: streak
      ));

    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);

      emit(state.copyWith(
        isStreakLoading: false,
      ));

      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }
}
