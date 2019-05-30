import 'package:flutter/material.dart';
import 'package:plinkd_app/utils/assets.dart';
import 'package:plinkd_app/widgets/gradientBackground.dart';

class NumberVerified extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Number Verified',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 90,
            width: 90,
            margin: EdgeInsets.only(top: 30, bottom: 30),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              size: 40,
              color: plinkdColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'Your Telephone Number has been Verified',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: RaisedButton(
              onPressed: () {},
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                'Continue',
                style: TextStyle(
                    color: plinkdColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
