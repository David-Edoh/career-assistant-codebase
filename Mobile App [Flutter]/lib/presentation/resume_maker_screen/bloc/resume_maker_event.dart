// ignore_for_file: must_be_immutable

part of 'resume_maker_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ResumeMaker widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ResumeMakerEvent extends Equatable {}

/// Event that is dispatched when the ResumeMaker widget is first created.
class ResumeMakerInitialEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}

class UploadResumeEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}

class DownloadResumeEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}

class OptimizeResume extends ResumeMakerEvent {
  OptimizeResume({required this.jobContent, required this.instructions});

  String jobContent;
  String instructions;

  @override
  List<Object?> get props => [
    jobContent,
    instructions,
  ];
}

class SaveResumeDetailsEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}

class PreviewResumeEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill
class ChangeOTPEvent extends ResumeMakerEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [
        code,
    ];
}

///Event for changing radio button
class ChangeResumeTemplateEvent extends ResumeMakerEvent {
  ChangeResumeTemplateEvent({required this.value});

  int value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class SelectTemplateEvent extends ResumeMakerEvent {
  SelectTemplateEvent({required this.templateId});

  int templateId;

  @override
  List<Object?> get props => [
    templateId,
  ];
}

/// Event that is dispatched when the ResumeMaker widget is first created.
class GetTemplatesEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the ResumeMaker widget is first created.
class GetTemplatesFromLocalStoreEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the ResumeMaker widget is first created.
class GetUserResumeDataEvent extends ResumeMakerEvent {
  @override
  List<Object?> get props => [];
}