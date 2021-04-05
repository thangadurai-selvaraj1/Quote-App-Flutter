import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quote_app/ui/DashBoardPage.dart';
import 'package:quote_app/utils/ImagePaths.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashBoardPage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Image.asset(
          ImagePaths.QUOTE_LOGO,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
