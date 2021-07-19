import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/models/plansubject_model.dart';
import 'package:project/models/plantopic_model.dart';
import 'package:project/models/task_model.dart';
import 'package:project/models/topic_model.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/plan_semester_service.dart';
import 'package:project/services/plan_subject_service.dart';
import 'package:project/services/plan_topic_service.dart';
import 'package:project/services/task_service.dart';
import 'package:project/services/topic_service.dard.dart';

class AddTaskSubject extends StatefulWidget {
  final String subjectId;
  final int topicId, plansubjectId;
  final String topicName;
  final int planTopicId;

  const AddTaskSubject(
      {Key key,
      @required this.subjectId,
      @required this.topicId,
      @required this.plansubjectId,
      @required this.planTopicId,
      @required this.topicName})
      : super(key: key);

  _AddTaskSubjectPageState createState() => _AddTaskSubjectPageState(
      this.subjectId,
      this.topicId,
      this.plansubjectId,
      this.planTopicId,
      this.topicName);
}

class _AddTaskSubjectPageState extends State<AddTaskSubject> {
  _AddTaskSubjectPageState(this.subjectId, this.topicId, this.plansubjectId,
      this.planTopicId, this.topicName);

  final int plansubjectId;
  var descriptionController = TextEditingController();

  final estimatedTimeController = TextEditingController();
  String estimateTime, description;
  final String subjectId;
  final String topicName;
  int planTopicId;
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
  String priority, category;
  bool status = false;
  DateTime dueDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  List<String> listSubjectId = ["Choose Subject"];

  List<String> listTopicName = ["Choose topic"];

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
  void addPlanTopic() async {
PlanTopicModel planTopicModel = new PlanTopicModel(0, false, topicId, planSubjectId);
   PlanTopicModel planTopic = await PlanTopicService.insert(planTopicModel, AuthService.jwtToken);
   planTopicId = planTopic.planTopicId;
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
    estimatedTimeController.text = "";
    descriptionController.text = "";
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
                    child: TextFormField(
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
               child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: 40),
                  color: Colors.orangeAccent,
                  onPressed: () async{
                    getData();
                    int estimateTime = int.parse(estimatedTimeController.text);
                    if(planTopicId == 0){
                      addPlanTopic();
                    }
                print(planTopicId);
                    TaskModel taskModel = new TaskModel(descriptionController.text.toString(), firstDate.toString(), estimateTime, 0,
                        dueDate.toString(), listPriority.indexOf(priority), false, planTopicId, listTaskCategory.indexOf(category)  +1);
                    print("Task: " + taskModel.toJson().toString());
                   await TaskService.insert(taskModel, AuthService.jwtToken);
                   showAlertDialog(context, "ADD TASK", "Successfully");
                  },
                  child: Text(
                    'ADD TASK',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //   width: size.width * 0.8,
              //   alignment: Alignment.center,
              // child: FlatButton(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0)),
              //   padding:
              //       EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              //   color: Colors.orangeAccent,
              //   onPressed: () {
              //     getData();
              //     if(planTopicId == 0){
              //       PlanTopicModel planTopicModel = new PlanTopicModel( 0, false, topicId, planSubjectId);
              //       PlanTopicService.insert(planTopicModel, AuthService.jwtToken);
              //
              //
              //     }else{
              //
              //   }
              //     TaskModel task = new TaskModel(descriptionController.text, "firstDate", 4, 7, "2021-07-17T19:50:25.621Z", 2147483647, true, 4, 4);
              //     TaskService.insert(task, AuthService.jwtToken);
              //     showAlertDialog(context, "Add Task", "Successfully" );
              //   },
              //   child: Text(
              //     'ADD TASK',
              //     style: TextStyle(
              //         color: Colors.white, fontWeight: FontWeight.bold),
              //   ),
              // ),),
            ],
          ),
        ),
      ),
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

showAlertDialog(BuildContext context, String title, String content) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
