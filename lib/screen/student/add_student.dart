import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/models/major_model.dart';
import 'package:project/models/student_model.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/screen/plansemester/plan_semester.dart';
import 'package:project/screen/subject/subject.dart';
import 'package:project/services/student_service.dart';
import 'package:project/services/subject_service.dart';
import 'package:project/widget/base_ontap_widget.dart';

class AddStudentPage extends StatefulWidget {
  final String id;
  final String bearerToken;

  const AddStudentPage({Key key, @required this.id, @required this.bearerToken})
      : super(key: key);

  _AddStudentPageState createState() =>
      _AddStudentPageState(this.id, this.bearerToken);
}

class _AddStudentPageState extends State<AddStudentPage> {
  final String id;
  final String bearerTokent;
  MajorModel majorModel;

  _AddStudentPageState(this.id, this.bearerTokent);

  final _formKey = GlobalKey<FormState>();
  final studentIdController = TextEditingController();
  final studentNameController = TextEditingController();
  final studentEmailController = TextEditingController();
  final majorIdController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    studentIdController.dispose();
    studentNameController.dispose();
    studentEmailController.dispose();
    majorIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "add student ".toUpperCase(),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 700,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Column(
                    children: [
                      _formFieldContainer(
                        "studentID: ",
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter text';
                            }
                            return null;
                          },
                          controller: studentIdController,
                        ),
                      ),
                      _formFieldContainer(
                        "studentName: ",
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter text';
                            }
                            return null;
                          },
                          controller: studentNameController,
                        ),
                      ),
                      _formFieldContainer(
                        "Email: ",
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter text';
                            }
                            return null;
                          },
                          controller: studentEmailController,
                        ),
                      ),
                      _formFieldContainer(
                        "MajorID: " + id,
                        child: Container(),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 2,),
                          Expanded(child:   Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: BaseOnTapWidget(
                              onTap: () {
                                final String id = studentIdController.text;
                                final String name = studentNameController.text;
                                final String email = studentEmailController.text;
                                final String majorID = "BIT_SE";

                                if (_formKey.currentState.validate()) {
                                  StudentModel studentModel =
                                  new StudentModel(id, name, email, majorID);
                                  StudentService.insert(studentModel, bearerTokent);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: Text(
                                  'Add Subject',
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(color: Colors.green),
                              ),
                            ),
                          ),flex: 1,),
                        SizedBox(width: 4,),
                        Expanded(child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: BaseOnTapWidget(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PlanSemesterPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: Text(
                                'Plan Semester',
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(color: Colors.orange),
                            ),
                          ),
                        ),flex: 1,),
                          SizedBox(width: 2,),


                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _formFieldContainer(String title, {Widget child}) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          child
        ],
      ));
}
