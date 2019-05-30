import 'package:flutter/material.dart';

class PLinkdGradientButton extends StatelessWidget {
  final double radius;
  final double padding;
  final Widget child;

  const PLinkdGradientButton(
      {Key key, this.radius, this.padding, @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15),
          gradient: LinearGradient(
            colors: [
              Color(0XFFe46514),
              Color(0XFFf79836),
            ],
          ),
          boxShadow: [
//            BoxShadow(
//              color: Colors.grey[500],
//              offset: Offset(0.0, 1.5),
//              blurRadius: 1.9,
//            ),
          ]),
      padding: EdgeInsets.all(padding ?? 20),
      alignment: Alignment.center,
      child: child,
    );
  }
}
