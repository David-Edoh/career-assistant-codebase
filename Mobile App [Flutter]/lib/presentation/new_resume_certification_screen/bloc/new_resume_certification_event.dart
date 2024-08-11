// ignore_for_file: must_be_immutable

part of 'new_resume_certification_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///NewPosition widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NewTrainingsCoursesCertificationsEvent extends Equatable {}

/// Event that is dispatched when the NewPosition widget is first created.
class NewCertificationInitialEvent extends NewTrainingsCoursesCertificationsEvent {
  @override
  List<Object?> get props => [];
}

///event for dropdown selection
class ChangeDropDownEvent extends NewTrainingsCoursesCertificationsEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class SaveTrainingsCoursesCertificationsEvent extends NewTrainingsCoursesCertificationsEvent {
  SaveTrainingsCoursesCertificationsEvent({
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

class SetStartDate extends NewTrainingsCoursesCertificationsEvent {
  SetStartDate({
    this.startDate,
  });

  DateTime? startDate;

  @override
  List<Object?> get props => [
    startDate,
  ];
}

class SetEndDate extends NewTrainingsCoursesCertificationsEvent {
  SetEndDate({
    this.endDate,
  });

  DateTime? endDate;

  @override
  List<Object?> get props => [
    endDate,
  ];
}