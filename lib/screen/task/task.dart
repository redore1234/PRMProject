import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/models/plansubject_model.dart';
import 'package:project/models/topic_model.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/plan_semester_service.dart';
import 'package:project/services/plan_subject_service.dart';
import 'package:project/services/topic_service.dard.dart';

class AddTaskSubject extends StatefulWidget {
  _AddTaskSubjectPageState createState() => _AddTaskSubjectPageState();
}

class _AddTaskSubjectPageState extends State<AddTaskSubject> {

  DateTime selectedDate = DateTime.now();
  String estimateTime, description, subjectId, topicName;
  List<PlanSubjectModel> listPlanSubject;
  List<TopicModel> listTopic;
  int topicId;
  List<String> listSubjectId = new List<String>();
  List<String> listTopicName = new List<String>();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  int planSemesterId = 2;

  Future<int> fetchPlanSemester() async {
    try {
      var semesters = (await PlanSemesterService.read(
          studentId: AuthService.userId,
          isComplete: false,
          JWTToken: AuthService.jwtToken)).toList();

      return semesters.length == 0 ? null : semesters.first.planSemesterId;
    } catch (Exception) {
      return null;
    }
  }

  @override
  void initState() {
    // planSemesterId =  fetchPlanSemester();
    super.initState();
  }

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

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
            title: Text(
              "add task".toUpperCase(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Subject'),
                          SizedBox(
                            width: 125,
                          ),
                          FutureBuilder(
                            future: PlanSubjectService.read(
                                planSemesterId: planSemesterId,
                                JWTToken: AuthService.jwtToken),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                print("has data1111");
                                listPlanSubject = snapshot.data as List<
                                    PlanSubjectModel>;
                                print(listPlanSubject[0].subjectId);
                                subjectId = listPlanSubject[0].subjectId;
                                print("subjectId: " + subjectId);
                                listPlanSubject.forEach((element) {
                                  listSubjectId.add(element.subjectId);
                                });
                                return Row(
                                  children: [
                                    // DropdownButton<String>(
                                    //   value: listPlanSubject
                                    //       .map((e) => e.subjectId)
                                    //       .first,
                                    //   icon: Icon(Icons.arrow_drop_down),
                                    //   iconSize: 24,
                                    //   elevation: 16,
                                    //   style:
                                    //   TextStyle(
                                    //       color: Colors.red, fontSize: 18),
                                    //   underline: Container(
                                    //     height: 2,
                                    //     color: Colors.deepPurpleAccent,
                                    //   ),
                                    //   onChanged: (String value) {
                                    //     changePlanSubject(value);
                                    //   },
                                    //   items: listPlanSubject
                                    //       .map<String>((e) => e.subjectId)
                                    //       .toList()
                                    //       .map<DropdownMenuItem<String>>(
                                    //           (String value) {
                                    //         return DropdownMenuItem<String>(
                                    //           value: value,
                                    //           child: Text(
                                    //              value),
                                    //         );
                                    //       }).toList(),
                                    // ),
                                    DropdownButton<String>(
                                      value: subjectId,
                                      icon: const Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          subjectId = newValue;
                                        });
                                      },
                                      items: listSubjectId
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),),
                                  ],
                                );
                              } else {
                                return Center(

                                );
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Topic'),
                          SizedBox(
                            width: 143,
                          ),
                          FutureBuilder(
                            future: TopicService.read(
                                subjectId: subjectId,
                                JWTToken: AuthService.jwtToken),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                listTopic = snapshot.data as List<TopicModel>;
                                topicId = listTopic[0].topicId;
                                topicName = listTopic[0].topicName;
                                listTopic.forEach((element) {
                                  listTopicName.add(element.topicName);
                                }
                                );
                                print("hasijdfl;sajdf");
                                print(topicName);

                                return Row(
                                  children: [
                                    // DropdownButton<String>(
                                    //   value: listTopic
                                    //       .map((e) => e.topicName)
                                    //       .first.toString(),
                                    //   icon: Icon(Icons.arrow_drop_down),
                                    //   iconSize: 24,
                                    //   elevation: 16,
                                    //   style:
                                    //   TextStyle(color: Colors.red, fontSize: 18),
                                    //   underline: Container(
                                    //     height: 2,
                                    //     color: Colors.deepPurpleAccent,
                                    //   ),
                                    //   onChanged: (String value)  {
                                    //     changePlanSubject(value);
                                    //   },
                                    //   items: listTopic
                                    //       .map<String>((e) => e.topicName)
                                    //       .toList()
                                    //       .map<DropdownMenuItem<String>>(
                                    //           (String value) {
                                    //         return DropdownMenuItem<String>(
                                    //           value: value,
                                    //           child: Text(value == null ? "" : value),
                                    //         );
                                    //       }).toList(),
                                    // ),
                                    DropdownButton<String>(
                                      value: topicName,
                                      icon: const Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          topicName = newValue;
                                        });
                                      },
                                      items: listTopicName.map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),),

                                  ],
                                );
                              } else {
                                return Center(

                                );
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Category'),
                          SizedBox(
                            width: 110,
                          ),
                          DropDown(
                              arrayList: ['PRM391', 'SWD392'],
                              valueSelected: 'PRM391')
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Priority'),
                          SizedBox(
                            width: 125,
                          ),
                          DropDown(
                              arrayList: ['PRM391', 'SWD392'],
                              valueSelected: 'PRM391')
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Due Date'),
                          SizedBox(
                            width: 110,
                          ),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              focusNode: AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(
                                  text: '${selectedDate.toLocal()}'.split(
                                      ' ')[0]),
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Estimated Time'),
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              // validator: (String value) {
                              //   if (value.isEmpty) {
                              //     return "Field is not empty";
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(),
                              onChanged: (text) {
                                estimateTime = text;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'times',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Description'),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: SizedBox(
                            width: 350,
                            child: TextFormField(
                              onChanged: (text) {
                                //description = text;
                              },
                              maxLines: 5,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: size.width * 0.8,
                          alignment: Alignment.center,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            color: Colors.orangeAccent,
                            onPressed: () {},
                            child: Text(
                              'ADD TASK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ))),
        ));
  }

  Widget _labelTitle(String title) {
    return Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }

  int planSubjectId;

  void changePlanSubject(String value) {
    setState(() {
      listPlanSubject.forEach((element) {
        if (element.subjectId == value) {
          planSubjectId = element.planSubjectId;
        }
      });
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
