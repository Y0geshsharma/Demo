import 'package:equatable/equatable.dart';
import 'package:yogesh_sharma/Models/Payment/check_out.dart';

abstract class PurchaseEvent extends Equatable {}

class PurchaseEventLoaded extends PurchaseEvent {
  PurchaseEventLoaded({this.body});
  final CheckOut body;

  @override
  List<Object> get props => [body];
}
