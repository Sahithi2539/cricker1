import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricker/addcriminals/display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'display.dart';
import '../criminalsheets/criminalsheets.dart';
import '../attendence/SecondScreen.dart';
import 'image.dart';
import '../attendence/verification.dart';
import '../attendence/camera_page.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../upload/storage.dart';
import 'package:path/path.dart';

class details extends StatefulWidget {
  details({Key? key}) : super(key: key);

  Future uploadFile() async {}
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerCriminalid = TextEditingController();
  final controllerAddress = TextEditingController();
  final contRollerDist = TextEditingController();
  //final controllerCategory = DropdownButton();
  final controllerShift = TextEditingController();
  final controllerImageurl = TextEditingController();

  File? image;

  Storage _storage = new Storage();

  //adding criminal catory list

  final items = ['KD Sheets', 'Rowdy Sheets', 'Suspect Sheets', 'DC Sheets'];
  final shifts = ['Day', 'Night'];
  late String value = 'KD Sheets';
  late String shift = 'Day';
  //final controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Add Crminal'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
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
                      // print(file.path);
                    });
                  });
                }),
            TextButton(
                onPressed: () {
                  if (image != null) {
                    _storage.uploadFile(image!, context);
                  } else
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No Image was selected")));
                },
                child: Text('Upload Image')),
            TextField(
              controller: controllerCriminalid,
              decoration: decoration('Criminal Id'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerName,
              decoration: decoration('Name'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerAge,
              decoration: decoration('Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            TextField(
                controller: contRollerDist,
                decoration: decoration('District'),
                keyboardType: TextInputType.text),
            const SizedBox(height: 24),
            TextField(
                controller: controllerAddress,
                decoration: decoration('Address'),
                keyboardType: TextInputType.text),
            const SizedBox(height: 24),

            //DopDown for Criminal catogary
            DropdownButton<String>(
              value: value,
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) => setState(() => this.value = value!),
            ),

            //dropdown for Shift
            DropdownButton<String>(
              value: shift,
              items: shifts.map(buildMenuItem).toList(),
              onChanged: (shift) => setState(() => this.shift = shift!),
            ),

            ElevatedButton(
              child: Text('Create'),
              onPressed: () {
                final user = User(
                  criminalid: controllerCriminalid.text,
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  district: contRollerDist.text,
                  address: controllerAddress.text,
                  category: value,
                  shift: controllerShift.text,
                  imageurl: controllerImageurl.text,
                  //birthday: DateTime.parse(controllerDate.text),
                );

                createUser(user);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('criminals').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  String id;
  final String name;
  final int age;
  final String criminalid;
  final String address;
  final String district;
  final String category;
  final String shift;
  final String imageurl;
  // final DateTime birthday;

  User({
    this.id = '',
    required this.criminalid,
    required this.name,
    required this.age,
    required this.district,
    required this.address,
    required this.category,
    required this.shift,
    required this.imageurl,
    //required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'criminalid': criminalid,
        'name': name,
        'age': age,
        'district': district,
        'address': address,
        'category': category,
        'shift': shift,
        'imageurl': imageurl,
        // 'birthday': birthday,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        criminalid: json['criminalid'],
        name: json['name'],
        age: json['age'],
        district: json['district'],
        address: json['address'],
        category: json['category'],
        shift: json['shift'],
        imageurl: json['imageurl'],
      );
}
