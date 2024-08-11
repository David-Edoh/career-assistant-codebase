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
import '../models/new_social_link_model.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/new_position_screen/models/new_position_model.dart';
part 'new_social_link_event.dart';
part 'new_social_link_state.dart';

/// A bloc that manages the state of a NewPosition according to the event that is dispatched to it.
class NewSocialLinkBloc extends Bloc<NewSocialLinkEvent, NewSocialLinkState> {
  NewSocialLinkBloc(NewSocialLinkState initialState) : super(initialState) {
    on<NewSocialLinkInitialEvent>(_onInitialize);
    on<ChangeDropDownEvent>(_changeDropDown);
    on<SaveSocialLinkEvent>(_saveSocialLink);
  }

  final _apiClient = ApiClient();

  _changeDropDown(
    ChangeDropDownEvent event,
    Emitter<NewSocialLinkState> emit,
  ) {
    // emit(state.copyWith(selectedDropDownValue: event.value));
  }

  _saveSocialLink(
      SaveSocialLinkEvent event,
      Emitter<NewSocialLinkState> emit,
      ) async {
    try{
      Social project = Social(
        name: state.socialNameController?.text,
        url: state.socialLinkController?.text,
        username: state.socialUsernameController?.text,
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
        project.id = userResumeDetails.socials!.length;
        userResumeDetails.socials!.add(project);

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
        userResumeDetails.socials!.firstWhere((element) => element.id == itemId).name = state.socialNameController?.text;
        userResumeDetails.socials!.firstWhere((element) => element.id == itemId).url = state.socialLinkController?.text;
        userResumeDetails.socials!.firstWhere((element) => element.id == itemId).username = state.socialUsernameController?.text;

        //Save updated userResumeData to local storage
        userResumeData = userResumeDetails.toJson();
        print(userResumeData);
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
    NewSocialLinkInitialEvent event,
    Emitter<NewSocialLinkState> emit,
  ) async {
    emit(state.copyWith(
      socialNameController: TextEditingController(),
      socialLinkController: TextEditingController(),
      socialUsernameController: TextEditingController(),
      screenTitle: "New Social Link",
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

      Social? social = userResumeDetails.socials?.firstWhere((element) => element.id == itemId);

      emit(
          state.copyWith(
            socialNameController: TextEditingController.fromValue(TextEditingValue(text: social!.name ?? "")),
            socialLinkController: TextEditingController.fromValue(TextEditingValue(text: social!.url ?? "")),
            socialUsernameController: TextEditingController.fromValue(TextEditingValue(text: social!.username ?? "")),
            screenTitle: "Edit Social Link",
          )
      );
    }

    emit(state.copyWith(
        newSocialLinkModelObj: state.newSocialLinkModelObj
            ?.copyWith(dropdownItemList: fillDropdownItemList())));
  }
}
