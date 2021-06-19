import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'launch_image.png',
                height: 123,
                width: 123,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Container(
                    height: 114,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromRGBO(255, 255, 255, 0.65),
                              strokeWidth: 3,
                            )),
                        Text(
                          '© 2020 Are you in App. All rights reserved',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
