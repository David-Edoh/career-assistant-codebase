// ignore_for_file: must_be_immutable

part of 'employment_status_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Employment Status widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class EmploymentStatusEvent extends Equatable {}

/// Event that is dispatched when the Employment Status widget is first created.
class EmploymentStatusInitialEvent extends EmploymentStatusEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox
class ChangeCheckBoxEvent extends EmploymentStatusEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButtonEvent extends EmploymentStatusEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class SetOthersTextEvent extends EmploymentStatusEvent {
  SetOthersTextEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class ChangeRadioButton1Event extends EmploymentStatusEvent {
  ChangeRadioButton1Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
  ];
}

///Event for changing radio button
class ChangeRadioButton2Event extends EmploymentStatusEvent {
  ChangeRadioButton2Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}
///Event for changing radio button
class ChangeRadioButton3Event extends EmploymentStatusEvent {
  ChangeRadioButton3Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class ChangeRadioButton4Event extends EmploymentStatusEvent {
  ChangeRadioButton4Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}