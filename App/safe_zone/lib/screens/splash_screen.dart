import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  splashDelay(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => LoginScreen()), (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    splashDelay(context);
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          "assets/images/heart.png",
          height: 200.0,
          width: 200.0,
        ),
      ),
    );
  }
}
