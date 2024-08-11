// ignore_for_file: must_be_immutable

part of 'select_a_country_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///SelectACountry widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SelectACountryEvent extends Equatable {}

/// Event that is dispatched when the SelectACountry widget is first created.
class SelectACountryInitialEvent extends SelectACountryEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing radio button
class ChangeRadioButtonEvent extends SelectACountryEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}
