// ignore_for_file: must_be_immutable

part of 'forgot_password_bloc.dart';

/// Represents the state of EnterOtp in the application.
class ForgotPasswordState extends Equatable {
  ForgotPasswordState({
    this.emailController,
    this.forgotPasswordModelObj,
    this.emailSent = false,
  });

  TextEditingController? emailController;

  ForgotPasswordModel? forgotPasswordModelObj;

  bool? emailSent;

  @override
  List<Object?> get props => [
        emailController,
        forgotPasswordModelObj,
    emailSent,
      ];

  ForgotPasswordState copyWith({
    TextEditingController? emailController,
    ForgotPasswordModel? enterOtpModelObj,
    bool? emailSent,
  }) {
    return ForgotPasswordState(
      emailController: emailController ?? this.emailController,
      forgotPasswordModelObj: enterOtpModelObj ?? this.forgotPasswordModelObj,
      emailSent: emailSent ?? emailSent,
    );
  }
}
