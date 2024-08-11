// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Home widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class HomeEvent extends Equatable {}

class GetUserEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Home widget is first created.
class GetSuggestionsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Home widget is first created.
class GetArticles extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetJobsAds extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetRoadmapEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetOpportunitiesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetEvents extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class ReloadHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}