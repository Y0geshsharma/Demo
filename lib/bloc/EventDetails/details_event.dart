import 'package:equatable/equatable.dart';

abstract class EventDetailsEvent extends Equatable {}

class EventDetailsLoaded extends EventDetailsEvent {
  EventDetailsLoaded({this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
