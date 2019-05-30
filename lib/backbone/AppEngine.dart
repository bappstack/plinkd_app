import 'dart:async';

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:Plinkd/assets.dart';
import 'package:Plinkd/dialogs/messageDialog.dart';
import 'package:Plinkd/dialogs/progressDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../main.dart';

toast(scaffoldKey, text) {
  return scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Text(
        text,
        style: textStyle(false, 15, white),
      ),
    ),
    duration: Duration(seconds: 2),
  ));
}

SizedBox addSpace(double size) {
  return SizedBox(
    height: size,
  );
}

addSpaceWidth(double size) {
  return SizedBox(
    width: size,
  );
}

Container addLine(
    double size, color, double left, double top, double right, double bottom) {
  return Container(
    height: size,
    width: double.infinity,
    color: color,
    margin: EdgeInsets.fromLTRB(left, top, right, bottom),
  );
}

Container bigButton(double height, double width, String text, textColor,
    buttonColor, onPressed) {
  return Container(
    height: height,
    width: width,
    child: RaisedButton(
      onPressed: onPressed,
      color: buttonColor,
      textColor: white,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20,
            fontFamily: "NirmalaB",
            fontWeight: FontWeight.normal,
            color: textColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}

textStyle(bool bold, double size, color, {underlined = false}) {
  return TextStyle(
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontFamily: bold ? poppinBold : poppinNormal,
      fontSize: size,
      decoration: underlined ? TextDecoration.underline : TextDecoration.none);
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> getLocalFile(String name) async {
  final path = await _localPath;
  return File('$path/$name');
}

Future<File> getDirFile(String name) async {
  final dir = await getExternalStorageDirectory();
  var testDir = await Directory("${dir.path}/Plinkd").create(recursive: true);
  return File("${testDir.path}/$name");
}

Future<void> toastInAndroid(String text) async {
  const platform = const MethodChannel("channel.john");
  try {
    await platform.invokeMethod('toast', <String, String>{'message': text});
  } on PlatformException catch (e) {
    //batteryLevel = "Failed to get what he said: '${e.message}'.";
  }
}

tabIndicator(int tabCount, int currentPosition, {double alpha = 1}) {
  return Container(
    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
    //margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
    decoration: BoxDecoration(
        color: black.withOpacity(alpha),
        borderRadius: BorderRadius.circular(25)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: getTabs(tabCount, currentPosition),
    ),
  );
}

getTabs(int count, int cp) {
  List<Widget> items = List();
  for (int i = 0; i < count; i++) {
    bool selected = i == cp;
    items.add(Container(
      width: selected ? 10 : 8,
      height: selected ? 10 : 8,
      //margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
          color: white.withOpacity(selected ? 1 : (.5)),
          shape: BoxShape.circle),
    ));
    if (i != count - 1) items.add(addSpaceWidth(5));
  }

  return items;
}

void showProgress(bool show, BuildContext context,
    {String msg, bool cancellable = false}) {
  if (!show) {
    showProgressLayout = false;
    return;
  }

  showProgressLayout = true;

  pushAndResult(
      context,
      progressDialog(
        message: msg,
        cancelable: cancellable,
      ));
}

void showMessage(context, icon, iconColor, title, message,
    {int delayInMilli = 0,
    clickYesText = "OK",
    onClicked,
    clickNoText,
    bool cancellable = false}) {
  Future.delayed(Duration(milliseconds: delayInMilli), () {
    pushAndResult(
        context,
        messageDialog(
          icon,
          iconColor,
          title,
          message,
          clickYesText,
          noText: clickNoText,
          cancellable: cancellable,
        ),
        result: onClicked);
  });
}

bool isEmailValid(String email) {
  if (!email.contains("@") || !email.contains(".")) return false;
  return true;
}

gradientLine({double height = 4, bool reverse = false, alpha = .3}) {
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: reverse
                ? [
                    black.withOpacity(alpha),
                    transparent,
                  ]
                : [transparent, black.withOpacity(alpha)])),
  );
}

openLink(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}

void yesNoDialog(context, title, message, clickedYes,
    {bool cancellable = true}) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionsBuilder: transition,
          opaque: false,
          pageBuilder: (context, _, __) {
            return messageDialog(
              Icons.warning,
              red0,
              title,
              message,
              "Yes",
              noText: "No, Cancel",
              cancellable: cancellable,
            );
          })).then((_) {
    if (_ != null) {
      if (_ == true) {
        clickedYes();
      }
    }
  });
}

pushAndResult(context, item, {result}) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionsBuilder: transition,
          opaque: false,
          pageBuilder: (context, _, __) {
            return item;
          })).then((_) {
    if (_ != null) {
      if (result != null) result(_);
    }
  });
}

Widget transition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

String getRandomId() {
  var uuid = new Uuid();
  return uuid.v1();
}
