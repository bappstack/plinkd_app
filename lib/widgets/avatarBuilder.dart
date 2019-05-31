import 'package:Plinkd/utils/navigationUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import 'imagePreview.dart';

class AvatarBuilder extends StatelessWidget {
  final String imageUrl;
  final int onlineStatus;
  final double avatarSize;
  final double holderSize;
  //https://bit.ly/2HYMYBp
  const AvatarBuilder(
      {Key key,
      this.imageUrl = "",
      this.onlineStatus = -1,
      this.avatarSize = 95.0,
      this.holderSize = 25.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildAvatar(context);
  }

  _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imageUrl.isEmpty) {
          return;
        }

        popUpWidget(
            context,
            ImagePreview(
              imageURL: imageUrl,
            ));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: avatarSize,
            width: avatarSize,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: retrieveStatusColor(), width: 3)),
          ),
          Container(
            height: avatarSize - 5,
            width: avatarSize - 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(avatarSize - 5 / 2),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: avatarSize,
                width: avatarSize,
                placeholder: (_, s) {
                  return Container(
                    height: avatarSize,
                    width: avatarSize,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: holderSize,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.green.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }

  retrieveStatusColor() {
    if (onlineStatus == 0) {
      return Colors.green[800];
    }
    if (onlineStatus == 1) {
      return plinkdColor;
    }
    if (onlineStatus == 2) {
      return Colors.white;
    }

    return Colors.transparent;
  }
}
