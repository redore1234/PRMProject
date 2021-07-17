import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/models/plansubject_model.dart';
import 'package:project/models/topic_model.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/plan_semester_service.dart';
import 'package:project/services/plan_subject_service.dart';
import 'package:project/services/topic_service.dard.dart';

class AddTaskSubject extends StatefulWidget {
  final String subjectId;
  final int topicId, plansubjectId;
  final String topicName;
  const AddTaskSubject({Key key, @required this.subjectId, @required this.topicId, @required this.plansubjectId, @required this.topicName})
      : super(key: key);

  _AddTaskSubjectPageState createState() => _AddTaskSubjectPageState(this.subjectId,this.topicId, this.plansubjectId, this.topicName);
}

class _AddTaskSubjectPageState extends State<AddTaskSubject> {
  _AddTaskSubjectPageState(this.subjectId, this.topicId, this.plansubjectId, this.topicName);
  final int plansubjectId;
  var descriptionController = TextEditingController();

  final estimatedTimeController = TextEditingController();
  String estimateTime, description;
  final String subjectId;
 final String topicName;
  List<PlanSubjectModel> listPlanSubject;
  List<TopicModel> listTopic;
  final int topicId;
  final List<String> listPriority = ["Not Urgent", "Urgent"];
  final List<String> listStatus = ["Ongoing", "Finished"];
  final List<String> listTaskCategory = [
    "Assignment",
    "Quiz",
    "Project",
    "Self-Study"
  ];
  String priority , category;
  bool status = false;
  DateTime dueDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  List<String> listSubjectId =   ["Choose Subject"];

  List<String> listTopicName =  ["Choose topic"];


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dueDate,
        firstDate: firstDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != dueDate) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  int planSemesterId = 2;


  void getData() {
    print(descriptionController.text);
    print(category);
    print(priority);
    print(dueDate);
    print(estimatedTimeController.text);


  }
  @override
  void initState() {
    // planSemesterId =  fetchPlanSemester();
    priority = listPriority[0];
    category = listTaskCategory[0];
    estimatedTimeController.text= "";
    descriptionController.text= "";
    super.initState();
  }

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      Text(subjectId),

                      // FutureBuilder(
                      //   future: PlanSubjectService.read(
                      //       planSemesterId: planSemesterId,
                      //       JWTToken: AuthService.jwtToken),
                      //   builder: (BuildContext context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       print("has data1111");
                      //       listPlanSubject =
                      //           snapshot.data as List<PlanSubjectModel>;
                      //
                      //       listPlanSubject.forEach((element) {
                      //         listSubjectId.add(element.subjectId);
                      //       });
                      //       return Row(
                      //         children: [
                      //           // DropdownButton<String>(
                      //           //   value: listPlanSubject
                      //           //       .map((e) => e.subjectId)
                      //           //       .first,
                      //           //   icon: Icon(Icons.arrow_drop_down),
                      //           //   iconSize: 24,
                      //           //   elevation: 16,
                      //           //   style:
                      //           //   TextStyle(
                      //           //       color: Colors.red, fontSize: 18),
                      //           //   underline: Container(
                      //           //     height: 2,
                      //           //     color: Colors.deepPurpleAccent,
                      //           //   ),
                      //           //   onChanged: (String value) {
                      //           //     changePlanSubject(value);
                      //           //   },
                      //           //   items: listPlanSubject
                      //           //       .map<String>((e) => e.subjectId)
                      //           //       .toList()
                      //           //       .map<DropdownMenuItem<String>>(
                      //           //           (String value) {
                      //           //         return DropdownMenuItem<String>(
                      //           //           value: value,
                      //           //           child: Text(
                      //           //              value),
                      //           //         );
                      //           //       }).toList(),
                      //           // ),
                      //           // DropdownButton<String>(
                      //           //   value: subjectId,
                      //           //   icon: Icon(Icons.arrow_drop_down),
                      //           //   iconSize: 24,
                      //           //   elevation: 16,
                      //           //   style: TextStyle(
                      //           //       color: Colors.red, fontSize: 18),
                      //           //   underline: Container(
                      //           //     height: 2,
                      //           //     color: Colors.red,
                      //           //   ),
                      //           //   onChanged: (value) {
                      //           //     setState(() {
                      //           //       subjectId = value;
                      //           //     });
                      //           //   },
                      //           //   items: listSubjectId
                      //           //       .map<DropdownMenuItem<String>>((value) {
                      //           //     return DropdownMenuItem<String>(
                      //           //       value: value,
                      //           //       child: Text(value),
                      //           //     );
                      //           //   }).toList(),
                      //           // ),
                      //         ],
                      //       );
                      //     } else {
                      //       return Center();
                      //     }
                      //   },
                      // ),
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
                      Text(topicName),
                      // FutureBuilder(
                      //   future: TopicService.read(
                      //       subjectId: subjectId,
                      //       JWTToken: AuthService.jwtToken),
                      //   builder: (BuildContext context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       listTopic = snapshot.data as List<TopicModel>;
                      //       // listTopicName =  ["Choose topic"];
                      //       listTopic.forEach((element) {
                      //         listTopicName.add(element.topicName);
                      //       });
                      //       print("hasijdfl;sajdf");
                      //       print(topicName);
                      //
                      //       return Row(
                      //         children: [
                      //           // DropdownButton<String>(
                      //           //   value: listTopic
                      //           //       .map((e) => e.topicName)
                      //           //       .first.toString(),
                      //           //   icon: Icon(Icons.arrow_drop_down),
                      //           //   iconSize: 24,
                      //           //   elevation: 16,
                      //           //   style:
                      //           //   TextStyle(color: Colors.red, fontSize: 18),
                      //           //   underline: Container(
                      //           //     height: 2,
                      //           //     color: Colors.deepPurpleAccent,
                      //           //   ),
                      //           //   onChanged: (String value)  {
                      //           //     changePlanSubject(value);
                      //           //   },
                      //           //   items: listTopic
                      //           //       .map<String>((e) => e.topicName)
                      //           //       .toList()
                      //           //       .map<DropdownMenuItem<String>>(
                      //           //           (String value) {
                      //           //         return DropdownMenuItem<String>(
                      //           //           value: value,
                      //           //           child: Text(value == null ? "" : value),
                      //           //         );
                      //           //       }).toList(),
                      //           // ),
                      //           DropdownButton<String>(
                      //             value: topicName,
                      //             icon: Icon(Icons.arrow_drop_down),
                      //             iconSize: 24,
                      //             elevation: 16,
                      //             style: TextStyle(
                      //                 color: Colors.red, fontSize: 18),
                      //             underline: Container(
                      //               height: 2,
                      //               color: Colors.red,
                      //             ),
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 topicName = value;
                      //               });
                      //             },
                      //             items: listTopicName
                      //                 .map<DropdownMenuItem<String>>((value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Text(value),
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ],
                      //       );
                      //     } else {
                      //       return Center();
                      //     }
                      //   },
                      // ),
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
                      DropdownButton<String>(
                        value: category,
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
                            category = value;
                            // changeList();
                          });
                        },
                        items: listTaskCategory
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                      _labelTitle('Priority'),
                      SizedBox(
                        width: 125,
                      ),
                      DropdownButton<String>(
                        value: priority,
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
                            priority = value;
                            // changeList();
                          });
                        },
                        items: listPriority
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                              text: '${dueDate.toLocal()}'.split(' ')[0]),
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
                        child:  TextFormField(
                          keyboardType: TextInputType.number,
                          controller: estimatedTimeController,
                          decoration: InputDecoration(),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Hours',
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
                          controller: descriptionController,
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
                        onPressed: () {
                          getData();
                        },
                        child: Text(
                          'ADD TASK',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
