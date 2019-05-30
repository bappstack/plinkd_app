import 'package:flutter/material.dart';

class  GradientBackground extends StatelessWidget {

  final Widget child;
  final double curveRadius;
  const GradientBackground(
      {Key key,
      @required this.child,

      this.curveRadius = 20})
      : super(key: key);
  // git config --global user.name "robincruseo"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0XFFe46514),
          Color(0XFFf79836),
        ])),
       child: SafeArea(child: child),
      ),
    );
  }




}
