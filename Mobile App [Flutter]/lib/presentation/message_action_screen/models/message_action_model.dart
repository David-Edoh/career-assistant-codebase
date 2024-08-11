// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'message_action_item_model.dart';

/// This class defines the variables used in the [message_action_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MessageActionModel extends Equatable {
  MessageActionModel({this.messageActionItemList = const []});

  List<MessageActionItemModel> messageActionItemList;

  MessageActionModel copyWith(
      {List<MessageActionItemModel>? messageActionItemList}) {
    return MessageActionModel(
      messageActionItemList:
          messageActionItemList ?? this.messageActionItemList,
    );
  }

  @override
  List<Object?> get props => [messageActionItemList];
}
