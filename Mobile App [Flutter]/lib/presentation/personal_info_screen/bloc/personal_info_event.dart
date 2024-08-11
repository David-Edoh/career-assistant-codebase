// ignore_for_file: must_be_immutable

part of 'personal_info_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///PersonalInfo widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class PersonalInfoEvent extends Equatable {}

/// Event that is dispatched when the PersonalInfo widget is first created.
class PersonalInfoInitialEvent extends PersonalInfoEvent {
  @override
  List<Object?> get props => [];
}

///Event that is dispatched when the user calls the https://nodedemo.dhiwise.co/device/api/v1/user/me API.
class FetchMeEvent extends PersonalInfoEvent {
  FetchMeEvent();

  @override
  List<Object?> get props => [];
}

class SaveProfileDetailsEvent extends PersonalInfoEvent {
  @override
  List<Object?> get props => [];
}

class SetSelectedImage extends PersonalInfoEvent {
  SetSelectedImage({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}