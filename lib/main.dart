import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/screen_gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Directory dir = Directory.fromUri(Uri.parse(
        '/storage/emulated/0/Android/data/com.example.gallery_app/files'));
    takepic(dir);
  }

  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Screen_Gallery(),
    );
  }
}
