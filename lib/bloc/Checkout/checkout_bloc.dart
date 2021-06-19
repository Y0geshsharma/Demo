import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Services/Payment/checkout.dart';
import 'package:yogesh_sharma/bloc/Checkout/checkout_event.dart';
import 'package:yogesh_sharma/bloc/Checkout/checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({this.checkoutService, this.id}) : super(CheckoutStateInitial());

  final CheckoutService checkoutService;
  final int id;

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is CheckoutEventLoaded) {
      yield* _mapLoadedToState(event);
    }
  }

  Stream<CheckoutState> _mapLoadedToState(CheckoutEvent event) async* {
    yield CheckoutStateLoadInProgress();
    try {
      final checkout = await checkoutService.getCheckoutDetails(id);
      if (checkout != null) {
        yield CheckoutStateLoadSuccess(checkout: checkout, id: id);
      } else {
        yield CheckoutStateLoadFailure();
      }
    } catch (e) {
      yield CheckoutStateLoadFailure();
    }
  }
}
