import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({@required this.onPressed, @required this.title});

  Function onPressed;
  String title;
  double width, height;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      splashColor: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          title,
          style: TextStyle(color: Color(0xffaa1c56)),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
