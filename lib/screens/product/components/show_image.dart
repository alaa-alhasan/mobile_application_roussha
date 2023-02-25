import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:roussha_store/app_properties.dart';

class ShowImage extends StatelessWidget {

  final String url;

  ShowImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparentGrey,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(url),
        enableRotation: true,
      )
    );
  }
}
