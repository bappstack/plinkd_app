import 'package:flutter/material.dart';
import 'package:plinkd_app/screens/numberVerified.dart';

import 'utils/assets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plink App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: poppinFont),
      home: NumberVerified(),
    );
  }
}
