import 'package:flutter/material.dart';

goToWidget(BuildContext context, Widget myWidget) async {
  return Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
    return myWidget;
  }));
}

goToWidgetAndDisposeCurrent(BuildContext context, Widget myWidget) async {
  return Navigator.of(context)
      .pushReplacement(new MaterialPageRoute(builder: (context) {
    return myWidget;
  }));
}

goBackUntilFirstWidget(BuildContext context, {var result}) {
//  return Navigator.of(context).pushAndRemoveUntil(
//      new MaterialPageRoute(builder: (BuildContext context) => myWidget),
//      (Route<dynamic> route) => false);
}

popUpWidget(BuildContext context, Widget myWidget) async {
  return Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return myWidget;
      }));
}
