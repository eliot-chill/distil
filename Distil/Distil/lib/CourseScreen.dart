import 'dart:convert';
import 'package:Distil/LecturesScreen.dart';
import 'package:Distil/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Course.dart';
import 'dart:async';
import 'package:Distil/LecturesScreen.dart';
import 'package:Distil/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:flutter/foundation.dart';

Color backGround = const Color.fromRGBO(53, 73, 94, 1.0);
Color appBar = const Color.fromRGBO(238, 133, 114, 1.0);
Color buttons = const Color.fromRGBO(52, 116, 116, 1.0);
Color accentColor = const Color.fromRGBO(99, 183, 175, 1.0);


class CourseScreen extends StatelessWidget {
  static const routeName = '/CourseScreen';

  Future<List<Course>> _getCourses() async {
    var courses = await http.get("http://distil.space/modules/getModules");

    var jsonData = json.decode(courses.body);

    List<Course> coursesList = [];

    for (var u in jsonData) {
      print(u['courseId']);
      Course course = Course(
          u["_id"]["\$oid"], u["courseName"], u["lecturerName"], u["startDate"]);

      coursesList.add(course);
    }

    return coursesList;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: backGround,
        appBar: new AppBar(
            backgroundColor: buttons,
            title: Text(
              "COURSES",
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
              future: _getCourses(),
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
                                            print(snapshot.data[0].courseId);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => 
                                                    LecturesScreen(snapshot.data[index].courseId),
                                              ),
                                            );
                                          },
                                          title: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot
                                                        .data[index].courseName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
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
                                                        .lecturerName,
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
                                                              .startDate,
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
