// ignore_for_file: must_be_immutable

part of 'career_roadmap_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CareerRoadmap widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CareerRoadmapEvent extends Equatable {}

/// Event that is dispatched when the CareerRoadmap widget is first created.
class CareerRoadmapInitialEvent extends CareerRoadmapEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill
class ChangeOTPEvent extends CareerRoadmapEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [
        code,
      ];
}
