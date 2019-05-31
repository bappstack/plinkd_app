import 'package:Plinkd/backbone/AppEngine.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../main.dart';

class ImagePreview extends StatelessWidget {
  final String imageURL;
  final List imagesUrl;
  final int initialPicture;
  ImagePreview({this.imageURL, this.imagesUrl, this.initialPicture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          if (imagesUrl != null)
            Container(
                child: PhotoViewGallery(
              pageController: PageController(initialPage: initialPicture),
              scrollPhysics: const BouncingScrollPhysics(),
              pageOptions: List<PhotoViewGalleryPageOptions>.generate(
                  imagesUrl.length, (index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imagesUrl[index]),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroTag: index,
                );
              }),
              //loadingChild: showProgress(true,context),
              backgroundDecoration: BoxDecoration(color: Colors.black),
            ))
          else
            Container(
                child: PhotoView(
              imageProvider: NetworkImage(imageURL),
              //loadingChild: showProgress(true,context),
              backgroundDecoration: BoxDecoration(color: Colors.black),
            )),
          new SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
