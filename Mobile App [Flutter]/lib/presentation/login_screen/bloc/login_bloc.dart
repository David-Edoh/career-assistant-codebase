import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../../../data/apiClient/api_client.dart';
import 'package:fotisia/data/models/loginAuth/post_login_auth_req.dart';
import 'package:fotisia/data/models/loginAuth/post_login_auth_resp.dart';
import 'package:fotisia/presentation/login_screen/models/login_model.dart';
import 'package:fotisia/data/repository/repository.dart';
import 'dart:async';
part 'login_event.dart';
part 'login_state.dart';

/// A bloc that manages the state of a Login according to the event that is dispatched to it.
class LoginBloc extends Bloc
<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState) {
    on<LoginInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<LoginAuthEvent>(_callLoginAuth);
    on<UseEmailEvent>(_useLoginEvent);
    on<UseSocialLoginEvent>(_useSocialLoginEvent);
    on<SocialLoginAuthEvent>(_socialLoginEvent);
    // on<LinkedInLoginAuthEvent>(_linkedinLoginEvent);
  }

  final _apiClient = ApiClient();
  final _repository = Repository();
  var postLoginAuthResp = PostLoginAuthResp();

  _changePasswordVisibility(
      ChangePasswordVisibilityEvent event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(isShowPassword: event.value));
  }

  _linkedinLoginEvent(
      LinkedInLoginAuthEvent event,
      Emitter<LoginState> emit,
      ){
      print("Linkedin login started");
  }

  _socialLoginEvent(
      SocialLoginAuthEvent event,
      Emitter<LoginState> emit,
      ) async {
        await _apiClient.postData(
            headers: {
              'Content-Type': 'application/json',
            },
            path: "api/auth/social/signin",
            requestData: event.user!.toJson(),
        ).then((value) async {
          print("Social login successful");
          print(value);

          PostLoginAuthResp.saveToSecureStorage(value);
          postLoginAuthResp = PostLoginAuthResp.fromJson(value);
          if (postLoginAuthResp?.user?.careerGoal == null ||
              postLoginAuthResp?.user?.careerGoal == "" ||
              postLoginAuthResp?.user?.careerGoal == "null") {
            NavigatorService.pushNamed(
              AppRoutes.onboardingOneScreen,
            );
          } else {
            _onLoginAuthSuccess(postLoginAuthResp, emit);
            event.onLoginEventSuccess?.call();
          }

          // Fluttertoast.showToast(msg: "Resume details saved", toastLength: Toast.LENGTH_LONG);
        }).onError((error, stackTrace) {
          print(error);
          // Fluttertoast.showToast(msg: "Error saving resume details", toastLength: Toast.LENGTH_LONG);
          // event.onSaveUserDetailsError?.call();
        });
    }

  _useSocialLoginEvent(
      UseSocialLoginEvent event,
      Emitter<LoginState> emit,
      ){
    emit(state.copyWith(useEmailLogin: false));
  }

  _useLoginEvent(
      UseEmailEvent event,
      Emitter<LoginState> emit,
      ){
      emit(state.copyWith(useEmailLogin: true));
    }

  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        isShowPassword: true
    ));
  }

  /// Calls [https://nodedemo.dhiwise.co/device/auth/register] with the provided event and emits the state.
  ///
  /// The [CreateRegisterEvent] parameter is used for handling event data
  /// The [emit] parameter is used for emitting the state
  ///
  /// Throws an error if an error occurs during the API call process.
  FutureOr<void> _callLoginAuth(
      LoginAuthEvent event,
      Emitter<LoginState> emit,
      ) async {

    final fcmToken = await FirebaseMessaging.instance.getToken();

    var postLoginAuthReq = PostLoginAuthReq(
      password: state.passwordController?.text ?? '',
      email: state.emailController?.text ?? '',
      fcmToken: fcmToken,
    );
    await _repository.loginDeviceAuth(
      headers: {
        'Content-Type': 'application/json',
      },
      requestData: postLoginAuthReq.toJson(),
    ).then((value) async {
      postLoginAuthResp = value;
      if (postLoginAuthResp?.user?.careerGoal == null ||
          postLoginAuthResp?.user?.careerGoal == "" ||
          postLoginAuthResp?.user?.careerGoal == "null") {
        NavigatorService.pushNamed(
          AppRoutes.onboardingOneScreen,
        );
      } else {
        _onLoginAuthSuccess(value, emit);
        event.onLoginEventSuccess?.call();
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      //implement error call
      if(error is PostLoginAuthResp)
      {
        _onLoginAuthError(error, emit);
        event.onLoginEventError?.call(error);
      }
      else
      {
        event.onLoginEventError?.call();
      }

    });
  }

  void _onLoginAuthSuccess(
      PostLoginAuthResp resp,
      Emitter<LoginState> emit,
      ) {
    PrefUtils().setId(resp.user?.id.toString() ?? '');
    emit(
      state.copyWith(
        loginModelObj:
        state.loginModelObj?.copyWith(),
      ),
    );
  }

  void _onLoginAuthError(
      PostLoginAuthResp resp,
      Emitter<LoginState> emit,
      ) {
    //implement error method body...
    PrefUtils().setId(resp.user?.id.toString() ?? '');
    emit(
      state.copyWith(
        loginModelObj:
        state.loginModelObj?.copyWith(),
      ),
    );
  }
}
// }
