import 'package:equatable/equatable.dart';
import 'package:yogesh_sharma/Models/Events/event_details.dart';

abstract class EventDetailsState extends Equatable {}

class EventDetailsStateInitial extends EventDetailsState {
  @override
  List<Object> get props => [];
}

class EventDetailsStateLoadSuccess extends EventDetailsState {
  final EventDetails eventDetails;
  final int id;

  EventDetailsStateLoadSuccess({this.eventDetails, this.id});

  @override
  List<Object> get props => [eventDetails, id];

  @override
  String toString() =>
      'EventsDetailsStateLoadSuccess {EventsDetails: $eventDetails Id:$id}';
}

class EventDetailsStateLoadInProgress extends EventDetailsState {
  @override
  List<Object> get props => [];
}

class EventDetailsStateLoadFailure extends EventDetailsState {
  EventDetailsStateLoadFailure({this.errorMessage = ''});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
