import 'package:equatable/equatable.dart';

abstract class CheckoutEvent extends Equatable {}

class CheckoutEventLoaded extends CheckoutEvent {
  CheckoutEventLoaded({this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
