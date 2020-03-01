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
import 'dart:async';


Color backGround = const Color.fromRGBO(53, 73, 94, 1.0);
Color appBar = const Color.fromRGBO(238, 133, 114, 1.0);
Color buttons = const Color.fromRGBO(52, 116, 116, 1.0);
Color accentColor = const Color.fromRGBO(99, 183, 175, 1.0);

class QuestionScreenLive extends StatelessWidget {
  static const routeName = '/QuestionScreenLive';
  String lectureId;
  QuestionScreenLive(lectureId) {
    this.lectureId = lectureId;
  }
final TextEditingController eCtrl = new TextEditingController();
List<String> questions = [];



  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Dynamic Demo"),),
      body: new Column(
        children: <Widget>[
          new TextField(
            controller: eCtrl,
            onSubmitted: (text) {
              questions.add(text);
              eCtrl.clear();
            },
          ),
          new Expanded(
            child: new ListView.builder
              (
                itemCount: litems.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return new Text(litems[Index]);
                }
            )
        )
        ],
      )
    );
  }
}