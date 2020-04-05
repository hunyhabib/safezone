import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'book_screen.dart';

class LoginScreen extends StatelessWidget {
  navigateToBookingScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => BookScreen()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 30.0, left: 30.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/heart.png',
                      width: 200.0,
                      height: 220.0,
                    ),
                    Text('Safe Zone',
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                        width: 350.0,
                        height: 45.0,
                        child: RawMaterialButton(
                          fillColor: Colors.green,
                          splashColor: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Login using BankID",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            navigateToBookingScreen(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10.0))),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                        width: 350.0,
                        height: 45.0,
                        child: RawMaterialButton(
                          fillColor: Colors.blue,
                          splashColor: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Login using Facebook",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            navigateToBookingScreen(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                        width: 350.0,
                        height: 45.0,
                        child: RawMaterialButton(
                          fillColor: Colors.red,
                          splashColor: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Login using Google+",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            navigateToBookingScreen(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 45.0),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text('Continue as a guest without login',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.pink,
                        fontWeight: FontWeight.w500)),
              ),
            )
          ],
        ));
  }
}
