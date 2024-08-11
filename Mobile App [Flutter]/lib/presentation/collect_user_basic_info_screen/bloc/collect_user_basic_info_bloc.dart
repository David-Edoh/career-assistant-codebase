import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../core/utils/long_wait_animation_provider.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/loginAuth/post_login_auth_resp.dart';
import '../../../data/models/resume/user_resume_details.dart';
import '/core/app_export.dart';
import '../models/experience_item_model.dart';
import 'package:fotisia/presentation/resume_edit_screen/models/resume_edit_model.dart';
part 'collect_user_basic_info_event.dart';
part 'collect_user_basic_info_state.dart';


/// A bloc that manages the state of a ResumeEdit according to the event that is dispatched to it.
class CollectBasicUserInfoBloc
    extends Bloc<CollectBasicUserInfoEvent, CollectBasicUserInfoState> {
  CollectBasicUserInfoBloc(super.initialState) {
    on<InitializeCollectBasicUserInfoEvent>(_onInitialize);
    on<SetSelectedImage>(setSelectedImage);
    on<SaveCollectedUserInfoEvent>(saveResumeDetails);
    on<SetResumeData>(_setResumeData);
  }

  final _apiClient = ApiClient();

  _setResumeData(
      SetResumeData event,
      Emitter<CollectBasicUserInfoState> emit,
      ) async {
      emit(state.copyWith(uploadedResume: event.resumeData));
  }


  setSelectedImage(
      SetSelectedImage event,
      Emitter<CollectBasicUserInfoState> emit,
      ) async {
    try {
      // Read the file as bytes
      List<int> fileBytes = await File(event.value).readAsBytes();

      // Encode the file bytes to base64
      String base64String = base64Encode(fileBytes);
      emit(state.copyWith(userPicture: base64String));
    } catch (e) {
      print("Error converting file to base64: $e");
      return null;
    }
  }

  saveResumeDetails(
      SaveCollectedUserInfoEvent event,
      Emitter<CollectBasicUserInfoState> emit,
      ) async {
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
          "hobbies": state.hobbiesController?.getTags,
          "disability": state.disabilityController?.text,
          "phoneNumber": state.phoneController?.text,
          "address": state.locationController?.text,
          "uploadedResume": state.uploadedResume
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
          NavigatorService.pushNamed(
            AppRoutes.homeContainerScreen,
          );
          // event.onSaveUserDetailsSuccess?.call();
        }).onError((error, stackTrace) {
          //implement error call
          event.onSaveUserDetailsError?.call();
        });
  }

  _onInitialize(
    InitializeCollectBasicUserInfoEvent event,
    Emitter<CollectBasicUserInfoState> emit,
  ) async {
    emit(state.copyWith(
          disabilityController: TextEditingController(),
          phoneController: TextEditingController(),
          locationController: TextEditingController(),
        ));
  }

  List<ExperienceItemModel> fillResumeItemList() {
    return List.generate(3, (index) => ExperienceItemModel());
  }
}
