// ignore_for_file: must_be_immutable

part of 'education_level_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///EducationLevel widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class EducationLevelEvent extends Equatable {}

/// Event that is dispatched when the EducationLevel widget is first created.
class EducationLevelInitialEvent extends EducationLevelEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox
class ChangeCheckBoxEvent extends EducationLevelEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class SetOthersTextEvent extends EducationLevelEvent {
  SetOthersTextEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class ChangeRadioButtonEvent extends EducationLevelEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButton1Event extends EducationLevelEvent {
  ChangeRadioButton1Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButton2Event extends EducationLevelEvent {
  ChangeRadioButton2Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButton3Event extends EducationLevelEvent {
  ChangeRadioButton3Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class ChangeRadioButton4Event extends EducationLevelEvent {
  ChangeRadioButton4Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}