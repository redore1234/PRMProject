import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/global/constant.dart';
import 'package:project/global/variable.dart';
import 'package:project/models/login_models.dart';
import 'package:project/models/major_model.dart';
import 'package:project/models/plansemester_model.dart';
import 'package:project/models/plansubject_model.dart';
import 'package:project/models/semester_model.dart';
import 'package:project/models/student_model.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/provider/google_signin.dart';
import 'package:project/screen/add_subject/add_subject.dart';
import 'package:project/screen/search_subject/search_subject.dart';
import 'package:project/screen/student/add_student.dart';
import 'package:project/screen/update_subject/subject_detail.dart';
import 'package:project/services/login_service.dart';
import 'package:project/services/major_service.dart';
import 'package:project/services/plan_semester_service.dart';
import 'package:project/services/plan_subject_service.dart';
import 'package:project/services/semester_service.dart';
import 'package:project/services/student_service.dart';
import 'package:project/services/subject_service.dart';

import '../../global/dropdown.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final user = FirebaseAuth.instance.currentUser;
  String dropdownValue = 'Summer 2021';
  int index = 0;
  String semesterId = "SUM_21";
  String studentId = "SE140129";
  String bearerToken;

  int planSemesterId;
  List<PlanSubjectModel> list = new List<PlanSubjectModel>();

  void changeList(){
    setState(() {
      // API theo StudentId, SemesterId, lấy ra PlanSemester,
      FutureBuilder(
        future: PlanSemesterService.read(studentId: studentId, bearerToken: bearerToken),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            final data = snapshot.data as List<PlanSemesterModel>;
            planSemesterId = 0;
            for (var i = 0; i < data.length; i++) {
              if(data[i].semesterId == semesterId){
                planSemesterId = data[i].planSemesterId;
              }
            }

          }
          return Container(
          );
        }
      );

    });
  }




   // final String bearerToken = LoginService.bearerToken;

  @override
  Widget build(BuildContext context) {
    // FutureBuilder (
    //     future: StudentService.read(email: user.email, bearerToken: Authentication.token),
    //     builder: (BuildContext context, snapshot) {
    //       if(snapshot.data){
    //         final data = snapshot.data as StudentModel;
    //         studentId = data.studentId;
    //       }
    //       return Container();
    //     }
    // );

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.red, fontSize: 18),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          index = lstName.indexOf(value);


                                          dropdownValue = value ;
                                          semesterId = data.elementAt(index).semesterId;
                                          // changeList();
                                          print(planSemesterId);
                                        });
                                      },
                                      items: lstName.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),

                                    IconButton(
                                      onPressed: () {

                                      },
                                      icon:
                                      Icon(Icons.add_circle_outline_outlined),
                                      iconSize: 25,
                                    ),

                                  ],
                                ),
                                flex: 1,
                              ),

                              Expanded(
                                child: Container(
                                  color: Colors.grey,

                                    child:  FutureBuilder(
                                        future: PlanSemesterService.read(studentId: studentId, bearerToken: bearerToken),
                                        builder: (BuildContext context, snapshot){
                                          if(snapshot.hasData){
                                            final data = snapshot.data as List<PlanSemesterModel>;
                                            planSemesterId = 0;
                                            for (var i = 0; i < data.length; i++) {
                                              if(data[i].semesterId == semesterId){
                                                planSemesterId = data[i].planSemesterId;
                                                print(planSemesterId);
                                              }
                                            }

                                          }
                                          return Container(
                                            child: FutureBuilder(
                                              future: PlanSubjectService.read(planSemesterId: planSemesterId, bearerToken: bearerToken),
                                              builder: (BuildContext context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print("has data plansubject");
                                                  return ListView.builder(
                                                    itemCount: snapshot.data.length,
                                                    itemBuilder: (context, index) {
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                        child: subjectCourse(
                                                          context,
                                                          snapshot.data[index].subjectId,
                                                          snapshot.data[index].createDate,
                                                          '${snapshot.data[index].progress}',
                                                          snapshot.data[index].planSubjectId,
                                                          bearerToken,
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
                                        }
                                    ),



                                ),
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
                  ));
            },
          ),
          //
        ),
      ),
    );
  }
}



Widget subjectCourse(BuildContext context, String subjectCode,
    String subjectName, String taskOngoing, int planSubjectId, String bearerToken) {
  return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFF5F6F9),
      onPressed: () {
        // Navigate to Update

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectDetailPage(id: subjectCode,  planSubjectId: planSubjectId, bearerToken: bearerToken),
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
