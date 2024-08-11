// ignore_for_file: must_be_immutable

part of 'sign_up_create_acount_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///SignUpCreateAcount widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SignUpCreateAcountEvent extends Equatable {}

/// Event that is dispatched when the SignUpCreateAcount widget is first created.
class SignUpCreateAcountInitialEvent extends SignUpCreateAcountEvent {
  @override
  List<Object?> get props => [];
}
