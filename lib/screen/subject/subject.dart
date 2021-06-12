import 'package:flutter/material.dart';
import 'package:project/screen/add_subject/add_subject.dart';
import 'package:project/screen/update_subject/update_subject.dart';

import '../../global/dropdown.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Summer 2021"),
        centerTitle: true,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                DropDown(
                  arrayList: [
                    "Semester 1",
                    "Semester 2",
                    "Semester 3",
                    "Semester 4",
                    "Semester 5",
                    "Semester 7",
                    "Semester 8",
                    "Semester 9"
                  ],
                  valueSelected: "Semester 1",
                ),
                SizedBox(
                  width: 120,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSubjectPage()));
                  },
                  icon: Icon(Icons.add_circle_outline_outlined),
                  iconSize: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateSubjectPage()));
                  },
                  icon: Icon(Icons.change_circle_outlined),
                  iconSize: 25,
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: subjectCourse(
                    "PRM391", "Mobile Programming", "10/5/2021", "2")),
            SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: subjectCourse(
                    "PRM391", "Mobile Programming", "10/5/2021", "2")),
            SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: subjectCourse(
                    "PRM391", "Mobile Programming", "10/5/2021", "2")),
            SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: subjectCourse(
                    "PRM391", "Mobile Programming", "10/5/2021", "2")),
          ],
        ),
      ),
    ));
  }
}

Widget subjectCourse(String subjectCode, String subjectName, String dateAdded,
    String taskOngoing) {
  return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFF5F6F9),
      onPressed: () {},
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Text(subjectCode,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(
                subjectName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Date added: " + dateAdded,
              ),
              Text(
                "Ongoing tasked: " + taskOngoing,
              ),
            ],
          )),
          Icon(Icons.arrow_forward_ios),
        ],
      ));
}
