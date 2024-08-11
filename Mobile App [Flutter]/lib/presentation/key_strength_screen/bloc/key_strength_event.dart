// ignore_for_file: must_be_immutable

part of 'key_strength_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///KeyStrength widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class KeyStrengthEvent extends Equatable {}

/// Event that is dispatched when the KeyStrength widget is first created.
class KeyStrengthInitialEvent extends KeyStrengthEvent {
  @override
  List<Object?> get props => [];
}

///Event that is dispatched when the user calls the https://nodedemo.dhiwise.co/device/auth/register API.
class SaveUserDetailsEvent extends KeyStrengthEvent {
  SaveUserDetailsEvent({
    this.onSaveUserDetailsSuccess,
    this.onSaveUserDetailsError,
  });

  Function? onSaveUserDetailsSuccess;

  Function? onSaveUserDetailsError;

  @override
  List<Object?> get props => [
    onSaveUserDetailsSuccess,
    onSaveUserDetailsError,
  ];
}

///Event for changing radio button
class SetOthersTextEvent extends KeyStrengthEvent {
  SetOthersTextEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing checkbox
class ChangeCheckBoxEvent extends KeyStrengthEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
class ChangeRadioButtonEvent extends KeyStrengthEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}
