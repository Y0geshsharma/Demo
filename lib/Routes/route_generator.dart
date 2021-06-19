import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Screens/event_detail_screen.dart';
import 'package:yogesh_sharma/Screens/home.dart';
import 'package:yogesh_sharma/Screens/splash_screen.dart';
import 'package:yogesh_sharma/Services/Events/all_events_service.dart';
import 'package:yogesh_sharma/bloc/Events/all_event_events.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

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
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => EventDetailScreen(
              id: args,
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
