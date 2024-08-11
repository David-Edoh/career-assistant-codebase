// ignore_for_file: must_be_immutable

part of 'confirmation_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Confirmation widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ConfirmationEvent extends Equatable {}

/// Event that is dispatched when the Confirmation widget is first created.
class ConfirmationInitialEvent extends ConfirmationEvent {
  @override
  List<Object?> get props => [];
}
