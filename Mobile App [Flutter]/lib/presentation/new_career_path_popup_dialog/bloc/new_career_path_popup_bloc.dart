import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/HomePage/career_suggestion_resp.dart';
import '../../../data/models/HomePage/user_roadmap_resp.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/logout_popup_dialog/models/logout_popup_model.dart';
part 'new_career_path_popup_event.dart';
part 'new_career_path_popup_state.dart';

/// A bloc that manages the state of a LogoutPopup according to the event that is dispatched to it.
class NewCareerPathPopupBloc extends Bloc<NewCareerPathPopupEvent, NewCareerPathPopupState> {
  NewCareerPathPopupBloc(NewCareerPathPopupState initialState) : super(initialState) {
    on<NewCareerPathPopupInitialEvent>(_onInitialize);
    on<GenerateNewCareerPathEvent>(_generateNewCareerPath);
  }
  final _apiClient = ApiClient();

  _generateNewCareerPath(
      GenerateNewCareerPathEvent event,
      Emitter<NewCareerPathPopupState> emit,
      ) async {

    if(state.careerNameController!.text.isEmpty){
      Fluttertoast.showToast(msg: "Please enter a career, career field cannot be empty.");
      return;
    }

    var storage = const FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/careersuggestions/generate-roadmap/${userData['id']}";

    await _apiClient.postData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        requestData: {
          "career": state.careerNameController?.text
        }
    ).then((value) async {
      CareerRoadmapResponseObject getCareerRoadmapResp = CareerRoadmapResponseObject.fromJson(value);
      debugPrint(getCareerRoadmapResp.careerRoadmap?.description);

      if(getCareerRoadmapResp.careerRoadmap != null) {
        print("User's roadmap created");
        NavigatorService.popAndPushNamed(AppRoutes.careerRoadmap,
            arguments: {
              'career': getCareerRoadmapResp!.careerRoadmap as CareerToChooseFrom
            });
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      print(error);
    });
  }

  _onInitialize(
    NewCareerPathPopupInitialEvent event,
    Emitter<NewCareerPathPopupState> emit,
  ) async {
    emit(
        state.copyWith(
          careerNameController: TextEditingController()
        )
    );
  }
}
