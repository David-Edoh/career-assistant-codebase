import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/apiClient/api_client.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/career_subjects_screen/models/career_subjects_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

part 'job_ad_event.dart';

part 'job_ad_state.dart';

/// A bloc that manages the state of a CareerSubjects according to the event that is dispatched to it.
class JobAdBloc extends Bloc<JobAdEvent, JobAdState>
    with CodeAutoFill {
  JobAdBloc(JobAdState initialState) : super(initialState) {
    on<JobAdInitialEvent>(_onInitialize);
    on<ChangeOTPEvent>(_changeOTP);
    on<GetQualificationScore>(_getQualificationScore);
  }

  final _apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }

  _getQualificationScore(
      GetQualificationScore event,
      Emitter<JobAdState> emit,
      ) async {

      emit(state.copyWith(
        gettingQualificationScore: true,
      ));

      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      String path = "api/resume/job-match-score/${userData['id']}";

      await _apiClient.postData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showProgress: false,
        requestData:{
          "job_ad": event.jobAd
        }
      ).then((value) async {
        print(value);

        emit(state.copyWith(
            qualificationScore: value["result"]["score"],
            // jobIsOpen: value["result"]["positionIsStillOpen"],
            explanation: value["result"]["explanation"],
            jobCompany: value["result"]["jobCompany"],
            jobTitle: value["result"]["jobTitle"],
            gettingQualificationScore: false,
        ));

        return;
      }).onError((error, stackTrace) {
        // TODO: implement error call
        //   event.onLoginEventError?.call();
      });
  }

  _changeOTP(
    ChangeOTPEvent event,
    Emitter<JobAdState> emit,
  ) {
    emit(
        state.copyWith(otpController: TextEditingController(text: event.code)));
  }

  _onInitialize(
    JobAdInitialEvent event,
    Emitter<JobAdState> emit,
  ) async {
    emit(state.copyWith(otpController: TextEditingController()));
    listenForCode();
  }
}
