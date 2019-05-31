import 'dart:async';
import 'dart:async';
import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:Plinkd/backbone/AppEngine.dart';
import 'package:Plinkd/assets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

/*class progressDialog extends StatefulWidget {
  String id;
  String message;
  bool cancelable;
  BuildContext context;

  progressDialog(id, {bool cancelable = false, message = ""}) {
    this.id = id;
    this.message = message;
    this.cancelable = cancelable;
  }

  @override
  _progressDialogState createState() {
    return _progressDialogState(id, message: message, cancelable: cancelable);
  }
}*/

class progressDialog extends StatelessWidget {
  String message;
  bool cancelable;
  BuildContext context;

  progressDialog({this.cancelable = false, this.message = ""});

  void hideHandler() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (!showProgressLayout) {
        Navigator.pop(context);
        return;
      }

//      setState(() {
//      });
      //message = currentProgressText;

      hideHandler();
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    hideHandler();

    return WillPopScope(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        GestureDetector(
          onTap: () {
            //if(cancelable)Navigator.pop(context);
          },
          child: Container(
            color: black.withOpacity(.7),
          ),
        ),
        page()
      ]),
      onWillPop: () {
        if (cancelable) Navigator.pop(context);
      },
    );
  }

  page() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: black.withOpacity(.8),
        ),
        Center(
            child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(15)),
        )),
        Center(
          child: Opacity(
            opacity: .3,
            child: Image.asset(
              ic_launcher,
              width: 20,
              height: 20,
            ),
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            //value: 20,
            valueColor: AlwaysStoppedAnimation<Color>(blue3),
            strokeWidth: 2,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: new Container(),
              flex: 1,
            ),
            message == null || message.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      message,
                      style: textStyle(false, 15, white),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
