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
import '../models/new_reference_model.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/new_position_screen/models/new_position_model.dart';
part 'new_reference_event.dart';
part 'new_reference_state.dart';

/// A bloc that manages the state of a NewPosition according to the event that is dispatched to it.
class NewReferenceBloc extends Bloc<NewReferenceEvent, NewReferenceState> {
  NewReferenceBloc(NewReferenceState initialState) : super(initialState) {
    on<NewReferenceInitialEvent>(_onInitialize);
    on<ChangeDropDownEvent>(_changeDropDown);
    on<SaveReferenceEvent>(_saveReference);
  }

  final _apiClient = ApiClient();

  _changeDropDown(
    ChangeDropDownEvent event,
    Emitter<NewReferenceState> emit,
  ) {
    emit(state.copyWith(selectedDropDownValue: event.value));
  }

  _saveReference(
      SaveReferenceEvent event,
      Emitter<NewReferenceState> emit,
      ) async {
      try{
        if(state.companyController == null || state.fullNameController == null)
        {
          Fluttertoast.showToast(msg: "Provide start and end dates", toastLength: Toast.LENGTH_LONG);
          return;
        }

        Reference reference = Reference(
          name: state.fullNameController?.text,
          company: state.companyController?.text,
          position: state.jobTitleController?.text,
          phoneNumber: state.phoneNumberController?.text,
          email: state.emailController?.text,
          address: state.addressController?.text,
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
          reference.id = userResumeDetails.references!.length;
          userResumeDetails.references!.add(reference);

          userResumeData = userResumeDetails.toJson();

          await storage.write(key: "userResumeData", value: convertToJsonStringQuotes(raw: userResumeData.toString()));
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
          userResumeDetails.references!.firstWhere((element) => element.id == itemId).name = state.fullNameController?.text;
          userResumeDetails.references!.firstWhere((element) => element.id == itemId).company = state.companyController?.text;
          userResumeDetails.references!.firstWhere((element) => element.id == itemId).position = state.jobTitleController?.text;
          userResumeDetails.references!.firstWhere((element) => element.id == itemId).email = state.emailController?.text;
          userResumeDetails.references!.firstWhere((element) => element.id == itemId).address = state.addressController?.text;

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
    NewReferenceInitialEvent event,
    Emitter<NewReferenceState> emit,
  ) async {
    emit(state.copyWith(
      fullNameController: TextEditingController(),
      jobTitleController: TextEditingController(),
      addressController: TextEditingController(),
      companyController: TextEditingController(),
      phoneNumberController: TextEditingController(),
      emailController: TextEditingController(),
      screenTitle: "Add New Reference"
    ));

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

      Reference? reference = userResumeDetails.references?.firstWhere((element) => element.id == itemId);

      emit(
          state.copyWith(
            fullNameController: TextEditingController.fromValue(TextEditingValue(text: reference!.name ?? "")),
            jobTitleController: TextEditingController.fromValue(TextEditingValue(text: reference!.position ?? "")),
            addressController:  TextEditingController.fromValue(TextEditingValue(text: reference!.address ?? "")),
            companyController:  TextEditingController.fromValue(TextEditingValue(text: reference!.company ?? "")),
            phoneNumberController:  TextEditingController.fromValue(TextEditingValue(text: reference!.phoneNumber ?? "")),
            emailController:  TextEditingController.fromValue(TextEditingValue(text: reference!.email ?? "")),
            screenTitle: "Edit Reference",
          )
      );
    }


    emit(state.copyWith(
        newReferenceModelObj: state.newReferenceModelObj
            ?.copyWith(dropdownItemList: fillDropdownItemList())));
  }
}
