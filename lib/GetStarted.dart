import 'package:flutter/material.dart';

import 'Login.dart';
import 'Signup.dart';
import 'assets.dart';
import 'utils/navigationUtils.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(getstarted), fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  logo_text,
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Let's get started",
                  style: TextStyle(
                      color: plinkTxtColor, letterSpacing: 1, fontSize: 16),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        goToWidget(context, Signup());
                      },
                      padding: EdgeInsets.all(20),
                      color: plinkBtnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      onPressed: () {
                        goToWidget(context, Login());
                      },
                      padding: EdgeInsets.all(20),
                      color: plinkBtnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//git push --set-upstream origin ios_functional
