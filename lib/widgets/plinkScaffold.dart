import 'package:flutter/material.dart';

class PlinkdScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final double curveRaduis;
  const PlinkdScaffold({Key key, @required this.appBar, @required this.body, this.curveRaduis=20})
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
        child: Column(
          children: <Widget>[scaffoldAppBar(), scaffoldBody()],
        ),
      ),
    );
  }

  scaffoldAppBar() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: appBar,
      ),
    );
  }

  scaffoldBody() {
    return Flexible(
      child: Container(
        child: body,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(curveRaduis),
              topRight: Radius.circular(curveRaduis),
            )),
      ),
    );
  }
}
