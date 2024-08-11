// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Login widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class LoginEvent extends Equatable {}

/// Event that is dispatched when the Login widget is first created.
class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

///Event that is dispatched when the user calls the https://nodedemo.dhiwise.co/device/auth/register API.
class LoginAuthEvent extends LoginEvent {
  LoginAuthEvent({
    this.onLoginEventSuccess,
    this.onLoginEventError,
  });

  Function? onLoginEventSuccess;

  Function? onLoginEventError;

  @override
  List<Object?> get props => [
    onLoginEventSuccess,
    onLoginEventError,
  ];
}

class SocialLoginAuthEvent extends LoginEvent {
  SocialLoginAuthEvent({
    this.onLoginEventSuccess,
    this.onLoginEventError,
    this.user,
  });

  Function? onLoginEventSuccess;
  Function? onLoginEventError;
  User? user;

  @override
  List<Object?> get props => [
    onLoginEventSuccess,
    onLoginEventError,
    user,
  ];
}

class LinkedInLoginAuthEvent extends LoginEvent {
  LinkedInLoginAuthEvent({
    this.onLoginEventSuccess,
    this.onLoginEventError,
  });

  Function? onLoginEventSuccess;

  Function? onLoginEventError;

  @override
  List<Object?> get props => [
    onLoginEventSuccess,
    onLoginEventError,
  ];
}

///Event for changing password visibility
class ChangePasswordVisibilityEvent extends LoginEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
    value,
  ];
}

class UseEmailEvent extends LoginEvent {
  // UseEmailEvent();

  @override
  List<Object?> get props => [];
}

class UseSocialLoginEvent extends LoginEvent {
  // UseEmailEvent();

  @override
  List<Object?> get props => [];
}