import 'package:equatable/equatable.dart';
import 'package:yogesh_sharma/Models/Payment/check_out.dart';

abstract class CheckoutState extends Equatable {}

class CheckoutStateInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutStateLoadSuccess extends CheckoutState {
  final CheckOut checkout;
  final int id;

  CheckoutStateLoadSuccess({this.checkout, this.id});

  @override
  List<Object> get props => [checkout, id];

  @override
  String toString() => 'CheckoutStateLoadSuccess {checkout: $checkout Id:$id}';
}

class CheckoutStateLoadInProgress extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutStateLoadFailure extends CheckoutState {
  CheckoutStateLoadFailure({this.errorMessage = ''});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
