// ignore_for_file: must_be_immutable

part of 'sign_up_create_acount_bloc.dart';

/// Represents the state of SignUpCreateAcount in the application.
class SignUpCreateAcountState extends Equatable {
  SignUpCreateAcountState({
    this.emailController,
    this.signUpCreateAcountModelObj,
  });

  TextEditingController? emailController;

  SignUpCreateAcountModel? signUpCreateAcountModelObj;

  @override
  List<Object?> get props => [
        emailController,
        signUpCreateAcountModelObj,
      ];
  SignUpCreateAcountState copyWith({
    TextEditingController? emailController,
    SignUpCreateAcountModel? signUpCreateAcountModelObj,
  }) {
    return SignUpCreateAcountState(
      emailController: emailController ?? this.emailController,
      signUpCreateAcountModelObj:
          signUpCreateAcountModelObj ?? this.signUpCreateAcountModelObj,
    );
  }
}
