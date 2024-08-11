// ignore_for_file: must_be_immutable

part of 'user_profile_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Profile widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ProfileEvent extends Equatable {}

/// Event that is dispatched when the Profile widget is first created.
class UserProfileInitialEvent extends ProfileEvent {
  UserProfileInitialEvent({required this.userId});

  int userId;

  @override
  List<Object?> get props => [
    userId,
  ];
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

///Event for changing ChipView selection
class AddFriend extends ProfileEvent {
  AddFriend({
    this.userId,
  });


  int? userId;

  @override
  List<Object?> get props => [
    userId,
  ];
}

///Event for changing ChipView selection
class UnFriend extends ProfileEvent {
  UnFriend({
    this.userId,
  });


  int? userId;

  @override
  List<Object?> get props => [
    userId,
  ];
}

///Event for changing ChipView selection
class CancelFriendRequest extends ProfileEvent {
  CancelFriendRequest({
    this.relationshipId,
  });


  int? relationshipId;

  @override
  List<Object?> get props => [
    relationshipId,
  ];
}

///Event for changing ChipView selection
class AcceptFriendRequest extends ProfileEvent {
  AcceptFriendRequest({
    this.relationshipId,
  });


  int? relationshipId;

  @override
  List<Object?> get props => [
    relationshipId,
  ];
}

///Event for changing ChipView selection
class RejectFriendRequest extends ProfileEvent {
  RejectFriendRequest({
    this.relationshipId,
  });


  int? relationshipId;

  @override
  List<Object?> get props => [
    relationshipId,
  ];
}

class GetUserResumeDataEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}