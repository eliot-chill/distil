import 'dart:async';
import 'dart:convert';
import 'package:Distil/CourseScreen.dart';
import 'package:Distil/LecturesScreen.dart';
import 'package:Distil/QuestionScreen.dart';
import 'package:Distil/QuestionScreenLive.dart';
import 'package:Distil/UI/InputField.dart';
import 'package:Distil/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Color backGround = const Color.fromRGBO(53, 73, 94, 1.0);
Color appBar = const Color.fromRGBO(238, 133, 114, 1.0);
Color buttons = const Color.fromRGBO(52, 116, 116, 1.0);
Color accentColor = const Color.fromRGBO(99, 183, 175, 1.0);

void main() {
  runApp(MaterialApp(
    title: 'Distil',
    initialRoute: '/select',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Fira'),


    //routes for app navigator to traverse
    routes: {
      '/select': (context) => LoginScreen(),
      //LoginScreen.routeName: (context) => LoginScreen(),
      CourseScreen.routeName: (context) => CourseScreen(),
      LecturesScreen.routeName: (context) => LecturesScreen("id"),
      QuestionScreen.routeName: (context) => QuestionScreen("id"),
      QuestionScreenLive.routeName: (context) => QuestionScreenLive("id")
    },
  ));
}

//52,116,116

class LoginScreen extends StatelessWidget {
  static const routeName = '/StudentLoginScreen';
  final myController = TextEditingController();
  final myPassController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Container(
        color: backGround,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Material(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                    bottomLeft: Radius.circular(200)),
                color: Colors.redAccent[100],
                child: Container(
                  width: 400,
                  height: 590,
                ),
              ),
            ),
            Center(
              child: Container(
              width: 400.0,
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InputField(Icon(Icons.person, color: Colors.white), "Email",
                      false, myController),
                  InputField(Icon(Icons.lock, color: Colors.white), "Password",
                      true, myPassController),
                  Container(
                    width: 150,
                    child: RaisedButton(
                      color: backGround,
                      onPressed: () {
                        signIn(context,myController.text,myPassController.text);
                        myController.clear();
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

Future<bool> signIn(BuildContext context, String email, String password) async {
  var data = json.encode({
  "email" : email,
  "password" : password
  });
    
  var response = await http.post("http://distil.space/users/student/login",body: data,headers: {
        "content-type" : "application/json",
        "accept" : "application/json",});

  if((response.statusCode == 200)){
    Navigator.pushNamed(context, CourseScreen.routeName,arguments: User(email,password));
  }else {
    return false;
  }

}

class isStudent {
  final bool student;
  isStudent(this.student);
}

class isPassword {
  final bool isPass;
  isPassword(this.isPass);
}
