import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ProgressBar.dart';

class Storage {
  File? _image;
  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile;
    } else {
      return null;
    }
  }

  Future uploadFile(File file, context) async {
    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No file was selected")));
      return null;
    }

    //show Progress bar

    showDialog(context: context, builder: (context) => ProgressBar());

    firebase_storage.UploadTask uploadTask;
    Random rand = new Random();

    _image = File(file.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('photos')
        .child('/${DateTime.now().toIso8601String()}');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }
    uploadTask.snapshotEvents.listen((event) {
      progress.value =
          (100 * (event.bytesTransferred / event.totalBytes)).round();
      print('${(100 * (event.bytesTransferred / event.totalBytes)).round()}');
    });

    await uploadTask.whenComplete(() {
      Navigator.pop(context);
      print('finished upload');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image uploaded successfully")));
      progress.value = 0;
    });
    return await ref.getDownloadURL();
  }
}
