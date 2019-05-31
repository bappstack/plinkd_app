import 'package:Plinkd/backbone/AppEngine.dart';
import 'package:Plinkd/assets.dart';
import 'package:Plinkd/widgets/plinkScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:intl/intl.dart';

import 'MainActivity.dart';
import 'backbone/basemodel.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  PageController vpController = PageController();
  final formatter = DateFormat("d MMM y");
  var scaffoldKey = new GlobalKey<ScaffoldState>();

  String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genderList.add(dropDownItem("Male"));
    genderList.add(dropDownItem("Female"));
    getUserId();
  }

  getUserId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userId = user.uid;
  }

  //BuildContext con;
  int vpPosition = 0;
  List<DropdownMenuItem<String>> genderList = List();
  String myGender;
  String myAge = "";
  int dateOfBirth = 0;
  String email = "";
  String firstName = "";
  String lastName = "";
  String hometown = "";
  String city = "";
  double cityLat;
  double cityLon;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: orang0, statusBarBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: () {
        if (vpPosition == 0) {
          return;
        }

        vpPosition--;
        vpController.animateToPage(vpPosition,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      child: PlinkdScaffold(
          scaffoldKey: scaffoldKey,
          curveRadius: 25,
          appBar: Padding(
            padding: EdgeInsets.all(25),
            child: Text(
              "Create Account",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          body: page()),
    );
  }

  page() {
    return PageView.builder(
      itemBuilder: (c, p) {
        if (p == 0) return page1();
        //if (p == 1) return page2();
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      onPageChanged: (p) {
        setState(() {
          vpPosition = p;
        });
      },
      controller: vpController,
    );
  }

  page1() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        children: <Widget>[
          addSpace(20),
          inputItem("FIRST NAME", firstName, Icons.person, (s) {
            firstName = s;
          }, hint: "Enter First Name"),
          inputItem("LAST NAME", lastName, Icons.person, (s) {
            lastName = s;
          }, hint: "Enter Last Name"),
          new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 25,
                    color: black.withOpacity(.4),
                  ),
                  addSpaceWidth(10),
                  Flexible(
                    child: DropdownButton(
                      value: myGender,
                      style: textStyle(false, 20, black),
                      items: genderList,
                      onChanged: (s) {
                        setState(() {
                          myGender = s;
                        });
                      },
                      hint: Text(
                        "Select your gender",
                        style: textStyle(false, 17, black.withOpacity(.2)),
                      ),
                      underline: Container(),
                    ),
                  ),
                ],
              ),
              //addSpace(10),
              addLine(1, black.withOpacity(.1), 0, 0, 0, 20)
            ],
          ),
          inputItemTv("AGE", myAge, Icons.date_range, () {
            DatePicker.showDatePicker(context,
                currentTime: DateTime(1990, 1, 1),
                locale: LocaleType.en,
                showTitleActions: true, onConfirm: (date) {
              myAge = formatter.format(date);
              dateOfBirth = date.millisecondsSinceEpoch;
              setState(() {});
            }, onChanged: (date) {
              myAge = formatter.format(date);
              dateOfBirth = date.millisecondsSinceEpoch;
              setState(() {});
            });
          }, "Date of birth"),
          inputItem("HOMETOWN", hometown, Icons.home, (s) {
            hometown = s;
          }, hint: "Enter Hometown"),
          inputItemTv("CITY", city, Icons.location_city, () {
            findPlace();
          }, "Select your city"),
          addSpace(10),
          buttonItem("Create Account", () {
            if (firstName.trim().length < 2) {
              toast(scaffoldKey, "Enter your first name");
              return;
            }
            if (lastName.trim().length < 2) {
              toast(scaffoldKey, "Enter your last name");
              return;
            }
            if (myGender == null) {
              toast(scaffoldKey, "Select your gender");
              return;
            }
            if (dateOfBirth == 0) {
              toast(scaffoldKey, "Select your date of birth");
              return;
            }
            if (hometown.trim().isEmpty) {
              toast(scaffoldKey, "Enter your hometown");
              return;
            }
            if (city.trim().isEmpty) {
              toast(scaffoldKey, "Select your city");
              return;
            }

            createAccount();
          }),
          addSpace(50)
        ],
      ),
    );
  }

  createAccount() {
    showProgress(true, context);

    BaseModel model = BaseModel();
    model.put(FIRST_NAME, firstName);
    model.put(LAST_NAME, lastName);
    model.put(GENDER, myGender);
    model.put(DATE_OF_BIRTH, dateOfBirth);
    model.put(HOMETOWN, hometown);
    model.put(CITY, city);
    model.put(CITY_LAT, cityLat);
    model.put(CITY_LON, cityLon);
    model.saveItem(USER_BASE, true, document: userId, onComplete: () {
      showProgress(false, context);
      showMessage(context, Icons.check, blue0, "Successful",
          "Your account has been created successfully",
          clickYesText: "PROCEED", delayInMilli: 600, onClicked: (_) {
        if (_ == true) {
          pushAndResult(context, MainActivity());
        }
      });
    });
  }

  /*page2() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        children: <Widget>[
          addSpace(20),
          new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 25,
                    color: black.withOpacity(.4),
                  ),
                  addSpaceWidth(10),
                  Flexible(
                    child: DropdownButton(
                      value: myGender,
                      style: textStyle(false, 20, black),
                      items: genderList,
                      onChanged: (s) {
                        setState(() {
                          myGender = s;
                        });
                      },
                      hint: Text(
                        "Select your gender",
                        style: textStyle(false, 17, black.withOpacity(.2)),
                      ),
                      underline: Container(),
                    ),
                  ),
                ],
              ),
              //addSpace(10),
              addLine(1, black.withOpacity(.1), 0, 0, 0, 20)
            ],
          ),
          inputItem("JOB", job, Icons.work, (s) {
            job = s;
          }, hint: "Enter job"),
          inputItemTv("AGE", myAge, Icons.date_range, () {
            DatePicker.showDatePicker(context,
                currentTime: DateTime(1990, 1, 1),
                locale: LocaleType.en,
                showTitleActions: true, onConfirm: (date) {
              myAge = formatter.format(date);
              setState(() {});
            }, onChanged: (date) {
              myAge = formatter.format(date);
              setState(() {});
            });
          }, "Date of birth"),
          inputItem("DESCRIBE YOURSELF", about, Icons.edit, (s) {
            about = s;
          }, hint: "Describe yourself (Optional)", maxLines: 3),
          addSpace(10),
          buttonItem("Create Account", () {
            vpController.animateToPage(1,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          }),
          addSpace(50)
        ],
      ),
    );
  }*/

  buttonItem(text, onPressed, {color = black}) {
    return Container(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        onPressed: onPressed,
        color: color.withOpacity(.7),
        textColor: white,
        child: Text(
          text,
          style: textStyle(true, 16, white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  inputItem(String title, String text, icon, onChanged,
      {inputType = TextInputType.text,
      bool isPass = false,
      String hint = "",
      int maxLines = 1}) {
    TextEditingController controller = TextEditingController(text: text);
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: textStyle(true, 12, black.withOpacity(.4)),
        ),
        //addSpace(10),
        Row(
          crossAxisAlignment: maxLines != 1
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, maxLines == 1 ? 0 : 15, 0, 0),
              child: Icon(
                icon,
                size: 23,
                color: black.withOpacity(.4),
              ),
            ),
            addSpaceWidth(10),
            Flexible(
              child: new TextField(
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                //maxLength: 20,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: textStyle(false, 17, black.withOpacity(.2))),
                style: textStyle(false, 20, black),
                cursorColor: black,
                cursorWidth: 1,
                maxLines: maxLines,
                keyboardType: inputType,
                onChanged: onChanged,
                obscureText: isPass, controller: controller,
              ),
            ),
          ],
        ),
        //addSpace(10),
        addLine(1, black.withOpacity(.1), 0, 0, 0, 20)
      ],
    );
  }

  inputItemTv(String title, String text, icon, onTap, String hint) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: textStyle(true, 12, black.withOpacity(.4)),
        ),
        //addSpace(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 25,
              color: black.withOpacity(.4),
            ),
            addSpaceWidth(10),
            Flexible(
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          text.isEmpty ? hint : text,
                          style: textStyle(false, 17,
                              black.withOpacity(text.isEmpty ? (.2) : 1)),
                        ),
                      ),
                      addSpaceWidth(10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        //addSpace(10),
        addLine(1, black.withOpacity(.1), 0, 0, 0, 20)
      ],
    );
  }

  dropDownItem(String text) {
    return DropdownMenuItem(
      child: Text(
        text,
        style: textStyle(false, 18, black),
      ),
      value: text,
    );
  }

  bool canClickFind = true;
  findPlace() async {
    if (!canClickFind) return;
    canClickFind = false;

    Place place;
    try {
      place = await PluginGooglePlacePicker.showAutocomplete(
          PlaceAutocompleteMode.MODE_OVERLAY);
    } on Exception {
      place = null;
    }

    canClickFind = true;

    if (place != null) {
      String name = place.name;
      String address = place.address;
      double lat = place.latitude;
      double lon = place.longitude;

      setState((() {
        cityLat = lat;
        cityLon = lon;
        city = name;
      }));
    }
  }
}
