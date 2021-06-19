import 'package:equatable/equatable.dart';
import 'package:yogesh_sharma/Models/Events/all_events.dart';

abstract class AllEventsState extends Equatable {}

class AllEventsStateInitial extends AllEventsState {
  @override
  List<Object> get props => [];
}

class AllEventsStateLoadSuccess extends AllEventsState {
  final List<AllEvents> allEvents;

  AllEventsStateLoadSuccess({this.allEvents});

  @override
  List<Object> get props => [allEvents];

  @override
  String toString() => 'AllEventsStateLoadSuccess {AllEvents: $allEvents }';
}

class AllEventsStateLoadInProgress extends AllEventsState {
  @override
  List<Object> get props => [];
}

class AllEventsStateLoadFailure extends AllEventsState {
  AllEventsStateLoadFailure({this.errorMessage = ''});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class SimilarEventsStateInitial extends AllEventsState {
  @override
  List<Object> get props => [];
}

class SimilarEventsStateLoadSuccess extends AllEventsState {
  final List<AllEvents> similarEvents;

  SimilarEventsStateLoadSuccess({this.similarEvents});

  @override
  List<Object> get props => [similarEvents];

  @override
  String toString() => 'AllEventsStateLoadSuccess {AllEvents: $similarEvents }';
}

class SimilarEventsStateLoadInProgress extends AllEventsState {
  @override
  List<Object> get props => [];
}

class SimilarEventsStateLoadFailure extends AllEventsState {
  SimilarEventsStateLoadFailure({this.errorMessage = ''});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
