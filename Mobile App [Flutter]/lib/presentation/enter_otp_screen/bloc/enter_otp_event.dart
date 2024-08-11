// ignore_for_file: must_be_immutable

part of 'enter_otp_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///EnterOtp widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class EnterOtpEvent extends Equatable {}

/// Event that is dispatched when the EnterOtp widget is first created.
class EnterOtpInitialEvent extends EnterOtpEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill
class ChangeOTPEvent extends EnterOtpEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [
        code,
      ];
}
