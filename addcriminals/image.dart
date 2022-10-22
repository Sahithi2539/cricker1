import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../upload/storage.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? image;
  Storage _storage = new Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload one image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 140,
                width: 180,
                color: Colors.black12,
                child: image == null
                    ? Icon(
                        Icons.image,
                        size: 50,
                      )
                    : Image.file(
                        image!,
                        fit: BoxFit.fill,
                      )),
            ElevatedButton(
                child: Text('pick image'),
                onPressed: () {
                  _storage.getImage(context).then((file) {
                    setState(() {
                      image = File(file.path);
                      print(file.path);
                    });
                  });
                }),
            TextButton(
                onPressed: () {
                  if (image != null)
                    _storage.uploadFile(image!, context);
                  else
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No Image was selected")));
                },
                child: Text('Upload Image'))
          ],
        ),
      ),
    );
  }
}
