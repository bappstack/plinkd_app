import 'dart:async';
import 'dart:io';

import 'package:Plinkd/Signup.dart';
import 'package:Plinkd/assets.dart';
import 'package:Plinkd/backbone/AppEngine.dart';
import 'package:Plinkd/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'backbone/basemodel.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  List<StreamSubscription> subscriptions = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBasicListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (StreamSubscription sub in subscriptions) sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Container(
          color: orange0,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Main Activity",
                  style: textStyle(true, 20, white),
                ),
                addSpace(20),
                new Container(
                  height: 30,
                  child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: white,
                      onPressed: () {
                        yesNoDialog(context, "Logout?", "Are you sure?", () {
                          FirebaseAuth.instance.signOut();
                          Future.delayed(Duration(seconds: 1), () {
                            exit(0);
                          });
                        });
                      },
                      child: Text(
                        "Logout",
                        style: textStyle(true, 12, black),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  bool hasStarted = false;
  createBasicListeners() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      var sub = Firestore.instance
          .collection(USER_BASE)
          .document(user.uid)
          .snapshots()
          .listen((shot) async {
        if (!hasStarted) {
          hasStarted = true;
          if (!shot.exists) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
              return Signup();
            }));
            return;
          }
        }
        userModel = BaseModel(doc: shot);
      });
      subscriptions.add(sub);
    }
  }
}
