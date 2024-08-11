// ignore_for_file: must_be_immutable

part of 'logout_popup_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///LogoutPopup widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class LogoutPopupEvent extends Equatable {}

/// Event that is dispatched when the LogoutPopup widget is first created.
class LogoutPopupInitialEvent extends LogoutPopupEvent {
  @override
  List<Object?> get props => [];
}
