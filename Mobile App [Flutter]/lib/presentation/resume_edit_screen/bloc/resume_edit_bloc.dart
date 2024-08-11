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
import 'package:fotisia/presentation/resume_edit_screen/models/resume_edit_model.dart';
part 'resume_edit_event.dart';
part 'resume_edit_state.dart';

/// A bloc that manages the state of a ResumeEdit according to the event that is dispatched to it.
class ResumeEditBloc
    extends Bloc<ResumeEditEvent, ResumeEditState> {
  ResumeEditBloc(ResumeEditState initialState)
      : super(initialState) {
    on<ResumeEditInitialEvent>(_onInitialize);
    on<PreviewResumeDetailsEvent>(previewUserResumeDetail);
    on<DeleteItemEvent>(deleteItem);
    on<SetSelectedImage>(setSelectedImage);
    on<TempSaveResumeDetailsEvent>(tempSaveResumeDetails);
  }

  final _apiClient = ApiClient();


  setSelectedImage(
      SetSelectedImage event,
      Emitter<ResumeEditState> emit,
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

  tempSaveResumeDetails(
      TempSaveResumeDetailsEvent event,
      Emitter<ResumeEditState> emit,
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
      userResumeDetails.firstName = state.firstNameController?.text;
      userResumeDetails.lastName = state.lastNameController?.text;
      // userResumeDetails.preferredDesignation = state.preferredDesignationController?.text;
      userResumeDetails.specialization = state.preferredDesignationController?.text;
      userResumeDetails.email = state.emailController?.text;
      userResumeDetails.phoneNumber = state.phoneController?.text;
      userResumeDetails.website = state.websiteController?.text;
      userResumeDetails.about = state.aboutMeController?.text;
      userResumeDetails.address = state.locationController?.text;
      userResumeDetails.skills = state.skillsController?.getTags;
      userResumeDetails.userPicture = state.userPicture;
      userResumeDetails.picturePath = state.picturePath;

      //Save updated user resume data back to storage
      userResumeData = userResumeDetails.toJson();

      await storage.write(key: "userResumeData", value: json.encode(userResumeData));

    }
    catch(e){
      print(e);
    }
  }

  _onInitialize(
    ResumeEditInitialEvent event,
    Emitter<ResumeEditState> emit,
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

    if(state.skillsController.getTags!.isEmpty)
    {
      for(int i = 0; i < skillsList.length; i++)
      {
        state.skillsController!.addTag = skillsList[i].toString();
      }
    }

    emit(
        state.copyWith(
          firstNameController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["firstName"] ?? "")),
          lastNameController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["lastName"] ?? "")),
          preferredDesignationController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["specialization"] ?? "")),
          emailController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["email"] ?? "")),
          phoneController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["phoneNumber"] ?? "")),
          aboutMeController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["about"] ?? "")),
          locationController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["address"] ?? "")),
          websiteController: TextEditingController.fromValue(TextEditingValue(text: userResumeData["website"] ?? "")),
          skills: skillsList,
          experiences: userResumeObject.experiences,
          educations: userResumeObject.educations,
          projects: userResumeObject.projects,
          references: userResumeObject.references,
          socials: userResumeObject.socials,
          picturePath: userResumeObject.picturePath,
        )
    );

  }

  /// This function is called when tha save button is pressed
  /// It collects form data and updates the localStorage and database.
  previewUserResumeDetail(
      PreviewResumeDetailsEvent event,
      Emitter<ResumeEditState> emit,
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
          userResumeDetails.firstName = state.firstNameController?.text;
          userResumeDetails.lastName = state.lastNameController?.text;
          userResumeDetails.specialization = state.preferredDesignationController?.text;
          userResumeDetails.email = state.emailController?.text;
          userResumeDetails.phoneNumber = state.phoneController?.text;
          userResumeDetails.website = state.websiteController?.text;
          userResumeDetails.about = state.aboutMeController?.text;
          userResumeDetails.address = state.locationController?.text;
          userResumeDetails.skills = state.skillsController?.getTags;
          userResumeDetails.userPicture = state.userPicture;
          userResumeDetails.picturePath = state.picturePath;

          //Save updated user resume data back to storage
          userResumeData = userResumeDetails.toJson();

          await storage.write(key: "userResumeData", value: json.encode(userResumeData));
          NavigatorService.goBack();
          // event.onSaveUserDetailsSuccess?.call();
      }
      catch(e){
          print(e);
        // event.onSaveUserDetailsError?.call();
      }
  }

  deleteItem(
      DeleteItemEvent event,
      Emitter<ResumeEditState> emit,
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
            // print(value);
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
        if (event.itemType == "Certification") userResumeDetails.trainings_courses_certifications?.removeWhere((element) => element.id == event.itemId);

        //Save user resume Data back to storage
        userResumeData = userResumeDetails.toJson();
        await storage.write(key: "userResumeData", value: json.encode(userResumeData));
        // await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));

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

  List<ExperienceItemModel> fillResumeItemList() {
    return List.generate(3, (index) => ExperienceItemModel());
  }
}
