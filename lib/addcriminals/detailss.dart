import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'upload/storage.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'upload/progress.dart';

class detailss extends StatefulWidget {
  detailss({Key? key}) : super(key: key);
  @override
  _detailssState createState() => _detailssState();
}

class _detailssState extends State<detailss> {
  File? image;
  String? imgUrl;
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

    image = File(file.path);
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
    var url1 = await ref.getDownloadURL();
    print(url1);
    return url1;
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController img = TextEditingController();
  TextEditingController address = TextEditingController();

  sendData() async {
    await FirebaseFirestore.instance.collection('criminals').add({
      'name': name.text,
      'img': image,
      'address': address.text,
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('ADD RECORD'),
        ),
        body: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(25),
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
                        getImage(context).then((file) {
                          setState(() {
                            image = File(file.path);
                          });
                        });
                      }),
                  TextButton(
                      onPressed: () {
                        if (image != null)
                          uploadFile(image!, context);
                        else
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("No Image was selected")));
                      },
                      child: Text('Upload Image')),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "Enter name",
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(25),
                  //   child: TextFormField(
                  //     controller: img,
                  //     decoration: InputDecoration(
                  //       labelText: "img",
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                        labelText: "Enter address",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      child: Text('create'),
                      onPressed: () {
                        sendData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailss(),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
