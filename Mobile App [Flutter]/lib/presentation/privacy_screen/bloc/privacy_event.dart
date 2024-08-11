// ignore_for_file: must_be_immutable

part of 'privacy_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Privacy widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class PrivacyEvent extends Equatable {}

/// Event that is dispatched when the Privacy widget is first created.
class PrivacyInitialEvent extends PrivacyEvent {
  @override
  List<Object?> get props => [];
}
