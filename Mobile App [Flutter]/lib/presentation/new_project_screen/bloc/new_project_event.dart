// ignore_for_file: must_be_immutable

part of 'new_project_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///NewPosition widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NewProjectEvent extends Equatable {}

/// Event that is dispatched when the NewPosition widget is first created.
class NewProjectInitialEvent extends NewProjectEvent {
  @override
  List<Object?> get props => [];
}

///event for dropdown selection
class ChangeDropDownEvent extends NewProjectEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class SaveProjectEvent extends NewProjectEvent {
  SaveProjectEvent({
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

class SetStartDate extends NewProjectEvent {
  SetStartDate({
    this.startDate,
  });

  DateTime? startDate;

  @override
  List<Object?> get props => [
    startDate,
  ];
}

class SetEndDate extends NewProjectEvent {
  SetEndDate({
    this.endDate,
  });

  DateTime? endDate;

  @override
  List<Object?> get props => [
    endDate,
  ];
}