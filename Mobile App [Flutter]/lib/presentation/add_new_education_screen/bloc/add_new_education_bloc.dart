import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/resume/user_resume_details.dart';
import '../../resume_edit_screen/bloc/resume_edit_bloc.dart';
import '../../resume_edit_screen/models/resume_edit_model.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/add_new_education_screen/models/add_new_education_model.dart';

part 'add_new_education_event.dart';

part 'add_new_education_state.dart';

/// A bloc that manages the state of a AddNewEducation according to the event that is dispatched to it.
class AddNewEducationBloc
    extends Bloc<AddNewEducationEvent, AddNewEducationState> {
  AddNewEducationBloc(AddNewEducationState initialState) : super(initialState) {
    on<AddNewEducationInitialEvent>(_onInitialize);
    on<SaveEducationEvent>(_saveEducation);
    on<SetStartDate>(setStartDate);
    on<SetEndDate>(setEndDate);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
  }

  final _apiClient = ApiClient();

  _changeCheckBox(
      ChangeCheckBoxEvent event,
      Emitter<AddNewEducationState> emit,
      ) {
    emit(state.copyWith(currentlySchoolHere: event.value));
  }

  setStartDate(
      SetStartDate event,
      Emitter<AddNewEducationState> emit,
      ) {
    print("Set start date");
    DateTime? dateTime = event.startDate;
    String startDateLabel = "${dateTime?.day.toString()}/${dateTime?.month.toString()}/${dateTime?.year.toString()}";
    emit(state.copyWith(
      startDate: event.startDate,
      startDateLabel: startDateLabel,
    ));
  }

  setEndDate(
      SetEndDate event,
      Emitter<AddNewEducationState> emit,
      ) {
    DateTime? dateTime = event.endDate;
    String endDateLabel = "${dateTime?.day.toString()}/${dateTime?.month.toString()}/${dateTime?.year.toString()}";

    emit(state.copyWith(
      endDateLabel: endDateLabel,
      endDate: dateTime,
    ));
  }

  _saveEducation(
      SaveEducationEvent event,
      Emitter<AddNewEducationState> emit,
      ) async {
        try{
            // Validate that startDate and endDate has been selected else return and prompt user.
            if(state.startDate == null || (state.endDate == null && state.currentlySchoolHere == false))
            {
              Fluttertoast.showToast(msg: "Provide start and end dates", toastLength: Toast.LENGTH_LONG);
              return;
            }

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
            if (userResumeData["skills"] == "[]") userResumeData["skills"] = <String>[];
            if (userResumeData["trainings_courses_certifications"] == "[]" || userResumeData["trainings_courses_certifications"] == null) userResumeData["trainings_courses_certifications"] = [];

            //Get users date from local storage
            String? jsonString = await storage.read(key: "userData");
            Map<String, dynamic> userData = json.decode(jsonString.toString());

            //Update resume education list by adding the new education item.
            UserResumeDetails userResumeDetails = UserResumeDetails.fromJson(userResumeData);

            String? itemIdString = await storage.read(key: "itemId");
            if(itemIdString == null)
            {
              // Create a new education object.
              Education education = Education(
                school: state.schoolNameController?.text,
                level: state.educationLevelController?.text,
                discipline: state.disciplineController?.text,
                currentlySchoolHere: state.currentlySchoolHere,
                startDate: "${state.startDate!.day.toString()}/${state.startDate!.month.toString()}/${state.startDate!.year.toString()}",
                endDate: "${state.endDate!.day.toString()}/${state.endDate!.month.toString()}/${state.endDate!.year.toString()}",
              );

              userResumeDetails.educations!.add(education);

              //Save user resume Data back to storage
              userResumeData = userResumeDetails.toJson();
              // await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));
              await storage.write(key: "userResumeData", value: json.encode(userResumeData));

              //Call initialize function to refresh page
              ResumeEditBloc(ResumeEditState(resumeEditModelObj: CollectBasicUserInfoModel(), skillsController: TextfieldTagsController())).add(ResumeEditInitialEvent());

              //Make request to save updated data to the database.
              await _apiClient.postData(
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization': "Bearer ${userData['accessToken']}"
                  },
                  path: "api/resume/user/create_education/${userData['id']}",
                  requestData: education.toJson()
              ).then((value) async {
                //
                print(value);
              }).onError((error, stackTrace) {
                print(error);
                event.onSaveUserDetailsError?.call();
              });

              event.onSaveUserDetailsSuccess?.call();
            }
            else if(itemIdString != null)
            {
              ///This is an update item operation
              //Update experience in local storage
              int itemId = int.parse(itemIdString);
              userResumeDetails.educations!.firstWhere((element) => element.id == itemId).school = state.schoolNameController?.text;
              userResumeDetails.educations!.firstWhere((element) => element.id == itemId).level = state.educationLevelController?.text;
              userResumeDetails.educations!.firstWhere((element) => element.id == itemId).discipline = state.disciplineController?.text;
              userResumeDetails.educations!.firstWhere((element) => element.id == itemId).startDate = "${state.startDate!.day.toString()}/${state.startDate!.month.toString()}/${state.startDate!.year.toString()}";
              userResumeDetails.educations!.firstWhere((element) => element.id == itemId).endDate = "${state.endDate!.day.toString()}/${state.endDate!.month.toString()}/${state.endDate!.year.toString()}";
              userResumeDetails.educations!.firstWhere((element) => element.id == itemId).currentlySchoolHere = state.currentlySchoolHere;

              //Save updated userResumeData to local storage
              userResumeData = userResumeDetails.toJson();
              print(userResumeData);
              // await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));
              await storage.write(key: "userResumeData", value: json.encode(userResumeData));

              // post updates experience detail to the backend
              await _apiClient.postData(
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization': "Bearer ${userData['accessToken']}"
                  },
                  path: "api/resume/user/update_education/${userData['id']}/$itemId",
                  requestData: userResumeDetails.educations!.firstWhere((element) => element.id == itemId).toJson()
              ).then((value) async {
                //
                print(value);
              }).onError((error, stackTrace) {
                print(error);
                event.onSaveUserDetailsError?.call();
              });

              event.onSaveUserDetailsSuccess?.call();
            }
        } catch(e) {
            event.onSaveUserDetailsError?.call();
        }
  }


  _onInitialize(
    AddNewEducationInitialEvent event,
    Emitter<AddNewEducationState> emit,
  ) async {

    emit(state.copyWith(
        schoolNameController: TextEditingController(),
        disciplineController: TextEditingController(),
        educationLevelController: TextEditingController(),
        descriptionController: TextEditingController(),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        screenTitle: "Add New Education"
    ));

    // Check if user want to edit an existing item and prefill form
    const storage = FlutterSecureStorage();
    String? selectedItemId = await storage.read(key: "itemId");
    if(selectedItemId != null)
    {
      print(int.parse(selectedItemId));
      int itemId = int.parse(selectedItemId);
      String? userDataJsonString = await storage.read(key: "userResumeData");
      Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());

      if (userResumeData["experiences"] == "[]") userResumeData["experiences"] = [];
      if (userResumeData["educations"] == "[]") userResumeData["educations"] = [];
      if (userResumeData["projects"] == "[]") userResumeData["projects"] = [];
      if (userResumeData["references"] == "[]") userResumeData["references"] = [];
      if (userResumeData["socials"] == "[]") userResumeData["socials"] = [];
      if (userResumeData["skills"] == "[]") userResumeData["skills"] = <String>[];
      if (userResumeData["trainings_courses_certifications"] == "[]" || userResumeData["trainings_courses_certifications"] == null) userResumeData["trainings_courses_certifications"] = [];

      UserResumeDetails userResumeDetails = UserResumeDetails.fromJson(userResumeData);

      Education? education = userResumeDetails.educations?.firstWhere((element) => element.id == itemId);

      emit(
          state.copyWith(
            schoolNameController: TextEditingController.fromValue(TextEditingValue(text: education!.school ?? "")),
            educationLevelController: TextEditingController.fromValue(TextEditingValue(text: education!.level ?? "")),
            disciplineController: TextEditingController.fromValue(TextEditingValue(text: education!.discipline ?? "")),
            startDateLabel: education!.startDate.toString(),
            endDateLabel: education!.endDate.toString(),
            currentlySchoolHere: education.currentlySchoolHere,
            startDate: parseDateString(education!.startDate.toString()),
            endDate: parseDateString(education!.endDate.toString()),
            screenTitle: "Edit Position",
          )
      );
    }
  }

  DateTime parseDateString(String dateString) {
    List<String> dateParts = dateString.split('/');

    // Make sure the string is in the correct format
    if (dateParts.length != 3) {
      throw FormatException("Invalid date format");
    }

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }
}
