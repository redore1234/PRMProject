import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/services/task_service.dart';

class TaskDetailPage extends StatefulWidget {
  final int taskId;
  final String bearerToken;

  const TaskDetailPage({Key key, this.taskId, @required this.bearerToken})
      : super(key: key);

  _TaskDetailPagePageState createState() =>
      _TaskDetailPagePageState(this.taskId, this.bearerToken);
}

class _TaskDetailPagePageState extends State<TaskDetailPage> {
  final int taskId;
  final String bearerToken;
  final descriptionController = TextEditingController();
  final List<String> list = ["Not Urgent", "Urgent"];
  String priority;
  final dueDateController = TextEditingController();
  DateTime dueDate;



  void dispose() {
    // Clean up the controller when the widget is disposed.
    descriptionController.dispose();
    super.dispose();
  }

  _TaskDetailPagePageState(this.taskId, this.bearerToken);

  DateTime selectedDate = DateTime.now();
  String estimateTime, description;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dueDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dueDate) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
        future: TaskService.read(id: '$taskId', bearerToken: bearerToken),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("has data task id: ");
            dueDate = DateTime.parse(snapshot.data[0].dueDate);
            priority = list[snapshot.data[0].priority];
            descriptionController.text = snapshot.data[0].taskDescription;
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
                            onChanged: (text) {
                              //description = text;

                            },
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
                            arrayList: ['Urgent', 'Not Urgent'],
                            valueSelected: priority)
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
                                text:
                                    '${dueDate.toLocal()}'.split(' ')[0]),
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
                          'UPDATE',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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
