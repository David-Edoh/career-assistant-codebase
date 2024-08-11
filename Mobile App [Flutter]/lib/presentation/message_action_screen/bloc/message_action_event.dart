// ignore_for_file: must_be_immutable

part of 'message_action_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MessageAction widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MessageActionEvent extends Equatable {}

/// Event that is dispatched when the MessageAction widget is first created.
class MessageActionInitialEvent extends MessageActionEvent {
  @override
  List<Object?> get props => [];
}
