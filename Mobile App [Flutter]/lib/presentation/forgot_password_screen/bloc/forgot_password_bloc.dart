import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/apiClient/api_client.dart';
import '../models/forgot_password_model.dart';
import '/core/app_export.dart';
import 'package:sms_autofill/sms_autofill.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

/// A bloc that manages the state of a EnterOtp according to the event that is dispatched to it.
class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState>
    with CodeAutoFill {
  ForgotPasswordBloc(ForgotPasswordState initialState) : super(initialState) {
    on<ForgotPasswordInitialEvent>(_onInitialize);
    on<OnChangeEvent>(_changeEmail);
    on<ResetPasswordEvent>(_sendResetPassword);
  }

  final _apiClient = ApiClient();


  @override
  codeUpdated() {
    add(OnChangeEvent(email: code!));
  }

  _changeEmail(
    OnChangeEvent event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(
        state.copyWith(emailController: TextEditingController(text: event.email)));
  }

  _sendResetPassword(
      ResetPasswordEvent event,
      Emitter<ForgotPasswordState> emit,
      ) async {
  // /auth/forgot-password

    await _apiClient.postData(
      headers: {
        'Content-Type': 'application/json',
      },
      path: "api/auth/forgot-password",
      requestData: {
        "email": state.emailController?.text
      },
    ).then((value) async {
      emit(
          state.copyWith(
              emailSent: true
          )
      );
      Fluttertoast.showToast(msg: "Reset email successfully sent", toastLength: Toast.LENGTH_LONG);
    }).onError((error, stackTrace) {
      print(error);
      // Fluttertoast.showToast(msg: "Error saving resume details", toastLength: Toast.LENGTH_LONG);
      // event.onSaveUserDetailsError?.call();
    });

  }

  _onInitialize(
    ForgotPasswordInitialEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(emailController: TextEditingController()));
    listenForCode();
  }
}
