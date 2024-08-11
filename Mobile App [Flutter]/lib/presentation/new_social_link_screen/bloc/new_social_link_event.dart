// ignore_for_file: must_be_immutable

part of 'new_social_link_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///NewPosition widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class NewSocialLinkEvent extends Equatable {}

/// Event that is dispatched when the NewPosition widget is first created.
class NewSocialLinkInitialEvent extends NewSocialLinkEvent {
  @override
  List<Object?> get props => [];
}

///event for dropdown selection
class ChangeDropDownEvent extends NewSocialLinkEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class SaveSocialLinkEvent extends NewSocialLinkEvent {
  SaveSocialLinkEvent({
    this.onSaveUserDetailsSuccess,
    this.onSaveUserDetailsError,
  });

  Function? onSaveUserDetailsSuccess;

  Function? onSaveUserDetailsError;

  @override
  List<Object?> get props => [
    onSaveUserDetailsSuccess,
    onSaveUserDetailsError,
  ];
}
