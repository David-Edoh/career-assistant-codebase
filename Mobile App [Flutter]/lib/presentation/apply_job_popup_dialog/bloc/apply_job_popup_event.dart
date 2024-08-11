// ignore_for_file: must_be_immutable

part of 'apply_job_popup_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ApplyJobPopup widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ApplyJobPopupEvent extends Equatable {}

/// Event that is dispatched when the ApplyJobPopup widget is first created.
class ApplyJobPopupInitialEvent extends ApplyJobPopupEvent {
  @override
  List<Object?> get props => [];
}
