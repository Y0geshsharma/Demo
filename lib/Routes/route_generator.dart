import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Models/Payment/check_out.dart';
import 'package:yogesh_sharma/Screens/check_out_screen.dart';
import 'package:yogesh_sharma/Screens/event_detail_screen.dart';
import 'package:yogesh_sharma/Screens/home.dart';
import 'package:yogesh_sharma/Screens/purchase_screen.dart';
import 'package:yogesh_sharma/Screens/splash_screen.dart';
import 'package:yogesh_sharma/Services/Events/all_events_service.dart';
import 'package:yogesh_sharma/Services/Events/event_details_service.dart';
import 'package:yogesh_sharma/Services/Payment/checkout.dart';
import 'package:yogesh_sharma/Services/Payment/payment.dart';
import 'package:yogesh_sharma/bloc/Checkout/checkout_bloc.dart';
import 'package:yogesh_sharma/bloc/Checkout/checkout_event.dart';
import 'package:yogesh_sharma/bloc/EventDetails/details_bloc.dart';
import 'package:yogesh_sharma/bloc/EventDetails/details_event.dart';
import 'package:yogesh_sharma/bloc/Events/all_event_events.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_bloc.dart';
import 'package:yogesh_sharma/bloc/Purchase/purchase_bloc.dart';
import 'package:yogesh_sharma/bloc/Purchase/purchase_event.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Map<String, dynamic> args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AllEventBloc>(
            create: (context) => AllEventBloc(
              alleventService: AllEventService(),
            )..add(
                AllEventLoaded(),
              ),
            lazy: false,
            child: Home(),
          ),
        );
      case '/eventDetails':
        if (args.isNotEmpty && args['id'] && args['catagory']) {
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<EventDetailsBloc>(
                  create: (_) => EventDetailsBloc(
                    id: args['id'],
                    eventDetailsService: EventDetailsService(),
                  )..add(
                      EventDetailsLoaded(),
                    ),
                ),
                BlocProvider<AllEventBloc>(
                  create: (_) => AllEventBloc(
                      alleventService: AllEventService(),
                      catagory: args['catagory'])
                    ..add(
                      SimilarEventLoaded(),
                    ),
                ),
              ],
              child: EventDetailScreen(),
            ),
          );
        }
        return _errorRoute();
      case '/checkout':
        if (args.isNotEmpty && args['id'] is int) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<CheckoutBloc>(
              create: (_) => CheckoutBloc(
                id: args['id'],
                checkoutService: CheckoutService(),
              )..add(
                  CheckoutEventLoaded(),
                ),
              child: CheckOutScreen(
                id: args['id'],
              ),
            ),
          );
        }
        return _errorRoute();
      case '/purchase':
        if (args.isNotEmpty && args['checkout'] is CheckOut) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<PurchaseBloc>(
              create: (_) => PurchaseBloc(
                purchaseService: PurchaseService(),
                body: args['checkout'],
              )..add(
                  PurchaseEventLoaded(),
                ),
              child: PurchaseScreen(),
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
          backgroundColor: Theme.of(_).accentColor,
        ),
        body: Center(
          child: Text('Somethig went wrong!'),
        ),
      );
    });
  }
}
