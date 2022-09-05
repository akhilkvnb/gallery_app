import 'dart:io';
import 'package:flutter/material.dart';

import 'package:gallery_app/screen_gallery.dart';

// ignore: camel_case_types
class Screen_pic extends StatelessWidget {
  const Screen_pic({Key? key, this.image, required this.tagForHero})
      : super(key: key);

  final dynamic image;
  final int tagForHero;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 59, 61, 61),
              Color.fromARGB(255, 39, 41, 39)
            ]),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: ValueListenableBuilder(
            valueListenable: store,
            builder: (context, List data, _) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Hero(
                      tag: tagForHero,
                      child: Image.file(File(image.toString()))),
                ),
              );
            }),
      ),
    );
  }
}
