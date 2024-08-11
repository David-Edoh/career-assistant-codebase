import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/resume/user_resume_details.dart';
import '/core/app_export.dart';
import '../models/experience_item_model.dart';
import 'package:fotisia/presentation/experience_setting_screen/models/experience_setting_model.dart';
part 'experience_setting_event.dart';
part 'experience_setting_state.dart';

/// A bloc that manages the state of a ExperienceSetting according to the event that is dispatched to it.
class ExperienceSettingBloc
    extends Bloc<ExperienceSettingEvent, ExperienceSettingState> {
  ExperienceSettingBloc(ExperienceSettingState initialState)
      : super(initialState) {
    on<ExperienceSettingInitialEvent>(_onInitialize);
    on<SaveResumeDetailsEvent>(saveUserResumeDetail);
    on<DeleteItemEvent>(deleteItem);
    on<SetSelectedImage>(setSelectedImage);
  }

  final _apiClient = ApiClient();

  _onInitialize(
    ExperienceSettingInitialEvent event,
    Emitter<ExperienceSettingState> emit,
  ) async {
    const storage = FlutterSecureStorage();
    String? userDataJsonString = await storage.read(key: "userResumeData");
    Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());

    // (Hack) empty data list gets converted to string and doesn't cast back to array, so we manually check and fix this
    if (userResumeData["experiences"] == "[]") userResumeData["experiences"] = [];
    if (userResumeData["educations"] == "[]") userResumeData["educations"] = [];
    if (userResumeData["projects"] == "[]") userResumeData["projects"] = [];
    if (userResumeData["references"] == "[]") userResumeData["references"] = [];
    if (userResumeData["socials"] == "[]") userResumeData["socials"] = [];
    if (userResumeData["skills"] == "[]") userResumeData["skills"] = <String>[];
    if (userResumeData["trainings_courses_certifications"] == "[]" || userResumeData["trainings_courses_certifications"] == null) userResumeData["trainings_courses_certifications"] = [];

    List<String> skillsList = (userResumeData["skills"] as List).map((skill) => skill.toString()).toList();

    UserResumeDetails userResumeObject = UserResumeDetails.fromJson(userResumeData);

    for(int i = 0; i < skillsList.length; i++)
    {
      state.skillsController!.addTag = skillsList[i].toString();
    }

    emit(
        state.copyWith(
          firstNameController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["firstName"] ?? "")),
          lastNameController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["lastName"] ?? "")),
          emailController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["email"] ?? "")),
          phoneController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["phoneNumber"] ?? "")),
          aboutMeController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["about"] ?? "")),
          locationController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["address"] ?? "")),
          websiteController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["website"] ?? "")),
          preferredDesignationController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["specialization"] ?? "")),
          skills: skillsList,
          experiences: userResumeObject.experiences,
          educations: userResumeObject.educations,
          projects: userResumeObject.projects,
          references: userResumeObject.references,
          socials: userResumeObject.socials,
          picturePath: userResumeObject.userPicture,
        )
    );
  }


  setSelectedImage(
      SetSelectedImage event,
      Emitter<ExperienceSettingState> emit,
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


  /// This function is called when tha save button is pressed
  /// It collects form data and updates the localStorage and database.
  saveUserResumeDetail(
      SaveResumeDetailsEvent event,
      Emitter<ExperienceSettingState> emit,
      ) async {
    try{
      // Get users resume data from device storage so we can update it
      const storage = FlutterSecureStorage();
      String? userDataJsonString = await storage.read(key: "userResumeData");
      Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());

      // (Hack) empty data list gets converted to string and doesn't cast back to array, so we manually check and fix this
      if (userResumeData["experiences"] == "[]") userResumeData["experiences"] = [];
      if (userResumeData["educations"] == "[]") userResumeData["educations"] = [];
      if (userResumeData["projects"] == "[]") userResumeData["projects"] = [];
      if (userResumeData["references"] == "[]") userResumeData["references"] = [];
      if (userResumeData["socials"] == "[]") userResumeData["socials"] = [];
      if (userResumeData["skills"] == "[]") userResumeData["skills"]  = <String>[];
      if (userResumeData["trainings_courses_certifications"] == "[]" || userResumeData["trainings_courses_certifications"] == null) userResumeData["trainings_courses_certifications"] = [];

      //Update details with what is in form controllers
      UserResumeDetails userResumeDetails = UserResumeDetails.fromJson(userResumeData);
      // userResumeDetails.firstName = state.firstNameController?.text;
      // userResumeDetails.lastName = state.lastNameController?.text;
      // userResumeDetails.email = state.emailController?.text;
      userResumeDetails.specialization = state.preferredDesignationController?.text;
      userResumeDetails.phoneNumber = state.phoneController?.text;
      userResumeDetails.website = state.websiteController?.text;
      userResumeDetails.about = state.aboutMeController?.text;
      userResumeDetails.address = state.locationController?.text;
      userResumeDetails.skills = state.skillsController?.getTags as List<String>?;
      userResumeDetails.userPicture = state.userPicture;

      //Save updated user resume data back to storage
      userResumeData = userResumeDetails.toJson();

      await storage.write(key: "userResumeData", value: json.encode(userResumeData));

      //Make request to save updated data to the database.
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());

      await _apiClient.postData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          path: "api/resume/user/${userData['id']}",
          requestData: userResumeData
      ).then((value) async {
        //
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
      // event.onSaveUserDetailsError?.call();
    }
  }

  deleteItem(
      DeleteItemEvent event,
      Emitter<ExperienceSettingState> emit,
      ) async {
    try{
      const storage = FlutterSecureStorage();
      String? userDataJsonString = await storage.read(key: "userResumeData");
      Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());

      // (Hack) empty data list gets converted to string and doesn't cast back to array, so we manually check and fix this
      if (userResumeData["experiences"] == "[]") userResumeData["experiences"] = [];
      if (userResumeData["educations"] == "[]") userResumeData["educations"] = [];
      if (userResumeData["projects"] == "[]") userResumeData["projects"] = [];
      if (userResumeData["references"] == "[]") userResumeData["references"] = [];
      if (userResumeData["socials"] == "[]") userResumeData["socials"] = [];
      if (userResumeData["skills"] == "[]") userResumeData["skills"]  = <String>[];
      if (userResumeData["trainings_courses_certifications"] == "[]" || userResumeData["trainings_courses_certifications"] == null) userResumeData["trainings_courses_certifications"] = [];

      //For experience and education, delete from backend also.
      if(event.itemType == "Experience" || event.itemType == "Education")
      {
        String? jsonString = await storage.read(key: "userData");
        Map<String, dynamic> userData = json.decode(jsonString.toString());

        await _apiClient.postData(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': "Bearer ${userData['accessToken']}"
            },
            path: "api/resume/user/${userData['id']}/delete_resume_detail_item",
            requestData: {"itemId": event.itemId, "itemType": event.itemType}
        ).then((value) async {
          //
        }).onError((error, stackTrace) {
          print(error);
          event.onDeleteItemError?.call();
        });
      }


      //Delete item from user resume data and save back to local storage
      UserResumeDetails userResumeDetails = UserResumeDetails.fromJson(userResumeData);

      if (event.itemType == "Experience") userResumeDetails.experiences?.removeWhere((element) => element.id == event.itemId);
      if (event.itemType == "Education") userResumeDetails.educations?.removeWhere((element) => element.id == event.itemId);
      if (event.itemType == "Project") userResumeDetails.projects?.removeWhere((element) => element.id == event.itemId);
      if (event.itemType == "Reference") userResumeDetails.references?.removeWhere((element) => element.id == event.itemId);
      if (event.itemType == "Social") userResumeDetails.socials?.removeWhere((element) => element.id == event.itemId);

      //Save user resume Data back to storage
      userResumeData = userResumeDetails.toJson();
      await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));

      //emit updated data
      emit(
          state.copyWith(
            experiences: userResumeDetails.experiences,
            educations: userResumeDetails.educations,
            projects: userResumeDetails.projects,
            references: userResumeDetails.references,
            socials: userResumeDetails.socials,
          )
      );
      event.onDeleteItemSuccess?.call();
    }
    catch(e){
      print(e);
      event.onDeleteItemError?.call();
    }
  }

  List<ExperienceItemModel> fillExperienceItemList() {
    return List.generate(3, (index) => ExperienceItemModel());
  }
}
