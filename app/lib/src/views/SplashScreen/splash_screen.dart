import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ],
        ),
    );
  }
}