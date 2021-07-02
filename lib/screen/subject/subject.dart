import 'package:flutter/material.dart';
import 'package:project/models/major_model.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/screen/add_subject/add_subject.dart';
import 'package:project/screen/search_subject/search_subject.dart';
import 'package:project/screen/update_subject/update_subject.dart';
import 'package:project/services/major_service.dart';
import 'package:project/services/subject_service.dart';

import '../../global/dropdown.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
 final Future<List<MajorModel>> items = MajorService.read();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        title: Text("Summer 2021"),
        centerTitle: true,
        shadowColor: Colors.white,
      ),
      body: Container(
          child: FutureBuilder(
            future: MajorService.read(),
            builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                print("hasdata major");
                final data = snapshot.data as List<MajorModel>;
                List<String> lstName = new List<String>();
                for( var i = 0 ; i < data.length ; i++ ) {
                  lstName.add(data[i].name);
                }
                return Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),

                          DropDown(

                            arrayList: lstName,
                            valueSelected: lstName.first,


                            // valueSelected: "Semester 1",
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
                                      builder: (context) =>
                                          SearchSubjectPage(searchValue: "")));
                            },
                            icon: Icon(Icons.change_circle_outlined),
                            iconSize: 25,
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: FutureBuilder(
                          future: SubjectService.read(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                      ),
                    ],
                  ),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Loading.....',
                  ),
                );
              }
            },
          )
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
