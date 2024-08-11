// ignore_for_file: must_be_immutable

part of 'job_details_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///JobDetails widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class JobDetailsEvent extends Equatable {}

/// Event that is dispatched when the JobDetails widget is first created.
class JobDetailsInitialEvent extends JobDetailsEvent {
  @override
  List<Object?> get props => [];
}
