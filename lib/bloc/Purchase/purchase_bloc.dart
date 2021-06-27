import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Models/Payment/check_out.dart';
import 'package:yogesh_sharma/Services/Payment/payment.dart';
import 'package:yogesh_sharma/bloc/Purchase/purchase_event.dart';
import 'package:yogesh_sharma/bloc/Purchase/purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc({this.purchaseService, this.body})
      : super(PurchaseStateInitial());

  final PurchaseService purchaseService;
  final Map<String, dynamic> body;

  @override
  Stream<PurchaseState> mapEventToState(PurchaseEvent event) async* {
    if (event is PurchaseEventLoaded) {
      yield* _mapLoadedToState(event);
    }
  }

  Stream<PurchaseState> _mapLoadedToState(PurchaseEvent event) async* {
    yield PurchaseStateLoadInProgress();
    try {
      final purchase = await purchaseService.getPurchase(body);
      if (purchase != null) {
        yield PurchaseStateLoadSuccess(purchase: purchase);
      } else {
        yield PurchaseStateLoadFailure();
      }
    } catch (e) {
      yield PurchaseStateLoadFailure();
    }
  }
}
