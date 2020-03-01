import 'package:Distil/QuestionScreen.dart';
import 'package:Distil/QuestionScreenLive.dart';
import 'package:flutter/material.dart';
import 'Lecture.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Color backGround = const Color.fromRGBO(53, 73, 94, 1.0);
Color appBar = const Color.fromRGBO(238, 133, 114, 1.0);
Color buttons = const Color.fromRGBO(52, 116, 116, 1.0);
Color accentColor = const Color.fromRGBO(99, 183, 175, 1.0);

class LecturesScreen extends StatelessWidget {
  static const routeName = '/LecturesScreen';
  String courseId;
  LecturesScreen(courseId){
    this.courseId = courseId;
  }

Future<List<Lecture>> _getLectures() async {
    var lectures = await http.get("http://distil.space/modules/getLectures?moduleID=$courseId");

    var jsonData = json.decode(lectures.body);

    List<Lecture> lecturesList = [];

    for (var u in jsonData) {
      Lecture lecture = Lecture(
          u["_id"]["\$oid"], u["lectureName"], u["lectureDate"], u["lectureTime"],u["lecturer"],u["isLive"]);
      lecturesList.add(lecture);
    }
    print(lecturesList.length);
    return lecturesList;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: backGround,
        appBar: new AppBar(
            backgroundColor: buttons,
            title: Text(
              "LECTURES",
              style: TextStyle(fontFamily: 'Fira', fontWeight: FontWeight.w900),
            )),
        body: Container(
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Material(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                    bottomLeft: Radius.circular(200)),
                color: Colors.redAccent[100],
                child: Container(
                  width: 400,
                  height: 430,
                ),
              ),
            ),
            FutureBuilder(
              future: _getLectures(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                    child: Text("loading..."),
                  ));
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 325,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                elevation: 10,
                                color: accentColor,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        onTap: () {
                                            print(snapshot.data[index].lectureId);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => snapshot.data[index].isLive == true  ? 
                                                    QuestionScreenLive(snapshot.data[index].lectureId) : QuestionScreen(snapshot.data[index].lectureId),
                                              ),
                                            );
                                          },
                                          title: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot
                                                        .data[index].lectureName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),

                                                  Text(
                                                    snapshot.data[index].lecturer,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[index]
                                                        .lectureDate,
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Text(
                                                          snapshot.data[index]
                                                              .lectureTime,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .white60)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ]),
        ));
  }
}
