import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricker/addcriminals/display.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

class details extends StatefulWidget {
  details({Key? key}) : super(key: key);

  Future uploadFile() async {}
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  XFile? image;
  late String imgUrl;

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerCriminalid = TextEditingController();
  final controllerAddress = TextEditingController();
  final contRollerPincode = TextEditingController();
  //final controllerCategory = DropdownButton();
  final controllerShift = TextEditingController();
  String imageurl = "";

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
            CircleAvatar(
              radius: 50,
            ),
            const SizedBox(
              height: 24,
            ),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.image),
                label: Text('Add Image')),
            const SizedBox(
              height: 24,
            ),
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
                controller: controllerAddress,
                decoration: decoration('Address'),
                keyboardType: TextInputType.text),
            const SizedBox(height: 24),
            TextField(
                controller: contRollerPincode,
                decoration: decoration('Pincode'),
                keyboardType: TextInputType.number),
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
                  pincode: int.parse(contRollerPincode.text),
                  address: controllerAddress.text,
                  category: value,
                  shift: shift,
                  imageurl: '',
                  //birthday: DateTime.parse(controllerDate.text),
                );
                createUser(user);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => details()),
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
  final int pincode;
  final String category;
  final String shift;
  final String imageurl;
  // final DateTime birthday;

  User({
    this.id = '',
    required this.criminalid,
    required this.name,
    required this.age,
    required this.pincode,
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
        'pincode': pincode,
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
        pincode: json['pincode'],
        address: json['address'],
        category: json['category'],
        shift: json['shift'],
        imageurl: json['imageurl'],
      );
}
