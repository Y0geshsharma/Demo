import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({this.id});
  final int id;
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('chrckout'),
    );
  }
}
