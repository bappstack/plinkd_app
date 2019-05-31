import 'package:Plinkd/backbone/AppEngine.dart';
import 'package:Plinkd/assets.dart';
import 'package:Plinkd/dialogs/phoneDialog.dart';
import 'package:Plinkd/widgets/plinkScaffold.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Signup.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  String countryCode = "+234";
  TextEditingController phoneControl = new TextEditingController();
  TextEditingController codeControl = new TextEditingController();
  var scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  BuildContext con;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: orange0, statusBarBrightness: Brightness.dark));
    return PlinkdScaffold(
        scaffoldKey: scaffoldKey,
        curveRadius: 25,
        appBar: Padding(
          padding: EdgeInsets.all(25),
          child: Text(
            "Sign up",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Builder(builder: (c) {
          con = c;
          return page();
        }));
  }

  page() {
    return Container(
      child: Column(
        children: <Widget>[addSpace(20), verifying ? pageCode() : pagePhone()],
      ),
    );
  }

  bool verifying = false;
  String phoneNumber = "";
  String verificationId = "";
  String smsCode = "";
  int forceResendingToken = 0;
  bool verified = false;
  String timeText = "";
  String oldText = "";
  int time = 0;
  final progressId = getRandomId();

  createTimer(bool create) {
    if (create) {
      time = 60;
    }
    if (time < 0) {
      setState(() {
        timeText = "";
      });
      return;
    }
    timeText = getTimeText();
    Future.delayed(Duration(seconds: 1), () {
      time--;
      setState(() {});
      createTimer(false);
    });
  }

  getTimeText() {
    if (time <= 0) return "";
    return "${time >= 60 ? "01" : "00"}:${time % 60}";
  }

  clickVerify() {
    showProgress(true, context, msg: "Sending sms code...");
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: (AuthCredential auth) {
        signin(auth);
      },
      verificationFailed: (AuthException authException) {
        showProgress(false, context);
        showMessage(
            context, Icons.warning, red0, "Error", authException.message,
            delayInMilli: 600);
        /*toastInAndroid(
              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');*/
      },
      codeSent: (s, [x]) {
        //toastInAndroid("Code sent");
        createTimer(true);
        showProgress(false, context);
        verifying = true;
        verificationId = s;
        forceResendingToken = x;
        setState(() {});
      },
      codeAutoRetrievalTimeout: null,
      forceResendingToken: forceResendingToken,
    );
  }

  checkCode() {
    String code = codeControl.text.trim();
    if (code.isEmpty) {
      toast(scaffoldKey, "Enter the sms code sent to you or click resend code");
      return;
    }

    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);

    signin(credential);
  }

  signin(AuthCredential credential) {
    showProgress(true, context, msg: "Verifying Code...");

    FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      showProgress(false, context);
      if (user != null) {
        nextScreen();
      } else {
        showMessage(context, Icons.warning, red0, "Error", "Please try again",
            delayInMilli: 600);
      }
    }, onError: (error) {
      showProgress(false, context);
      showMessage(context, Icons.warning, red0, "Invalid Code",
          "Please check the code and try again",
          delayInMilli: 600);
    });
  }

  nextScreen() {
    if (verified) return;
    verified = true;
    Future.delayed(Duration(milliseconds: 600), () {
      Navigator.pushReplacement(con, MaterialPageRoute(builder: (c) {
        return Signup();
      }));
    });
  }

  pageCode() {
    return new Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*addSpace(10),
              Text(
                "Verfification",
                style: textStyle(true, 14, black),
              ),
              addSpace(20),*/
              new Container(
                height: 50,
                width: 170,
                child: new TextField(
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                  //maxLength: 20,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "- - - - -",
                      hintStyle: textStyle(false, 40, black.withOpacity(.2))),
                  textAlign: TextAlign.center,
                  style: textStyle(true, 40, black),
                  controller: codeControl,
                  cursorColor: black.withOpacity(.5),
                  cursorWidth: 2,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  onChanged: (newText) {
                    if (newText.length <= 6) {
                      oldText = newText;
                    } else {
                      codeControl.text = oldText;
                    }

                    String s = codeControl.text;
                    if (s.trim().length == 6) {
                      checkCode();
                    }
                  },
                ),
              ),
              Container(
                width: 130,
                height: 2,
                color: black,
              ),
              addSpace(10),
              Text(
                "Enter the 6 digit number sent to you",
                style: textStyle(true, 12, black.withOpacity(.5)),
              ),
              addSpace(15),
              Opacity(
                opacity: timeText.isEmpty ? 1 : (.3),
                child: Container(
                  height: 35,
                  width: 105,
                  child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                              color: black.withOpacity(.1), width: .5)),
                      color: default_white,
                      onPressed: () {
                        if (timeText.isEmpty) {
                          clickVerify();
                        }
                      },
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // addSpaceWidth(5),
                          Text(
                            "Resend Code",
                            style: textStyle(true, 12, black),
                          ),
                          timeText.isEmpty
                              ? Container()
                              : Text(
                                  timeText,
                                  style: textStyle(false, 10, black),
                                ),
                          //addSpaceWidth(5),
                        ],
                      )),
                ),
              ),
              addSpace(40),
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    checkCode();
                  },
                  color: black.withOpacity(.7),
                  textColor: white,
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "NirmalaB",
                        fontWeight: FontWeight.normal,
                        color: white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              addSpace(100)
            ],
          ),
        ),
      ),
    );
  }

  pagePhone() {
    return new Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Enter your mobile number",
                style: textStyle(false, 14, black),
              ),
              addSpace(10),
              new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pickCountry(context, (Country _) {
                        countryCode = "+${_.phoneCode}";
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                          color: black.withOpacity(.1),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          countryCode,
                          style: textStyle(true, 14, black.withOpacity(.7)),
                        ),
                      ),
                    ),
                  ),
                  addSpaceWidth(10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          height: 50,
                          child: new TextField(
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.sentences,
                            autofocus: true,
                            //maxLength: 20,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "08033325646",
                                hintStyle: textStyle(
                                    false, 20, black.withOpacity(.2))),
                            style: textStyle(false, 20, black),
                            controller: phoneControl,
                            cursorColor: black,
                            cursorWidth: 1,
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              addLine(2, black.withOpacity(.2), 0, 0, 0, 10),
              Text(
                "We'll send you a text verification code.",
                style: textStyle(true, 12, black.withOpacity(.5)),
              ),
              addSpace(40),
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    String text = phoneControl.text.trim();
                    if (text.isEmpty) {
                      toast(scaffoldKey, "Please enter your phone number");
                      return;
                    }

                    if (text.startsWith("0")) {
                      text = text.replaceFirst("0", "").trim();
                    }
                    phoneNumber = "$countryCode$text";

                    showMessage(
                        context,
                        Icons.phone_android,
                        blue0,
                        phoneNumber,
                        "Please verify that this is your phone number",
                        clickYesText: "Proceed",
                        clickNoText: "Edit Number", onClicked: (_) {
                      if (_ == true) {
                        clickVerify();
                      }
                    });
                  },
                  color: black.withOpacity(.7),
                  textColor: white,
                  child: Text(
                    "Continue",
                    style: textStyle(true, 18, white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              addSpace(100)
            ],
          ),
        ),
      ),
    );
  }
}
