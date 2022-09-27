import 'package:cricker/addcriminals/details.dart';
import 'package:cricker/loginpage/login.dart';
import 'package:flutter/material.dart';
import '../attendence/SecondScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../addcriminals/detailss.dart';

class buttons extends StatelessWidget {
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
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //kdsheets button
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(155, 163, 235, 1), // background
                onPrimary: Colors.black, // foreground
              ),
              child: Text(
                'KD Sheets',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            // dc sheets
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(155, 163, 235, 1), // background
                onPrimary: Colors.black, // foreground
              ),
              child: Text(
                'DC Sheets',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            //suspect sheets
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(155, 163, 235, 1), // background
                onPrimary: Colors.black, // foreground
              ),
              child: Text(
                'Suspect Sheets',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            //rowdy sheets
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(155, 163, 235, 1), // background
                onPrimary: Colors.black, // foreground
              ),
              child: Text(
                'Rowdy Sheets',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          //REGISTER CRIMINAL
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(155, 163, 235, 1), // background
                onPrimary: Colors.black, // foreground
              ),
              child: Text(
                'ADD CRIMINAL',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => detailss()),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      )),
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
    );
  }
}
