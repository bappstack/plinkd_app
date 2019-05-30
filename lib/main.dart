import 'package:flutter/material.dart';
import 'package:plinkd_app/screens/dealScreen.dart';
import 'package:plinkd_app/screens/numberVerified.dart';

import 'screens/addFriendScreen.dart';
import 'screens/peopleMayKnowScreen.dart';
import 'utils/assets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: poppinFont),
      home: NumberVerified(),
    );
  }
}
