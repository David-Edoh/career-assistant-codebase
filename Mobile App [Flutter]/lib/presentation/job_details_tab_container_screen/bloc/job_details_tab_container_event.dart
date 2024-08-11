// ignore_for_file: must_be_immutable

part of 'job_details_tab_container_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///JobDetailsTabContainer widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class JobDetailsTabContainerEvent extends Equatable {}

/// Event that is dispatched when the JobDetailsTabContainer widget is first created.
class JobDetailsTabContainerInitialEvent extends JobDetailsTabContainerEvent {
  @override
  List<Object?> get props => [];
}
