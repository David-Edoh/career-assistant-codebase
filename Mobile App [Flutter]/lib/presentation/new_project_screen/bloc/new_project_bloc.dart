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
import '../models/new_project_model.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/new_position_screen/models/new_position_model.dart';
part 'new_project_event.dart';
part 'new_project_state.dart';

/// A bloc that manages the state of a NewPosition according to the event that is dispatched to it.
class NewProjectBloc extends Bloc<NewProjectEvent, NewProjectState> {
  NewProjectBloc(NewProjectState initialState) : super(initialState) {
    on<NewProjectInitialEvent>(_onInitialize);
    on<ChangeDropDownEvent>(_changeDropDown);
    on<SaveProjectEvent>(_saveProject);
    on<SetStartDate>(setStartDate);
    on<SetEndDate>(setEndDate);
  }

  final _apiClient = ApiClient();


  setStartDate(
      SetStartDate event,
      Emitter<NewProjectState> emit,
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
      Emitter<NewProjectState> emit,
      ) {
    DateTime? dateTime = event.endDate;
    String endDateLabel = "${dateTime?.day.toString()}/${dateTime?.month.toString()}/${dateTime?.year.toString()}";

    emit(state.copyWith(
      endDateLabel: endDateLabel,
      endDate: dateTime,
    ));
  }

  _changeDropDown(
    ChangeDropDownEvent event,
    Emitter<NewProjectState> emit,
  ) {
    emit(state.copyWith(selectedDropDownValue: event.value));
  }

  _saveProject(
      SaveProjectEvent event,
      Emitter<NewProjectState> emit,
      ) async {
    try{

      if(state.startDate == null || state.endDate == null)
      {
        Fluttertoast.showToast(msg: "Provide start and end dates", toastLength: Toast.LENGTH_LONG);
        return;
      }

      Project project = Project(
        title: state.projectTitleController?.text,
        description: state.projectDescriptionController?.text,
        startDate: "${state.startDate!.day.toString()}/${state.startDate!.month.toString()}/${state.startDate!.year.toString()}",
        endDate: "${state.endDate!.day.toString()}/${state.endDate!.month.toString()}/${state.endDate!.year.toString()}",
      );

      const storage = FlutterSecureStorage();
      String? userDataJsonString = await storage.read(key: "userResumeData");
      Map<String, dynamic> userResumeData = json.decode(userDataJsonString.toString());

      if (userResumeData["experiences"] == "[]" || userResumeData["experiences"] == null) userResumeData["experiences"] = [];
      if (userResumeData["educations"] == "[]" || userResumeData["educations"] == null) userResumeData["educations"] = [];
      if (userResumeData["projects"] == "[]" || userResumeData["projects"] == null) userResumeData["projects"] = [];
      if (userResumeData["references"] == "[]" || userResumeData["references"] == null) userResumeData["references"] = [];
      if (userResumeData["socials"] == "[]" || userResumeData["socials"] == null) userResumeData["socials"] = [];
      if (userResumeData["skills"] == "[]" || userResumeData["skills"] == null) userResumeData["skills"] = <String>[];
      if (userResumeData["trainings_courses_certifications"] == "[]" || userResumeData["trainings_courses_certifications"] == null) userResumeData["trainings_courses_certifications"] = [];

      UserResumeDetails userResumeDetails = UserResumeDetails.fromJson(userResumeData);
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());

      String? itemIdString = await storage.read(key: "itemId");
      if(itemIdString == null) {
        project.id = userResumeDetails.projects!.length;
        userResumeDetails.projects!.add(project);

        userResumeData = userResumeDetails.toJson();

        // await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));
        await storage.write(key: "userResumeData", value: json.encode(userResumeData));

        ResumeEditBloc(ResumeEditState(resumeEditModelObj: CollectBasicUserInfoModel(),
            skillsController: TextfieldTagsController())).add(
            ResumeEditInitialEvent());

        event.onSaveUserDetailsSuccess?.call();
      }
      else if(itemIdString != null)
      {
        ///This is an update item operation
        //Update experience in local storage
        int itemId = int.parse(itemIdString);
        userResumeDetails.projects!.firstWhere((element) => element.id == itemId).title = state.projectTitleController?.text;
        userResumeDetails.projects!.firstWhere((element) => element.id == itemId).description = state.projectDescriptionController?.text;
        userResumeDetails.projects!.firstWhere((element) => element.id == itemId).startDate = "${state.startDate!.day.toString()}/${state.startDate!.month.toString()}/${state.startDate!.year.toString()}";
        userResumeDetails.projects!.firstWhere((element) => element.id == itemId).endDate = "${state.endDate!.day.toString()}/${state.endDate!.month.toString()}/${state.endDate!.year.toString()}";

        //Save updated userResumeData to local storage
        userResumeData = userResumeDetails.toJson();
        // await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));
        await storage.write(key: "userResumeData", value: json.encode(userResumeData));

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
    NewProjectInitialEvent event,
    Emitter<NewProjectState> emit,
  ) async {
      emit(state.copyWith(
          projectTitleController: TextEditingController(),
          projectDescriptionController: TextEditingController(),
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          screenTitle: "Add New Project"
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

        Project? project = userResumeDetails.projects?.firstWhere((element) => element.id == itemId);

        emit(
            state.copyWith(
              projectTitleController: TextEditingController.fromValue(TextEditingValue(text: project!.title ?? "")),
              projectDescriptionController: TextEditingController.fromValue(TextEditingValue(text: project!.description ?? "")),
              startDateLabel: project!.startDate.toString(),
              endDateLabel: project!.endDate.toString(),
              startDate: parseDateString(project!.startDate.toString()),
              endDate: parseDateString(project!.endDate.toString()),
              screenTitle: "Edit Project",
            )
        );
      }

    emit(state.copyWith(
        newProjectModelObj: state.newProjectModelObj
            ?.copyWith(dropdownItemList: fillDropdownItemList())));
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
