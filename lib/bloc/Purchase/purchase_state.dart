import 'package:equatable/equatable.dart';
import 'package:yogesh_sharma/Models/Payment/purchase.dart';

abstract class PurchaseState extends Equatable {}

class PurchaseStateInitial extends PurchaseState {
  @override
  List<Object> get props => [];
}

class PurchaseStateLoadSuccess extends PurchaseState {
  final Purchase purchase;

  PurchaseStateLoadSuccess({this.purchase});

  @override
  List<Object> get props => [purchase];

  @override
  String toString() => 'PurchaseStateLoadSuccess {purchase: $purchase}';
}

class PurchaseStateLoadInProgress extends PurchaseState {
  @override
  List<Object> get props => [];
}

class PurchaseStateLoadFailure extends PurchaseState {
  PurchaseStateLoadFailure({this.errorMessage = ''});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
