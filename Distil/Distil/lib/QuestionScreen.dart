import 'package:flutter/material.dart';
import 'package:Distil/QuestionScreen.dart';
import 'package:flutter/material.dart';
import 'Lecture.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Lecture.dart';
import 'LecturesScreen.dart';

Color backGround = const Color.fromRGBO(53, 73, 94, 1.0);
Color appBar = const Color.fromRGBO(238, 133, 114, 1.0);
Color buttons = const Color.fromRGBO(52, 116, 116, 1.0);
Color accentColor = const Color.fromRGBO(99, 183, 175, 1.0);

class QuestionScreen extends StatelessWidget {
  static const routeName = '/QuestionScreen';

  String lectureId;
  QuestionScreen(lectureId) {
    this.lectureId = lectureId;
  }

   @override
  Widget build(BuildContext context) {
    print("not live");
    return Scaffold(
      Text("NOTLIVE"));
  }
}