// ignore_for_file: must_be_immutable

part of 'saved_detail_job_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///SavedDetailJob widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SavedDetailJobEvent extends Equatable {}

/// Event that is dispatched when the SavedDetailJob widget is first created.
class SavedDetailJobInitialEvent extends SavedDetailJobEvent {
  @override
  List<Object?> get props => [];
}
