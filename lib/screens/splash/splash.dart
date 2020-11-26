import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/screens/wrapper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Wrapper())
            );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/splash.gif'), fit: BoxFit.contain),
      ),
    );
  }
}
