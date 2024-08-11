// ignore_for_file: must_be_immutable

part of 'message_bloc.dart';

/// Represents the state of Message in the application.
class MessageState extends Equatable {
  MessageState({
    this.searchController,
    this.messageModelObj,
  });

  TextEditingController? searchController;

  MessageModel? messageModelObj;

  @override
  List<Object?> get props => [
        searchController,
        messageModelObj,
      ];
  MessageState copyWith({
    TextEditingController? searchController,
    MessageModel? messageModelObj,
  }) {
    return MessageState(
      searchController: searchController ?? this.searchController,
      messageModelObj: messageModelObj ?? this.messageModelObj,
    );
  }
}
