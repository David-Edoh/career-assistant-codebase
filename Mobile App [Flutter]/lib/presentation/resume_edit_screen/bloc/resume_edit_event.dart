// ignore_for_file: must_be_immutable

part of 'resume_edit_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ResumeEdit widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ResumeEditEvent extends Equatable {}

/// Event that is dispatched when the ResumeEdit widget is first created.
class ResumeEditInitialEvent extends ResumeEditEvent {
  @override
  List<Object?> get props => [];
}


class PreviewResumeDetailsEvent extends ResumeEditEvent {
  @override
  List<Object?> get props => [];
}

class TempSaveResumeDetailsEvent extends ResumeEditEvent {
  @override
  List<Object?> get props => [];
}

class DeleteItemEvent extends ResumeEditEvent {
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

///Event for changing checkbox
class SetSelectedImage extends ResumeEditEvent {
  SetSelectedImage({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}