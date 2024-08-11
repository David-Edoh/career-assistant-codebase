// ignore_for_file: must_be_immutable

part of 'sign_up_complete_account_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///SignUpCompleteAccount widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SignUpCompleteAccountEvent extends Equatable {}

/// Event that is dispatched when the SignUpCompleteAccount widget is first created.
class SignUpCompleteAccountInitialEvent extends SignUpCompleteAccountEvent {
  @override
  List<Object?> get props => [];
}

///Event that is dispatched when the user calls the https://nodedemo.dhiwise.co/device/auth/register API.
class CreateRegisterEvent extends SignUpCompleteAccountEvent {
  CreateRegisterEvent({
    this.onCreateRegisterEventSuccess,
    this.onCreateRegisterEventError,
  });

  Function? onCreateRegisterEventSuccess;

  Function? onCreateRegisterEventError;

  @override
  List<Object?> get props => [
        onCreateRegisterEventSuccess,
        onCreateRegisterEventError,
      ];
}

///Event for changing password visibility
class ChangePasswordVisibilityEvent extends SignUpCompleteAccountEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
