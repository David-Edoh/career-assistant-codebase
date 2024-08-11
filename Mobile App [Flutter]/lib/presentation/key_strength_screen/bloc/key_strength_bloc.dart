import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/models/loginAuth/post_login_auth_resp.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/key_strength_screen/models/key_strength_model.dart';
import 'package:fotisia/data/apiClient/api_client.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
part 'key_strength_event.dart';
part 'key_strength_state.dart';

/// A bloc that manages the state of a Key Strength according to the event that is dispatched to it.
class KeyStrengthBloc
    extends Bloc<KeyStrengthEvent, KeyStrengthState> {
  KeyStrengthBloc(KeyStrengthState initialState) : super(initialState) {
    on<KeyStrengthInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<SetOthersTextEvent>(_setOtherText);
    on<ChangeRadioButtonEvent>(_changeRadioButton);
    on<SaveUserDetailsEvent>(_saveUserDetailsEvent);
  }
  final _apiClient = ApiClient();

  /// Calls [https://nodedemo.dhiwise.co/device/auth/register] with the provided event and emits the state.
  ///
  /// The [CreateRegisterEvent] parameter is used for handling event data
  /// The [emit] parameter is used for emitting the state
  ///
  /// Throws an error if an error occurs during the API call process.
  FutureOr<void> _saveUserDetailsEvent(SaveUserDetailsEvent event, Emitter<KeyStrengthState> emit) async {
    const storage = FlutterSecureStorage();

    String? employmentStatus = await storage.read(key: "employment_status");
    String? educationLevel = await storage.read(key: "education_level");
    String? specialization = await storage.read(key: "specialization");
    String? careerGoal = await storage.read(key: "career_goal");
    String? keyStrength = await storage.read(key: "key_strength");
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    Map userCareerData = {
      "employmentStatus": employmentStatus,
      "educationLevel": educationLevel,
      "specialization": specialization,
      "careerGoal": careerGoal,
      "keyStrength": keyStrength,
    };
    await _apiClient.postData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      requestData: userCareerData,
      path: "api/user/career/details/${userData['id']}",
    ).then((value) async {
      PostLoginAuthResp.saveToSecureStorage(value);
      event.onSaveUserDetailsSuccess?.call();
    }).onError((error, stackTrace) {
      //implement error call
      event.onSaveUserDetailsError?.call();
    });
  }

  _setOtherText(
      SetOthersTextEvent event,
      Emitter<KeyStrengthState> emit,
      ) {
    emit(state.copyWith(othersText: event.value));
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<KeyStrengthState> emit,
  ) {
    emit(state.copyWith(designcreative: event.value));
  }

  _changeRadioButton(
    ChangeRadioButtonEvent event,
    Emitter<KeyStrengthState> emit,
  ) {
    emit(state.copyWith(radioGroup: event.value));
  }

  List<String> fillRadioList() {
    return [
      "leadership and management",
      "technical or it",
      "communication interpersonal skill",
      "creativity problem solving",
      "others",
    ];
  }

  _onInitialize(
    KeyStrengthInitialEvent event,
    Emitter<KeyStrengthState> emit,
  ) async {
    emit(state.copyWith(
        designcreative: false,
        radioGroup: "",
        radioGroup1: "",
        radioGroup2: "",
        radioGroup3: "",
        radioGroup4: "",
    ));
    emit(state.copyWith(
        keyStrengthModelObj: state.KeyStrengthModelObj
            ?.copyWith(radioList: fillRadioList())));
  }
}
