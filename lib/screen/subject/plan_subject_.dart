import 'package:flutter/material.dart';
import 'package:project/global/constant.dart';
import 'package:project/global/variable.dart';
import 'package:project/models/login_models.dart';
import 'package:project/models/major_model.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/provider/google_signin.dart';
import 'package:project/screen/add_subject/add_subject.dart';
import 'package:project/screen/search_subject/search_subject.dart';
import 'package:project/screen/student/add_student.dart';
import 'package:project/screen/update_subject/update_subject.dart';
import 'package:project/services/login_service.dart';
import 'package:project/services/major_service.dart';
import 'package:project/services/subject_service.dart';

import '../../global/dropdown.dart';

class PlanSubjectPage extends StatefulWidget {
  @override
  _PlanSubjectPageState createState() => _PlanSubjectPageState();
}

class _PlanSubjectPageState extends State<PlanSubjectPage> {
  @override
  Widget build(BuildContext context) {
    var bearerToken;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("PLAN SUBJECT"),
            centerTitle: true,
            shadowColor: Colors.white,
          ),
          body: Container(
            child: FutureBuilder(
              future: LoginService.getToken(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as LoginModel;
                  currentUser = data;
                  bearerToken = data.message;
                }
                return Container(
                  width: size.width,
                  child: FutureBuilder(
                    future: SubjectService.read(bearerToken: bearerToken),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        print('hasdata');

                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              child: subjectCourse(
                                context,
                                snapshot.data[index].id,
                                snapshot.data[index].name,
                                snapshot.data[index].source,
                                '${snapshot.data[index].subjectGroupId}',
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            semanticsLabel: 'Loading...',
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
            //
          ),
        ));
  }
}

Widget subjectCourse(BuildContext context, String subjectCode,
    String subjectName, String source, String taskOngoing) {
  return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFF5F6F9),
      onPressed: () {
        // Navigate to Update

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateSubjectPage(id: subjectCode),
          ),
        );
        print("pressed");
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(subjectCode,
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                  subjectName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  source,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Ongoing tasked: " + taskOngoing,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ));
}