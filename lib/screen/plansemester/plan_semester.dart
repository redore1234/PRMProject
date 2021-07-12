import 'package:flutter/material.dart';
import 'package:project/global/variable.dart';
import 'package:project/models/login_models.dart';
import 'package:project/models/semester_model.dart';
import 'package:project/screen/subject/plan_subject_.dart';
import 'package:project/screen/update_subject/subject_detail.dart';
import 'package:project/services/login_service.dart';
import 'package:project/services/semester_service.dart';

import '../../global/dropdown.dart';

class PlanSemesterPage extends StatefulWidget {
  @override
  _PlanSemesterPageState createState() => _PlanSemesterPageState();
}

class _PlanSemesterPageState extends State<PlanSemesterPage> {
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
            title: Text("PLANSEMESTER"),
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
                      future: SemesterService.read(bearerToken: bearerToken),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data as List<SemesterModel>;
                          List<String> lstName = new List<String>();
                          for (var i = 0; i < data.length; i++) {
                            lstName.add(data[i].semesterName);
                          }
                          return Container(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      DropDown(
                                        arrayList: lstName,
                                        valueSelected: lstName.first,

                                        // valueSelected: "Semester 1",
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlanSubjectPage()));
                                        },
                                        icon:
                                        Icon(Icons.add_circle_outline_outlined),
                                        iconSize: 25,
                                      ),

                                      // IconButton(
                                      //   onPressed: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) => SearchSubjectPage(
                                      //                 searchValue: "")));
                                      //   },
                                      //   icon: Icon(Icons.change_circle_outlined),
                                      //   iconSize: 5,
                                      // ) //
                                    ],
                                  ),
                                  flex: 1,
                                ),

                                Expanded(
                                  child: Container(
                                    color: Colors.green,

                                  ),
                                  flex: 12,
                                )
                                // Expanded(
                                //   // child: FutureBuilder(
                                //   //   future: SubjectService.read(bearerToken: bearerToken),
                                //   //   builder: (BuildContext context, snapshot) {
                                //   //     if (snapshot.hasData) {
                                //   //
                                //   //       return ListView.builder(
                                //   //         itemCount: snapshot.data.length,
                                //   //         itemBuilder: (context, index) {
                                //   //           return Padding(
                                //   //             padding: const EdgeInsets.symmetric(
                                //   //                 vertical: 10),
                                //   //             child: subjectCourse(
                                //   //               context,
                                //   //               snapshot.data[index].id,
                                //   //               snapshot.data[index].name,
                                //   //               snapshot.data[index].source,
                                //   //               '${snapshot.data[index].subjectGroupId}',
                                //   //             ),
                                //   //           );
                                //   //         },
                                //   //       );
                                //   //     } else {
                                //   //       return Center(
                                //   //         child: CircularProgressIndicator(
                                //   //           semanticsLabel: 'Loading...',
                                //   //         ),
                                //   //       );
                                //   //     }
                                //   //   },
                                //   // ),
                                // ),
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
                    ));
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
