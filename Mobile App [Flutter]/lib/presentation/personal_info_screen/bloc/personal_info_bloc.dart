import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/resume/user_resume_details.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/personal_info_screen/models/personal_info_model.dart';
import 'package:fotisia/data/models/me/get_me_resp.dart';
import 'dart:async';
import 'package:fotisia/data/repository/repository.dart';
part 'personal_info_event.dart';
part 'personal_info_state.dart';

/// A bloc that manages the state of a PersonalInfo according to the event that is dispatched to it.
class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  PersonalInfoBloc(PersonalInfoState initialState) : super(initialState) {
    on<PersonalInfoInitialEvent>(_onInitialize);
    // on<FetchMeEvent>(_callFetchMe);
    on<SetSelectedImage>(setSelectedImage);
    on<SaveProfileDetailsEvent>(saveUserResumeDetail);
  }

  final _apiClient = ApiClient();

  var getMeResp = GetMeResp();

  /// Calls the https://nodedemo.dhiwise.co/device/api/v1/user/me API and triggers a [FetchMeEvent] event on the [PersonalInfoBloc] bloc.
  ///
  /// The [BuildContext] parameter represents current [BuildContext]
  _onInitialize(
    PersonalInfoInitialEvent event,
    Emitter<PersonalInfoState> emit,
  ) async {
    const storage = FlutterSecureStorage();
    String? userDataJsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(userDataJsonString.toString());

    // (Hack) empty data list gets converted to string and doesn't cast back to array, so we manually check and fix this
    if (userData["experiences"] == "[]") userData["experiences"] = [];
    if (userData["educations"] == "[]") userData["educations"] = [];
    if (userData["projects"] == "[]") userData["projects"] = [];
    if (userData["references"] == "[]") userData["references"] = [];
    if (userData["socials"] == "[]") userData["socials"] = [];
    if (userData["skills"] == "[]") userData["skills"] = <String>[];

    emit(
        state.copyWith(
          firstNameController: TextEditingController.fromValue(TextEditingValue(text: userData["firstName"] ?? "")),
          lastNameController: TextEditingController.fromValue(TextEditingValue(text: userData["lastName"] ?? "")),
          emailController: TextEditingController.fromValue(TextEditingValue(text: userData["email"] ?? "")),
          picturePath: userData["picturePath"],
        )
    );
  }

  setSelectedImage(
      SetSelectedImage event,
      Emitter<PersonalInfoState> emit,
      ) async {
    try {
      // Read the file as bytes
      List<int> fileBytes = await File(event.value).readAsBytes();

      // Encode the file bytes to base64
      String base64String = base64Encode(fileBytes);
      emit(state.copyWith(userPicture: base64String));
    } catch (e) {
      debugPrint("Error converting file to base64: $e");
      return null;
    }
  }

  saveUserResumeDetail(
      SaveProfileDetailsEvent event,
      Emitter<PersonalInfoState> emit,
      ) async {
    try{
      // Get users resume data from device storage so we can update it
      const storage = FlutterSecureStorage();
      String? userDataJsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(userDataJsonString.toString());

      // (Hack) empty data list gets converted to string and doesn't cast back to array, so we manually check and fix this
      if (userData["experiences"] == "[]") userData["experiences"] = [];
      if (userData["educations"] == "[]") userData["educations"] = [];
      if (userData["projects"] == "[]") userData["projects"] = [];
      if (userData["references"] == "[]") userData["references"] = [];
      if (userData["socials"] == "[]") userData["socials"] = [];
      if (userData["skills"] == "[]") userData["skills"]  = <String>[];

      userData["firstName"] = state.firstNameController?.text;
      userData["lastName"] = state.lastNameController?.text;
      userData["email"] = state.emailController?.text;

      //Save updated user data back to storage
      await storage.write(key: "userData", value: json.encode(userData));

      userData["userPicture"] = state.userPicture;
      await _apiClient.postData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          path: "api/user/profile/${userData['id']}",
          requestData: userData
      ).then((value) async {

        await _apiClient.fetchMe();
        Fluttertoast.showToast(msg: "Resume details saved", toastLength: Toast.LENGTH_LONG);
        NavigatorService.goBack();

      }).onError((error, stackTrace) {

        print(error);
        Fluttertoast.showToast(msg: "Error saving resume details", toastLength: Toast.LENGTH_LONG);
        // event.onSaveUserDetailsError?.call();
      });

      // event.onSaveUserDetailsSuccess?.call();
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: "Error saving resume details", toastLength: Toast.LENGTH_LONG);
      // event.onSaveUserDetailsError?.call();
    }
  }

}
