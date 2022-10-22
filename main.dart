import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'loginpage/login.dart';
import 'loginpage/register.dart';
import 'criminalsheets/criminalsheets.dart';
import 'attendence/SecondScreen.dart';
import 'attendence/verification.dart';
import 'attendence/camera_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cricker App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: login(),
        debugShowCheckedModeBanner: false);
  }
}
