// ignore_for_file: must_be_immutable

part of 'career_subjects_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CareerSubjects widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CareerSubjectsEvent extends Equatable {}

/// Event that is dispatched when the CareerSubjects widget is first created.
class CareerSubjectsInitialEvent extends CareerSubjectsEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill
class ChangeOTPEvent extends CareerSubjectsEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [
        code,
      ];
}
