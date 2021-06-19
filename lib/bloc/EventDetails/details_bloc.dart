import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Services/Events/event_details_service.dart';
import 'package:yogesh_sharma/bloc/EventDetails/details_event.dart';
import 'package:yogesh_sharma/bloc/EventDetails/details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsBloc({this.eventDetailsService, this.id})
      : super(EventDetailsStateInitial());

  final EventDetailsService eventDetailsService;
  final int id;

  @override
  Stream<EventDetailsState> mapEventToState(EventDetailsEvent event) async* {
    if (event is EventDetailsLoaded) {
      yield* _mapLoadedToState(event);
    }
  }

  Stream<EventDetailsState> _mapLoadedToState(EventDetailsEvent event) async* {
    yield EventDetailsStateLoadInProgress();
    try {
      final eventDetails = await eventDetailsService.getDeatils(id);
      if (eventDetails != null) {
        yield EventDetailsStateLoadSuccess(eventDetails: eventDetails, id: id);
      } else {
        yield EventDetailsStateLoadFailure();
      }
    } catch (e) {
      yield EventDetailsStateLoadFailure();
    }
  }
}
