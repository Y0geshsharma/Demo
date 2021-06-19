import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Services/Events/all_events_service.dart';
import 'package:yogesh_sharma/bloc/Events/all_event_events.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_state.dart';

class AllEventBloc extends Bloc<AllEvent, AllEventsState> {
  AllEventBloc({this.alleventService}) : super(AllEventsStateInitial());

  final AllEventService alleventService;

  @override
  Stream<AllEventsState> mapEventToState(AllEvent event) async* {
    if (event is AllEventLoaded) {
      yield*  _mapLoadedToState(event);
    }
  }

  Stream<AllEventsState> _mapLoadedToState(AllEvent event) async* {
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
}
