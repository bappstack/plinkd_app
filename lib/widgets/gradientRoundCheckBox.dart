import 'package:flutter/material.dart';

class GradientCheckBox extends StatelessWidget {
  final double boxSize;
  final double padding;
  final bool active;
  final Widget child;

  const GradientCheckBox(
      {Key key,
      this.padding,
      @required this.child,
      this.boxSize = 20,
      this.active = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxSize,
      width: boxSize,
      decoration: active
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0XFFe46514),
                  Color(0XFFf79836),
                ],
              ),
              shape: BoxShape.circle,
            )
          : BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
      padding: EdgeInsets.all(padding ?? 20),
      alignment: Alignment.center,
      child: child,
    );
  }
}
