import 'dart:async';

import 'package:Plinkd/widgets/avatarBuilder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import '../assets.dart';
import '../main.dart';
import 'package:map_overlay/map_overlay.dart';

class PlinkdMapHome extends StatefulWidget {
  @override
  _PlinkdMapHomeState createState() => _PlinkdMapHomeState();
}

class _PlinkdMapHomeState extends State<PlinkdMapHome> {
  int delay = 10;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.4223705, -122.0843794),
    zoom: 10.4746,
  );
  static final CameraPosition _kNearGooglePlex = CameraPosition(
    target: LatLng(37.4084642, -122.0717857),
    zoom: 14.4746,
  );
  void onFloatingPressed() {
    if (delay == 10) {
      setState(() {
        delay = 0;
      });
    } else {
      setState(() {
        delay = 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
        buildMapLayout(),
        buildBottomViews()
          ,buildProfileBTN()
        ],
      ),
    );
  }

  buildProfileBTN(){
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: IconButton(icon: Icon(Icons.person,size: 40,), onPressed: (){

        }),
      ),
    );
  }

  buildMapLayout(){
    return  GoogleMapOverlay(
      mapOptions: GoogleMapOptions(initialCameraPosition: _kGooglePlex,myLocationButtonEnabled: false),
      overlays: <MapOverlayWidgetContainer>[
        MapOverlayWidgetContainer(
          offset: Offset(0, 0),
          position: _kGooglePlex.target,
          child: AvatarBuilder(
            imageUrl: maugostImage,
            onlineStatus: 1,
          ),
        ),
        MapOverlayWidgetContainer(
          offset: Offset(1, 1),
          position: _kNearGooglePlex.target,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: AvatarBuilder(
              imageUrl: maugostImage,
              onlineStatus: 1,
            ),
          ),
        ),
      ],
    );
  }

  buildBottomViews(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildButtonsView(
                onPressed: (){

                },
                color: Colors.white,
                icon: Icons.forum,
               padding: 22
              ),

              buildButtonsView(
                  onPressed: (){

                  },
                  color: plinkdColor,
                  iconColor: Colors.white,
                  icon: Icons.camera_alt,
                  padding: 25
              ),

              buildButtonsView(
                  onPressed: (){

                  },
                  color: Colors.white,
                  icon: Icons.rss_feed,
                  padding: 22
              )
            ],
          ),
        )
      ),
    );
  }

  buildButtonsView({Color color,Color iconColor, IconData icon,double padding,VoidCallback onPressed }) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon,color:iconColor??Colors.black ,),
      fillColor: color,
      padding: EdgeInsets.all(padding),
      shape: CircleBorder()
    );
  }
}

