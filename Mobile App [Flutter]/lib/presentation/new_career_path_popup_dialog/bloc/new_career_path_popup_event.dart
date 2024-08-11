// ignore_for_file: must_be_immutable

part of 'new_career_path_popup_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///LogoutPopup widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NewCareerPathPopupEvent extends Equatable {}

/// Event that is dispatched when the LogoutPopup widget is first created.
class NewCareerPathPopupInitialEvent extends NewCareerPathPopupEvent {
  @override
  List<Object?> get props => [];
}

class GenerateNewCareerPathEvent extends NewCareerPathPopupEvent {
  @override
  List<Object?> get props => [];
}