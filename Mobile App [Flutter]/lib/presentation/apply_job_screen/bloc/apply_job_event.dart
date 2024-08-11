// ignore_for_file: must_be_immutable

part of 'apply_job_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ApplyJob widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ApplyJobEvent extends Equatable {}

/// Event that is dispatched when the ApplyJob widget is first created.
class ApplyJobInitialEvent extends ApplyJobEvent {
  @override
  List<Object?> get props => [];
}
