import 'package:flutter/material.dart';
import 'package:yogesh_sharma/Routes/route_generator.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Demo',
      theme: ThemeData(accentColor: Color(0xFF7555CF)),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
