import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_app/Screen_1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

ValueNotifier<List> store = ValueNotifier([]);

// ignore: camel_case_types
class Screen_Gallery extends StatefulWidget {
  const Screen_Gallery({Key? key}) : super(key: key);

  @override
  State<Screen_Gallery> createState() => _Screen_GalleryState();
}

// ignore: camel_case_types
class _Screen_GalleryState extends State<Screen_Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 43, 41, 41),
        onPressed: () async {
          final img = await ImagePicker().pickImage(source: ImageSource.camera);
          if (img == null) {
            return;
          } else {
            Directory? dir = await getExternalStorageDirectory();
            File imagepath = File(img.path);
            await imagepath.copy('${dir!.path}/${DateTime.now()}.jpg');
            takepic(dir);
          }
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 41, 41),
        title: const Text(
          'Gallery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 43, 41, 41)),
      ),
      body: ValueListenableBuilder(
        valueListenable: store,
        builder: (context, List data, anything) {
          return GridView.builder(
              itemCount: store.value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            Screen_pic(image: data[index], tagForHero: index),
                      ),
                    );
                  },
                  child: Hero(
                    tag: index,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(
                              File(
                                data[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

takepic(Directory dir) async {
  final listDir = await dir.list().toList();
  store.value.clear();
  for (var i = 0; i < listDir.length; i++) {
    store.value.add(listDir[i].path);
    store.notifyListeners();
  }
}
