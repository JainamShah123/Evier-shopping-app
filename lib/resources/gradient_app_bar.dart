import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double barHeight = 66.0;
    return new Container(
      height: barHeight,
      decoration: new BoxDecoration(color: Colors.blue),
      child: new Center(
        child: new Text(
          "Evier",
        ),
      ),
    );
  }
}
