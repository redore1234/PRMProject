import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/models/task_model.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/task_service.dart';

class TaskDetailPage extends StatefulWidget {
  final int taskId;
  final int planTopicId;

  const TaskDetailPage({Key key, this.taskId, this.planTopicId})
      : super(key: key);

  _TaskDetailPagePageState createState() =>
      _TaskDetailPagePageState(this.taskId, this.planTopicId);
}

class _TaskDetailPagePageState extends State<TaskDetailPage> {
  final int taskId;
   int planTopicId;
  int index = 0;
  var descriptionController = TextEditingController();

  final estimatedTimeController = TextEditingController();
  final effortTimeController = TextEditingController();
  final List<String> listPriority = ["Not Urgent", "Urgent"];
  final List<String> listStatus = ["Ongoing", "Finished"];
  final List<String> listTaskCategory = [
    "Assignment",
    "Quiz",
    "Project",
    "Self-Study"
  ];
  String priority, category, statusString;
  bool status;
  DateTime dueDate;

  void initState() {

    super.initState();

    // Start listening to changes.
    // descriptionController.addListener(_printLatestValue);
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    descriptionController.dispose();
    estimatedTimeController.dispose();
    effortTimeController.dispose();
    super.dispose();
  }

  void getData() {
    print("taskId: " + '$taskId');
    print(descriptionController.text);
    print(category);
    print(priority);
    print(dueDate);
    print(effortTimeController.text);
    print(estimatedTimeController.text);


  }

  _TaskDetailPagePageState(this.taskId, this.planTopicId);

  DateTime selectedDate = DateTime.now();
  String description;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dueDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != dueDate) {
      setState(() {
        dueDate = picked;
      });
    }
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
          "task detail".toUpperCase(),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: TaskService.read(id: '$taskId', JWTToken: AuthService.jwtToken),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("has data task id: ");
            dueDate = DateTime.parse(snapshot.data[0].dueDate);
            priority = listPriority[snapshot.data[0].priority];
            category = listTaskCategory[snapshot.data[0].taskCategoryId - 1];
            status = snapshot.data[0].isComplete;
            statusString = (status == true) ? "Finished" : "Ongoing";
            descriptionController.value = descriptionController.value.copyWith(text: snapshot.data[0].taskDescription);
            estimatedTimeController.value = estimatedTimeController.value
                .copyWith(text: '${snapshot.data[0].estimateTime}');
            effortTimeController.value = effortTimeController.value
                .copyWith(text: '${snapshot.data[0].effortTime}');
            planTopicId = snapshot.data[0].planTopicId;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          width: 70,
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
                        // DropDown(
                        //     arrayList: ['Urgent', 'Not Urgent'],
                        //     valueSelected: priority)
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
                          'hours',
                          style: TextStyle(fontSize: 20),
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
                        _labelTitle('Effort Time'),
                        SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: effortTimeController,
                            decoration: InputDecoration(),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'hours',
                          style: TextStyle(fontSize: 20),
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
                        _labelTitle('Status'),
                        SizedBox(
                          width: 125,
                        ),
                        // DropDown(
                        //     arrayList: ['Ongoing', 'Finished'],
                        //     valueSelected: status)
                        DropdownButton<String>(
                          value: statusString,
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
                              statusString = value;
                              status = (statusString == "Finished");
                              // changeList();
                            });
                          },
                          items: ["Ongoing", "Finished"]
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
                    Container(
                      width: size.width * 0.8,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            color: Colors.orangeAccent,
                            onPressed: () async {
                              getData();
                              int estimateTime = int.parse(estimatedTimeController.text);
                              int effortTime = int.parse(effortTimeController.text);
                              print("des: " + descriptionController.text);
                              TaskModel taskModel = new TaskModel(descriptionController.text.toString(), selectedDate.toString(), estimateTime, effortTime,
                                  dueDate.toString(), listPriority.indexOf(priority), false, planTopicId, listTaskCategory.indexOf(category)  +1);
                              print(planTopicId);
                              TaskModel.fromTaskModel(taskModel);
                              print("Task: " + taskModel.toJson().toString());
                              print("Task: " + taskModel.toJson().toString());
                              await TaskService.update(taskModel, taskId, AuthService.jwtToken);
                              showAlertDialog(context, "Update Task", "Sucessfully");
                            },
                            child: Text(
                              'UPDATE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            color: Colors.orangeAccent,
                            onPressed: () async{
                              await TaskService.delete('$taskId', AuthService.jwtToken);
                              showAlertDialog(context, "Delete Task", "Sucessfully");

                            },
                            child: Text(
                              'DELETE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            print("hello");
            return Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Loading...',
              ),
            );
          }
        },
      ),
    ));
  }

  Widget _labelTitle(String title) {
    return Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
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
