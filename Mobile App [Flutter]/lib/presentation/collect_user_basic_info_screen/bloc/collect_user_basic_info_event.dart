// ignore_for_file: must_be_immutable

part of 'collect_user_basic_info_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ResumeEdit widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CollectBasicUserInfoEvent extends Equatable {}

/// Event that is dispatched when the ResumeEdit widget is first created.
class InitializeCollectBasicUserInfoEvent extends CollectBasicUserInfoEvent {
  @override
  List<Object?> get props => [];
}


class PreviewResumeDetailsEvent extends CollectBasicUserInfoEvent {
  @override
  List<Object?> get props => [];
}

class SetResumeData extends CollectBasicUserInfoEvent {
  SetResumeData({required this.resumeData});

  String resumeData;

  @override
  List<Object?> get props => [
    resumeData,
  ];
}

class SaveCollectedUserInfoEvent extends CollectBasicUserInfoEvent {
  SaveCollectedUserInfoEvent({
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

class DeleteItemEvent extends CollectBasicUserInfoEvent {
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
class SetSelectedImage extends CollectBasicUserInfoEvent {
  SetSelectedImage({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}