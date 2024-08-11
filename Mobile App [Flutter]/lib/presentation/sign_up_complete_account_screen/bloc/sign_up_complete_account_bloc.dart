import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/sign_up_complete_account_screen/models/sign_up_complete_account_model.dart';
import 'package:fotisia/data/models/registerDeviceAuth/post_register_device_auth_resp.dart';
import 'package:fotisia/data/models/registerDeviceAuth/post_register_device_auth_req.dart';
import 'dart:async';
import 'package:fotisia/data/repository/repository.dart';
import 'package:fotisia/core/constants/role.dart';
part 'sign_up_complete_account_event.dart';
part 'sign_up_complete_account_state.dart';

/// A bloc that manages the state of a SignUpCompleteAccount according to the event that is dispatched to it.
class SignUpCompleteAccountBloc
    extends Bloc<SignUpCompleteAccountEvent, SignUpCompleteAccountState> {
  SignUpCompleteAccountBloc(SignUpCompleteAccountState initialState)
      : super(initialState) {
    on<SignUpCompleteAccountInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<CreateRegisterEvent>(_callRegisterDeviceAuth);
  }

  final _repository = Repository();

  var postRegisterDeviceAuthResp = PostRegisterDeviceAuthResp();

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<SignUpCompleteAccountState> emit,
  ) {
    emit(state.copyWith(isShowPassword: event.value));
  }

  _onInitialize(
    SignUpCompleteAccountInitialEvent event,
    Emitter<SignUpCompleteAccountState> emit,
  ) async {
    emit(state.copyWith(
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        passwordController: TextEditingController(),
        emailController: TextEditingController(),
        isShowPassword: true
    ));
  }

  /// Calls [https://nodedemo.dhiwise.co/device/auth/register] with the provided event and emits the state.
  ///
  /// The [CreateRegisterEvent] parameter is used for handling event data
  /// The [emit] parameter is used for emitting the state
  ///
  /// Throws an error if an error occurs during the API call process.
  FutureOr<void> _callRegisterDeviceAuth(
    CreateRegisterEvent event,
    Emitter<SignUpCompleteAccountState> emit,
  ) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    var postRegisterDeviceAuthReq = PostRegisterDeviceAuthReq(
      // username: state.usernameController?.text ?? '',
      password: state.passwordController?.text ?? '',
      email: state.emailController?.text.trim(),
      firstName: state.firstNameController?.text.trim() ?? '',
      lastName: state.lastNameController?.text.trim() ?? '',
      role: Role.user,
      fcmToken: fcmToken,
    );
    await _repository.registerDeviceAuth(
      headers: {
        'Content-Type': 'application/json',
      },
      requestData: postRegisterDeviceAuthReq.toJson(),
    ).then((value) async {
      postRegisterDeviceAuthResp = value;
      _onRegisterDeviceAuthSuccess(value, emit);
      event.onCreateRegisterEventSuccess?.call();
    }).onError((error, stackTrace) {
      //implement error call
      if(error is PostRegisterDeviceAuthResp)
      {
        _onRegisterDeviceAuthError(error, emit);
        event.onCreateRegisterEventError?.call(error);
      }
      else
      {
        event.onCreateRegisterEventError?.call();
      }
    });
  }

  void _onRegisterDeviceAuthSuccess(
    PostRegisterDeviceAuthResp resp,
    Emitter<SignUpCompleteAccountState> emit,
  ) {
    PrefUtils().setId(resp.user?.id.toString() ?? '');
    emit(
      state.copyWith(
        signUpCompleteAccountModelObj:
            state.signUpCompleteAccountModelObj?.copyWith(),
      ),
    );
  }

  void _onRegisterDeviceAuthError(
      PostRegisterDeviceAuthResp resp,
      Emitter<SignUpCompleteAccountState> emit,
      ) {
    //implement error method body...
    PrefUtils().setId(resp.user?.id.toString() ?? '');
    emit(
      state.copyWith(
        signUpCompleteAccountModelObj:
        state.signUpCompleteAccountModelObj?.copyWith(),
      ),
    );
  }
}
