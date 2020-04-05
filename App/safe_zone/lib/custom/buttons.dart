import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({@required this.onPressed, @required this.title , @required this.isSelected});

  Function onPressed;
  String title;
  double width, height;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: isSelected ? Colors.green : Colors.white,
      splashColor: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Color(0xffaa1c56)),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
