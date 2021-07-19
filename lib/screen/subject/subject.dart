import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/global/variable.dart';
import 'package:project/models/plansemester_model.dart';
import 'package:project/models/plansubject_model.dart';
import 'package:project/models/semester_model.dart';
import 'package:project/screen/update_subject/subject_detail.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/plan_semester_service.dart';
import 'package:project/services/plan_subject_service.dart';
import 'package:project/services/semester_service.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<SemesterModel> listSemester = [];
  String currentNameSemester = "Summer_2021";
  List<PlanSubjectModel> listPlanSubject = [];
  int planSemesterId = 0;

  void changenameSemester(String value) {
    setState(() {
      currentNameSemester = value;
    });
  }

  Future<int> fetchPlanSemester() async {
    print(AuthService.userId);
    print(AuthService.jwtToken);

    try {
      var semesters = (await PlanSemesterService.read(
          studentId: AuthService.userId, JWTToken: AuthService.jwtToken))
          .where((element) =>
      element.semesterId ==
          listSemester
              .firstWhere((e) => e.semesterName == currentNameSemester)
              .semesterId)
          .toList();

      print(semesters.length);
      return semesters.length == 0 ? null : semesters.first.planSemesterId;
    } catch (Exception) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Container(
            width: size.width,
            child: FutureBuilder(
              future: SemesterService.read(bearerToken: AuthService.jwtToken),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  listSemester = snapshot.data as List<SemesterModel>;
                  print("1" + currentNameSemester);
                  print("has data");
                  return Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                value: listSemester
                                    .map((e) => e.semesterName)
                                    .first,
                                // value: currentNameSemester,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                TextStyle(color: Colors.red, fontSize: 18),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String value) async {
                                  planSemesterId = await fetchPlanSemester();
                                  changenameSemester(value);
                                },
                                items: listSemester
                                    .map<String>((e) => e.semesterName)
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_circle_outline_outlined),
                                iconSize: 25,
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              color: Colors.grey,
                              child: Container(
                                child: FutureBuilder(
                                  future: PlanSubjectService.read(
                                      planSemesterId: planSemesterId,
                                      JWTToken: AuthService.jwtToken),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      print("hello");
                                      return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: subjectCourse(
                                              context,
                                              snapshot.data[index].subjectId,
                                              snapshot.data[index].createDate,
                                              '${snapshot.data[index].progress}',
                                              snapshot
                                                  .data[index].planSubjectId,
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
                              )),
                          flex: 12,
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Loading.....',
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget subjectCourse(
    BuildContext context,
    String subjectCode,
    String subjectName,
    String taskOngoing,
    int planSubjectId) {
  return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFF5F6F9),
      onPressed: () {
        // Navigate to Update

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectDetailPage(
                id: subjectCode,
                planSubjectId: planSubjectId
                ),
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
                  "Ongoing tasked: " + taskOngoing,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ));
}
