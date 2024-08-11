import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/splash_screen/models/splash_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
part 'splash_event.dart';
part 'splash_state.dart';

/// A bloc that manages the state of a Splash according to the event that is dispatched to it.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(SplashState initialState) : super(initialState) {
    on<SplashInitialEvent>(_onInitialize);
  }

  _onInitialize(
    SplashInitialEvent event,
    Emitter<SplashState> emit,
  ) async {

    Future.delayed(const Duration(milliseconds: 100), () async {
      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      try {
        Map<String, dynamic> userData = json.decode(jsonString.toString());
        if (userData['accessToken'] != null) {
          if (userData['careerGoal'] == null || userData['careerGoal'] == "" || userData['careerGoal'] == "null") {
            NavigatorService.popAndPushNamed(
              AppRoutes.onboardingOneScreen,
            );
          } else {
            NavigatorService.popAndPushNamed(
              AppRoutes.homeContainerScreen,
            );
          }
        } else {
          NavigatorService.popAndPushNamed(
            AppRoutes.loginScreen,
          );
        }
      } catch (error, stackTrace) {
        NavigatorService.popAndPushNamed(
          AppRoutes.loginScreen,
        );
      }
    });
  }
}
