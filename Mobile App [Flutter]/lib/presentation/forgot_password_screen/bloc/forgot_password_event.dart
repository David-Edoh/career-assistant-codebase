// ignore_for_file: must_be_immutable

part of 'forgot_password_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///EnterOtp widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ForgotPasswordEvent extends Equatable {}

/// Event that is dispatched when the EnterOtp widget is first created.
class ForgotPasswordInitialEvent extends ForgotPasswordEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill
class OnChangeEvent extends ForgotPasswordEvent {
  OnChangeEvent({required this.email});

  String email;

  @override
  List<Object?> get props => [
        email,
      ];
}

class ResetPasswordEvent extends ForgotPasswordEvent {


  @override
  List<Object?> get props => [
    ];
}
