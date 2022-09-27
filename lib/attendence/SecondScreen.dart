import 'package:cricker/addcriminals/details.dart';
import 'package:cricker/addcriminals/display.dart';
import 'package:cricker/attendence/verification.dart';
import 'package:flutter/material.dart';
import '../loginpage/login.dart';
import '../criminalsheets/criminalsheets.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<String> items = <String>[
    'area 1',
    'area 2',
    'area 3',
    'area 4',
    'area 5',
  ];
  String dropdownValue = 'area 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(100, 111, 212, 1),
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => buttons()),
                  );
                }),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(155, 163, 235, 1),
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(155, 163, 235, 1)),
                  accountName: Text(
                    "User",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  accountEmail: Text(
                    "user@gmail.com",
                    style: TextStyle(color: Colors.black),
                  ),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromRGBO(100, 111, 212, 1),
                    child: Text(
                      "A",
                      style: TextStyle(
                          fontSize: 30.0, color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Edit Profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              width: 200,
              height: 50,
              child: DropdownButton<String>(
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                value: dropdownValue,
                items: items.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 163, 235, 1), // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Text(
                  'Attendance',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => display()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 163, 235, 1), // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Text(
                  'Checking',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => display()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 163, 235, 1), // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Text(
                  'Daily Target',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => verification()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ]),
        ));
  }
}
