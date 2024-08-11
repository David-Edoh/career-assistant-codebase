import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/loginAuth/post_login_auth_resp.dart';
import '../../../data/models/resume/user_resume_details.dart';
import '/core/app_export.dart';
import '../models/chipviewskills_item_model.dart';
import '../models/profile_item_model.dart';
import 'package:fotisia/presentation/my_profile_page/models/profile_model.dart';
part 'profile_event.dart';
part 'profile_state.dart';

/// A bloc that manages the state of a Profile according to the event that is dispatched to it.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<ProfileInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<UpdateChipViewEvent>(_updateChipView);
    on<GetUserResumeDataEvent>(_getUserResume);
  }
  final _apiClient = ApiClient();

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(opentowork: event.value));
  }

  _getUserResume(
      GetUserResumeDataEvent event,
      Emitter<ProfileState> emit,
      ) async {
    await getResumeDetails(event, emit);
  }

  _updateChipView(
    UpdateChipViewEvent event,
    Emitter<ProfileState> emit,
  ) {
    List<ChipviewskillsItemModel> newList = List<ChipviewskillsItemModel>.from(
        state.profileModelObj!.chipviewskillsItemList);
    newList[event.index] =
        newList[event.index].copyWith(isSelected: event.isSelected);
    emit(state.copyWith(
        profileModelObj:
            state.profileModelObj?.copyWith(chipviewskillsItemList: newList)));
  }

  List<ChipviewskillsItemModel> fillChipviewskillsItemList() {
    return List.generate(8, (index) => ChipviewskillsItemModel());
  }

  List<ProfileItemModel> fillProfileItemList() {
    return List.generate(3, (index) => ProfileItemModel());
  }

  _onInitialize(
    ProfileInitialEvent event,
    Emitter<ProfileState> emit,
  ) async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    await _apiClient.fetchMe();

    emit(state.copyWith(
      firstName: userData["firstName"],
      lastName: userData["lastName"],
      email: userData["email"],
      picturePath: userData["picturePath"],
    ));
  }

  FutureOr<void> getResumeDetails( ProfileEvent event, Emitter<ProfileState> emit, {bool getUpdated = true}) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/resume/user/${userData['id']}";
    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false
    ).then((value) async {
        try{
          await saveToSecureStorage(value);
          UserResumeDetails userResumeObject = UserResumeDetails.fromJson(value['userResumeDetails']);

          emit(
              state.copyWith(
                phone: userResumeObject.phoneNumber ?? "Add phone number",
                aboutMe: userResumeObject.about ?? "Add about me",
                location: userResumeObject.address ?? "Add address",
                website: userResumeObject.website ?? "Add website",
                skills: userResumeObject.skills,
                experiences: userResumeObject.experiences,
                educations: userResumeObject.educations,
                projects: userResumeObject.projects,
                references: userResumeObject.references,
                socials: userResumeObject.socials,
                // picturePath: userResumeObject.userPicture,
                fetchingCareerDetailsDone: true,
                careerTitle: userResumeObject.specialization
              )
          );

          if(getUpdated) await _apiClient.getUpdate(getResumeDetails, path, emit, event);
          return;
      }catch (e){
        print(e);
      }
    }).onError((error, stackTrace) {
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }

  FutureOr<void> saveToSecureStorage(Map<String, dynamic> jsonString) async {
    const storage = FlutterSecureStorage();
    jsonString['userResumeDetails']['about'] = jsonString['userResumeDetails']['about'].toString().replaceAll(",", "");
    await storage.write(key: "userResumeData", value: json.encode(jsonString['userResumeDetails']));
    // await storage.write(key: "userResumeData", value: _convertToJsonStringQuotes(raw: jsonString['userResumeDetails'].toString()));
  }

}
