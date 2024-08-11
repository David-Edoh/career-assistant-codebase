// ignore_for_file: must_be_immutable

part of 'new_reference_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///NewPosition widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NewReferenceEvent extends Equatable {}

/// Event that is dispatched when the NewPosition widget is first created.
class NewReferenceInitialEvent extends NewReferenceEvent {
  @override
  List<Object?> get props => [];
}

///event for dropdown selection
class ChangeDropDownEvent extends NewReferenceEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class SaveReferenceEvent extends NewReferenceEvent {
  SaveReferenceEvent({
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
