// ignore_for_file: must_be_immutable

part of 'message_action_bloc.dart';

/// Represents the state of MessageAction in the application.
class MessageActionState extends Equatable {
  MessageActionState({
    this.searchController,
    this.messageActionModelObj,
  });

  TextEditingController? searchController;

  MessageActionModel? messageActionModelObj;

  @override
  List<Object?> get props => [
        searchController,
        messageActionModelObj,
      ];
  MessageActionState copyWith({
    TextEditingController? searchController,
    MessageActionModel? messageActionModelObj,
  }) {
    return MessageActionState(
      searchController: searchController ?? this.searchController,
      messageActionModelObj:
          messageActionModelObj ?? this.messageActionModelObj,
    );
  }
}
