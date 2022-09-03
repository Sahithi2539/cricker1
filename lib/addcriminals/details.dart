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

class details extends StatefulWidget {
  details({Key? key}) : super(key: key);

  // PlatformFile? pickedFile;
  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;

  //   setState() {
  //     pickedFile = result.files.first;
  //   }
  // }

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

            // DateTimeField(
            //   controller: controllerDate,
            //   decoration: decoration('Birthday'),
            //   format: DateFormat('yyyy-MM-dd'),
            //   onShowPicker: (context, currentValue) =>{
            //   return showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate)

            // },
            // const SizedBox(height:32),
            // if(pickedFile!=null)
            // Expanded(child: Container(
            //   color: Colors.blue,
            //   child: Image.file,(
            //     File(pickedFile.path!),
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // ),
            // ElevatedButton(
            //   child: const Text('Select File'),
            //   onPressed: selectFile,
            // ),
            // const SizedBox(height: 32),
            // ElevatedButton(
            //   child: const Text('Upload File'),
            //   onPressed: uploadFile,
            // ),
            // const SizedBox(height: 32),
            //pic upload
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

  // Stream<List<User>> readUsers() => FirebaseFirestore.instance
  //     .collection('criminals')
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('criminals').doc();
    user.id = docUser.id;

    // final user = User(
    //   id: docUser.id,
    //   name: name,
    //   age: 21,
    //   birthday: DateTime(2001, 7, 28),
    // );
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
      );
}
