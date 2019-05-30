import 'package:flutter/material.dart';
import 'package:plinkd_app/utils/assets.dart';
import 'package:plinkd_app/widgets/plinkScaffold.dart';

class DealScreen extends StatefulWidget {
  @override
  _DealScreenState createState() => _DealScreenState();
}

class _DealScreenState extends State<DealScreen> {
  @override
  Widget build(BuildContext context) {
    return PlinkdScaffold(appBar: dealAppBar(), body: dealBody());
  }

  scaffoldBody() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0XFFe46514),
        Color(0XFFf79836),
      ])),
      child: Column(
        children: <Widget>[dealAppBar(), dealBody()],
      ),
    );
  }

  dealAppBar() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(maugostImage),
          ),
          Text(
            "Deals",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 45,
            child: Image.asset(
              album_icon,
            ),
          )
        ],
      ),
    );
  }

  dealBody() {
    return ListView(
      padding: EdgeInsets.only(top: 50),
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey)),
              hintText: "Add Deals"),
        ),
        SizedBox(
          height: 25,
        ),
        RawMaterialButton(
          fillColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Color(0XFFe46514),
                  Color(0XFFf79836),
                ])),
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              "Create a deal",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
