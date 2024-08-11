import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/resume/user_resume_details.dart';
import '../../resume_edit_screen/bloc/resume_edit_bloc.dart';
import '../../resume_edit_screen/models/resume_edit_model.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/new_position_screen/models/new_position_model.dart';
import 'package:html_unescape/html_unescape.dart';
part 'new_position_event.dart';
part 'new_position_state.dart';

/// A bloc that manages the state of a NewPosition according to the event that is dispatched to it.
class NewPositionBloc extends Bloc<NewPositionEvent, NewPositionState> {
  NewPositionBloc(NewPositionState initialState) : super(initialState) {
    on<NewPositionInitialEvent>(_onInitialize);
    on<ChangeDropDownEvent>(_changeDropDown);
    on<SavePositionEvent>(_savePosition);
    on<SetStartDate>(setStartDate);
    on<SetEndDate>(setEndDate);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
  }

  final _apiClient = ApiClient();

  _changeCheckBox(
      ChangeCheckBoxEvent event,
      Emitter<NewPositionState> emit,
      ) {
    emit(state.copyWith(currentlyWorkHere: event.value));
  }

  _changeDropDown(
    ChangeDropDownEvent event,
    Emitter<NewPositionState> emit,
  ) {
    emit(state.copyWith(selectedDropDownValue: event.value));
  }

  setStartDate(
      SetStartDate event,
      Emitter<NewPositionState> emit,
      ) {
      DateTime? dateTime = event.startDate;
      String startDateLabel = "${dateTime?.day.toString()}/${dateTime?.month.toString()}/${dateTime?.year.toString()}";
      emit(state.copyWith(
          startDate: event.startDate,
          startDateLabel: startDateLabel,
      ));
  }

  setEndDate(
      SetEndDate event,
      Emitter<NewPositionState> emit,
      ) {
      DateTime? dateTime = event.endDate;
      String endDateLabel = "${dateTime?.day.toString()}/${dateTime?.month.toString()}/${dateTime?.year.toString()}";

      emit(state.copyWith(
          endDateLabel: endDateLabel,
          endDate: dateTime,
      ));
  }

  _savePosition(
      SavePositionEvent event,
      Emitter<NewPositionState> emit,
      ) async {
      try{

        if(state.startDate == null || (state.endDate == null && state.currentlyWorkHere == false))
        {
          Fluttertoast.showToast(msg: "Provide start and end dates", toastLength: Toast.LENGTH_LONG);
          return;
        }

        String? description = await state.richEditorController?.getText();
        if(description!.isEmpty)
        {
          Fluttertoast.showToast(msg: "Enter role description", toastLength: Toast.LENGTH_LONG);
          return;
        }

        const storage = FlutterSecureStorage();
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
        String? jsonString = await storage.read(key: "userData");
        Map<String, dynamic> userData = json.decode(jsonString.toString());

        String? itemIdString = await storage.read(key: "itemId");
        if(itemIdString == null)
        {
          ///This is an add new item operation
          //Create a new experience object
          String? description = await state.richEditorController?.getText();

          Experience experience = Experience(
            position: state.positionTitleController?.text,
            company: state.companyNameController?.text,
            address: state.locationController?.text,
            // description: state.jobDescriptionController?.text,
            description: description,
            startDate: "${state.startDate!.day.toString()}/${state.startDate!.month.toString()}/${state.startDate!.year.toString()}",
            endDate: "${state.endDate!.day.toString()}/${state.endDate!.month.toString()}/${state.endDate!.year.toString()}",
            currentlyWorkHere: state.currentlyWorkHere,
          );

          //Add new experience to local storage
          userResumeDetails.experiences!.add(experience);
          userResumeData = userResumeDetails.toJson();

          // await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));
          await storage.write(key: "userResumeData", value: json.encode(userResumeData));

          //Call initialize function to refresh page
          ResumeEditBloc(ResumeEditState(resumeEditModelObj: CollectBasicUserInfoModel(), skillsController: TextfieldTagsController())).add(ResumeEditInitialEvent());

          //Post new experience detail to the backend.
          await _apiClient.postData(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': "Bearer ${userData['accessToken']}"
              },
              path: "api/resume/user/create_experience/${userData['id']}",
              requestData: experience.toJson()
          ).then((value) async {
            //
            // print(value);
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
          String? description = await state.richEditorController?.getText();
          userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).position = state.positionTitleController?.text;
          userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).company = state.companyNameController?.text;
          userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).address = state.locationController?.text;
          userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).description = description;
          userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).startDate = "${state.startDate!.day.toString()}/${state.startDate!.month.toString()}/${state.startDate!.year.toString()}";
          userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).endDate = "${state.endDate!.day.toString()}/${state.endDate!.month.toString()}/${state.endDate!.year.toString()}";
          userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).currentlyWorkHere = state.currentlyWorkHere;

          //Save updated userResumeData to local storage
          userResumeData = userResumeDetails.toJson();
          // await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));
          await storage.write(key: "userResumeData", value: json.encode(userResumeData));

          // post updates experience detail to the backend
          await _apiClient.postData(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': "Bearer ${userData['accessToken']}"
              },
              path: "api/resume/user/update_experience/${userData['id']}/$itemId",
              requestData: userResumeDetails.experiences!.firstWhere((element) => element.id == itemId).toJson()
          ).then((value) async {
            //
            // print(value);
          }).onError((error, stackTrace) {
            print(error);
            event.onSaveUserDetailsError?.call();
          });

          event.onSaveUserDetailsSuccess?.call();
        }
    }
    catch(e){
      print(e);
      event.onSaveUserDetailsError?.call();
    }
  }

  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(id: 1, title: "Item One", isSelected: true),
      SelectionPopupModel(id: 2, title: "Item Two"),
      SelectionPopupModel(id: 3, title: "Item Three")
    ];
  }

  _onInitialize(
    NewPositionInitialEvent event,
    Emitter<NewPositionState> emit,
  ) async {
      emit(state.copyWith(
          positionTitleController: TextEditingController(),
          companyNameController: TextEditingController(),
          locationController: TextEditingController(),
          jobDescriptionController: TextEditingController(),
          richEditorController: QuillEditorController(),
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          screenTitle: "Add New Position"
        )
      );

      // Check if user want to edit an existing item and prefill form
      const storage = FlutterSecureStorage();
      String? selectedItemId = await storage.read(key: "itemId");
      if(selectedItemId != null)
      {
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

        Experience? experience = userResumeDetails.experiences?.firstWhere((element) => element.id == itemId);

        String description = HtmlUnescape().convert(experience!.description ?? "");

        emit(
            state.copyWith(
              positionTitleController: TextEditingController.fromValue(TextEditingValue(text: experience!.position ?? "")),
              companyNameController: TextEditingController.fromValue(TextEditingValue(text: experience!.company ?? "")),
              locationController: TextEditingController.fromValue(TextEditingValue(text: experience!.address ?? "")),
              jobDescriptionController: TextEditingController.fromValue(TextEditingValue(text: experience!.description ?? "")),
              initialDescription: description,
              startDateLabel: experience!.startDate.toString(),
              endDateLabel: experience!.endDate.toString(),
              currentlyWorkHere: experience.currentlyWorkHere,
              startDate: parseDateString(experience!.startDate.toString()),
              endDate: parseDateString(experience!.endDate.toString()),
              screenTitle: "Edit Position",
            )
        );
      }

      emit(state.copyWith(
          newPositionModelObj: state.newPositionModelObj
              ?.copyWith(dropdownItemList: fillDropdownItemList())
      ));
  }


  DateTime parseDateString(String dateString) {
    List<String> dateParts = dateString.split('/');

    // Make sure the string is in the correct format
    if (dateParts.length != 3) {
      throw const FormatException("Invalid date format");
    }

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }
}
