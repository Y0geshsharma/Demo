import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Services/Events/all_events_service.dart';
import 'package:yogesh_sharma/bloc/Events/all_event_events.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_state.dart';

class AllEventBloc extends Bloc<AllEvent, AllEventsState> {
  AllEventBloc({this.alleventService, this.catagory})
      : super(AllEventsStateInitial());

  final AllEventService alleventService;
  final String catagory;
  @override
  Stream<AllEventsState> mapEventToState(AllEvent event) async* {
    if (event is AllEventLoaded) {
      yield* _mapLoadedToStateAllEvent(event);
    }
    if (event is SimilarEventLoaded) {
      yield* _mapLoadedToStateSimilarEvent(event);
    }
  }

  Stream<AllEventsState> _mapLoadedToStateAllEvent(AllEvent event) async* {
    yield AllEventsStateLoadInProgress();
    try {
      final allEvent = await alleventService.getAllEvent();
      if (allEvent != null) {
        yield AllEventsStateLoadSuccess(allEvents: allEvent);
      } else {
        yield AllEventsStateLoadFailure();
      }
    } catch (e) {
      yield AllEventsStateLoadFailure();
    }
  }

  Stream<AllEventsState> _mapLoadedToStateSimilarEvent(AllEvent event) async* {
    yield SimilarEventsStateLoadInProgress();
    try {
      final similarEvents = await alleventService.getSimilarEvent(catagory);
      if (similarEvents != null) {
        yield SimilarEventsStateLoadSuccess(similarEvents: similarEvents);
      } else {
        yield SimilarEventsStateLoadFailure();
      }
    } catch (e) {
      yield SimilarEventsStateLoadFailure();
    }
  }
}
