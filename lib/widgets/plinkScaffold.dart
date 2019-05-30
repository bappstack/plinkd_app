import 'package:flutter/material.dart';

class PlinkdScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final double curveRadius;
  final GlobalKey scaffoldKey;

  const PlinkdScaffold(
      {Key key,
      @required this.appBar,
      @required this.body,
      this.curveRadius = 20,
      this.scaffoldKey})
      : super(key: key);

  // git config --global user.name "robincruseo"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        //padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 5,
                  offset: Offset(0.5, 0.1))
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(curveRadius),
              topRight: Radius.circular(curveRadius),
            )),
      ),
    );
  }
}
