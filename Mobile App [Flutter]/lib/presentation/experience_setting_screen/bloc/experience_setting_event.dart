// ignore_for_file: must_be_immutable

part of 'experience_setting_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ExperienceSetting widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ExperienceSettingEvent extends Equatable {}

/// Event that is dispatched when the ExperienceSetting widget is first created.
class ExperienceSettingInitialEvent extends ExperienceSettingEvent {
  @override
  List<Object?> get props => [];
}


class SaveResumeDetailsEvent extends ExperienceSettingEvent {
  @override
  List<Object?> get props => [];
}

class DeleteItemEvent extends ExperienceSettingEvent {
  DeleteItemEvent({
    this.itemId,
    this.itemType,
    this.onDeleteItemSuccess,
    this.onDeleteItemError,
  });

  int? itemId;
  String? itemType;
  Function? onDeleteItemSuccess;
  Function? onDeleteItemError;

  @override
  List<Object?> get props => [
    itemId,
    itemType,
    onDeleteItemSuccess,
    onDeleteItemError,
  ];
}

class SetSelectedImage extends ExperienceSettingEvent {
  SetSelectedImage({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}