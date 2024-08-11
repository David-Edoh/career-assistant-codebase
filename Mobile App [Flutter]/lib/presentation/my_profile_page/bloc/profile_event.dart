// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Profile widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ProfileEvent extends Equatable {}

/// Event that is dispatched when the Profile widget is first created.
class ProfileInitialEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox
class ChangeCheckBoxEvent extends ProfileEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing ChipView selection
class UpdateChipViewEvent extends ProfileEvent {
  UpdateChipViewEvent({
    required this.index,
    this.isSelected,
  });

  int index;

  bool? isSelected;

  @override
  List<Object?> get props => [
        index,
        isSelected,
      ];
}

class GetUserResumeDataEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}