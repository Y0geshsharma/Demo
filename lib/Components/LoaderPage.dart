import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ));
  }
}
