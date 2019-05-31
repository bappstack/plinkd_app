import 'package:Plinkd/pre_launch/PhoneVerification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Plinkd/screens/dealScreen.dart';

import 'MainActivity.dart';
import 'Signup.dart';
import 'backbone/basemodel.dart';
import 'dialogs/progressDialog.dart';
import 'screens/addFriendScreen.dart';
import 'screens/peopleMayKnowScreen.dart';
import 'package:Plinkd/assets.dart';

void main() => runApp(MyApp());

BaseModel userModel;
bool showProgressLayout = false;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    checkUser();
    return MaterialApp(
      title: 'Plinkd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange, fontFamily: poppinBold),
      color: white,
      home: Builder(
        builder: (context) {
          this.context = context;
          return Container();
        },
      ),
    );
  }

  checkUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
        return PhoneVerification();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
        return MainActivity();
      }));
    }
  }
}
