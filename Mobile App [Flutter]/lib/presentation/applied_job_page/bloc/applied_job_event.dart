// ignore_for_file: must_be_immutable

part of 'applied_job_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///AppliedJob widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class AppliedJobEvent extends Equatable {}

/// Event that is dispatched when the AppliedJob widget is first created.
class AppliedJobInitialEvent extends AppliedJobEvent {
  @override
  List<Object?> get props => [];
}
