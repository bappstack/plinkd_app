import 'package:flutter/material.dart';
import 'package:Plinkd/screens/dealScreen.dart';

import 'Signup.dart';
import 'backbone/basemodel.dart';
import 'screens/addFriendScreen.dart';
import 'screens/peopleMayKnowScreen.dart';
import 'package:Plinkd/assets.dart';

void main() => runApp(MyApp());

BaseModel userModel;
bool showProgressLayout = false;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plinkd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange, fontFamily: poppinBold),
      home: Signup(),
    );
  }
}
