import 'package:Plinkd/backbone/AppEngine.dart';
import 'package:Plinkd/assets.dart';
import 'package:Plinkd/widgets/plinkScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  PageController vpController = PageController();
  final formatter = DateFormat("d MMM y");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genderList.add(dropDownItem("Male"));
    genderList.add(dropDownItem("Female"));
  }

  BuildContext con;
  int vpPosition = 0;
  List<DropdownMenuItem<String>> genderList = List();
  String myGender;
  String myAge = "";
  int dateOfBirth;
  String email = "";
  String firstName = "";
  String lastName = "";
  String pass1 = "";
  String pass2 = "";
  String job = "";
  String about = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: orang0, statusBarBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: () {
        if (vpPosition == 0) {
          Navigator.pop(context);
          return;
        }

        vpPosition--;
        vpController.animateToPage(vpPosition,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      child:
          PlinkdScaffold(curveRadius: 25, appBar: buildAppBar(), body: page()),
    );
  }

  buildAppBar() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Text(
        "Create Account",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  page() {
    return PageView.builder(
      itemBuilder: (c, p) {
        if (p == 0) return page1();
        if (p == 1) return page2();
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
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
          inputItem("EMAIL ADDRESS", email, Icons.email, (s) {
            email = s;
          },
              inputType: TextInputType.emailAddress,
              hint: "Enter Email Address"),
          inputItem("FIRST NAME", firstName, Icons.person, (s) {
            firstName = s;
          }, hint: "Enter First Name"),
          inputItem("LAST NAME", lastName, Icons.person, (s) {
            lastName = s;
          }, hint: "Enter Last Name"),
          inputItem("PASSWORD", pass1, Icons.lock, (s) {
            pass1 = s;
          }, isPass: true, hint: "Enter Password"),
          inputItem("CONFIRM PASSWORD", pass2, Icons.lock, (s) {
            pass2 = s;
          }, isPass: true, hint: "Retype Password"),
          addSpace(10),
          buttonItem("Continue", () {
            if (!isEmailValid(email)) {
              toast(con, "Enter a valid email address");
              return;
            }
            if (firstName.trim().length < 2) {
              toast(con, "Enter your first name");
              return;
            }
            if (lastName.trim().length < 2) {
              toast(con, "Enter your last name");
              return;
            }
            if (pass1.length < 6) {
              toast(con, "Your password should not be less that 6 characters");
              return;
            }
            if (pass1 != pass2) {
              toast(con, "Your password does not match");
              return;
            }

            vpController.animateToPage(1,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          }),
          addSpace(50)
        ],
      ),
    );
  }

  page2() {
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
  }

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
          style: TextStyle(
              fontSize: 15,
              fontFamily: "NirmalaB",
              fontWeight: FontWeight.normal,
              color: white),
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
          style: textStyle(false, 12, black.withOpacity(.4)),
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
}
