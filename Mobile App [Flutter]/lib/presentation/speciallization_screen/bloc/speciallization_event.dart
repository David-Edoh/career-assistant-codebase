// ignore_for_file: must_be_immutable

part of 'speciallization_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Speciallization widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SpeciallizationEvent extends Equatable {}

/// Event that is dispatched when the Speciallization widget is first created.
class SpeciallizationInitialEvent extends SpeciallizationEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox
class ChangeCheckBoxEvent extends SpeciallizationEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}


///Event for changing radio button
class SetOthersTextEvent extends SpeciallizationEvent {
  SetOthersTextEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
    value,
  ];
}

///Event for changing radio button
class ChangeRadioButtonEvent extends SpeciallizationEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing radio button
// class ChangeRadioButton1Event extends SpeciallizationEvent {
//   ChangeRadioButton1Event({required this.value});
//
//   String value;
//
//   @override
//   List<Object?> get props => [
//         value,
//       ];
// }
//
// ///Event for changing radio button
// class ChangeRadioButton2Event extends SpeciallizationEvent {
//   ChangeRadioButton2Event({required this.value});
//
//   String value;
//
//   @override
//   List<Object?> get props => [
//         value,
//       ];
// }
//
// ///Event for changing radio button
// class ChangeRadioButton3Event extends SpeciallizationEvent {
//   ChangeRadioButton3Event({required this.value});
//
//   String value;
//
//   @override
//   List<Object?> get props => [
//     value,
//   ];
// }
//
// ///Event for changing radio button
// class ChangeRadioButton4Event extends SpeciallizationEvent {
//   ChangeRadioButton4Event({required this.value});
//
//   String value;
//
//   @override
//   List<Object?> get props => [
//     value,
//   ];
// }
//
// ///Event for changing radio button
// class ChangeRadioButton5Event extends SpeciallizationEvent {
//   ChangeRadioButton5Event({required this.value});
//
//   String value;
//
//   @override
//   List<Object?> get props => [
//     value,
//   ];
// }