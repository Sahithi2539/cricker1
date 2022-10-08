import 'package:cricker/criminalsheets/criminalsheets.dart';
import 'package:cricker/loginpage/register.dart';
import 'package:cricker/loginpage/resetpassword.dart';
import 'package:cricker/loginpage/user/phonelogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class old extends StatefulWidget {
  const old({Key? key}) : super(key: key);

  @override
  _oldState createState() => _oldState();
}

class _oldState extends State<old> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => buttons(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 25, top: 130),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'E-Mail'),
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {
                              //Validator
                            },
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a valid email!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {},
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a valid password!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          email = emailController.text;
                                          password = passwordController.text;
                                        });
                                        userLogin();
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => buttons()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => register()),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff4c505b), fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => reset()),
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                              ElevatedButton(
                                onPressed: () => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            MyPhone(),
                                        transitionDuration:
                                            Duration(seconds: 0),
                                      ),
                                      (route) => false)
                                },
                                child: Text('Login with Phone'),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
