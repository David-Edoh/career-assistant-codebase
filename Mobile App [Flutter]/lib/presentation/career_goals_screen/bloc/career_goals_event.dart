// ignore_for_file: must_be_immutable

part of 'career_goals_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CareerGoals widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CareerGoalsEvent extends Equatable {}

/// Event that is dispatched when the CareerGoals widget is first created.
class CareerGoalsInitialEvent extends CareerGoalsEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox
class ChangeCheckBoxEvent extends CareerGoalsEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButtonEvent extends CareerGoalsEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButton1Event extends CareerGoalsEvent {
  ChangeRadioButton1Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButton2Event extends CareerGoalsEvent {
  ChangeRadioButton2Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}


///Event for changing radio button
class SetOthersTextEvent extends CareerGoalsEvent {
  SetOthersTextEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class ChangeRadioButton3Event extends CareerGoalsEvent {
  ChangeRadioButton3Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class ChangeRadioButton4Event extends CareerGoalsEvent {
  ChangeRadioButton4Event({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}