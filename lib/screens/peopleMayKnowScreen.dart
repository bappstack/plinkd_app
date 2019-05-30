import 'package:flutter/material.dart';
import 'package:plinkd_app/utils/assets.dart';
import 'package:plinkd_app/widgets/gradientButtons.dart';
import 'package:plinkd_app/widgets/plinkScaffold.dart';

class PeopleMayKnowScreen extends StatefulWidget {
  @override
  _PeopleMayKnowScreenState createState() => _PeopleMayKnowScreenState();
}

class _PeopleMayKnowScreenState extends State<PeopleMayKnowScreen> {
  @override
  Widget build(BuildContext context) {
    return PlinkdScaffold(
        curveRadius: 25, appBar: buildAppBar(), body: buildBody());
  }

  buildAppBar() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Text(
        "People you might know",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  buildBody() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(google_map_bg), fit: BoxFit.cover)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          ListView.separated(
            itemCount: 8,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return buildMayKnowItemBuilder(
                  imageURl: maugostImage,
                  friendsCount: 30,
                  fullName: "Maugost Mtellect",
                  onPressed: () {});
            },
            separatorBuilder: (context, index) {
              return Divider(
                  //color: Colors.transparent,
                  );
            },
          ),
          SafeArea(
            child: RaisedButton(
              color: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {},
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.navigate_next,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMayKnowItemBuilder({
    @required String imageURl,
    @required String fullName,
    @required int friendsCount,
    @required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(imageURl),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      fullName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("$friendsCount friends on plinkd"),
                  ],
                ),
              ],
            ),
            PLinkdGradientButton(
                padding: 5,
                radius: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
