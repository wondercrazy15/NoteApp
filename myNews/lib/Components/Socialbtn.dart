import 'package:flutter/material.dart';

class Socialbtn extends StatelessWidget{
  Socialbtn({this.onPress,this.icon,this.height,this.width});
  final Function onPress;
  final String icon;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return
       GestureDetector(
        onTap: onPress,
        child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
              AssetImage(icon),
              fit: BoxFit.cover),
          shape: BoxShape.circle,
        ),
      ),

      );
  }

}