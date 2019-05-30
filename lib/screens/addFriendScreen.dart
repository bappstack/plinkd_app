import 'package:Plinkd/assets.dart';
import 'package:flutter/material.dart';
import 'package:Plinkd/widgets/gradientRoundCheckBox.dart';
import 'package:Plinkd/widgets/plinkScaffold.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return PlinkdScaffold(
        curveRadius: 25, appBar: buildAppBar(), body: buildBody());
  }

  buildAppBar() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Text(
        "Add friend from contact",
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
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[300])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Search from contact",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 25,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: ListView.separated(
                  itemCount: 8,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    bool active =
                        (index == 0 || index == 1 || index == 7) ? false : true;
                    return buildMayKnowItemBuilder(
                        imageURl: maugostImage,
                        friendsCount: 30,
                        fullName: "Maugost Mtellect",
                        onPressed: () {},
                        active: active);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                        //color: Colors.transparent,
                        );
                  },
                ),
              ),
            ],
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
    @required bool active,
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
            GradientCheckBox(
              boxSize: 25,
              padding: 0,
              active: active,
              child: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
