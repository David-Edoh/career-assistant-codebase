// ignore_for_file: must_be_immutable

part of 'personal_brand_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///PersonalBrand widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class PersonalBrandEvent extends Equatable {}

/// Event that is dispatched when the PersonalBrand widget is first created.
class PersonalBrandInitialEvent extends PersonalBrandEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill
class ChangeOTPEvent extends PersonalBrandEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [
        code,
      ];
}
