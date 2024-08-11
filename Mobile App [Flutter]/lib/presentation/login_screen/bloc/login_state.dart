// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Represents the state of Login in the application.
class LoginState extends Equatable {

  LoginState({
    this.emailController,
    this.loginModelObj,
    this.passwordController,
    this.isShowPassword = true,
    this.useEmailLogin = false,

  });

  TextEditingController? emailController;
  TextEditingController? passwordController;
  LoginModel? loginModelObj;
  bool isShowPassword;
  bool useEmailLogin;

  @override
  List<Object?> get props => [
        emailController,
        loginModelObj,
        passwordController,
        isShowPassword,
        useEmailLogin,
  ];
  LoginState copyWith({
    TextEditingController? emailController,
    LoginModel? loginModelObj,
    TextEditingController? passwordController,
    bool? isShowPassword,
    bool? useEmailLogin,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      loginModelObj: loginModelObj ?? this.loginModelObj,
      passwordController: passwordController ?? this.passwordController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      useEmailLogin: useEmailLogin ?? this.useEmailLogin,
    );
  }
}
