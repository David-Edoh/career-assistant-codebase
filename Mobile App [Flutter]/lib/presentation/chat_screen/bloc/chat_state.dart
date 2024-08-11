// ignore_for_file: must_be_immutable

part of 'chat_bloc.dart';

/// Represents the state of Chat in the application.
class ChatState extends Equatable {
  ChatState({
    this.messageController,
    this.chatModelObj,
  });

  TextEditingController? messageController;

  StreakInfoModel? chatModelObj;

  @override
  List<Object?> get props => [
        messageController,
        chatModelObj,
      ];

  ChatState copyWith({
    TextEditingController? messageController,
    StreakInfoModel? chatModelObj,
  }) {
    return ChatState(
      messageController: messageController ?? this.messageController,
      chatModelObj: chatModelObj ?? this.chatModelObj,
    );
  }
}
