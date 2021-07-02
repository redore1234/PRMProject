import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/screen/subject/subject.dart';
import 'package:project/services/subject_service.dart';
import 'package:project/widget/base_ontap_widget.dart';

class AddSubjectPage extends StatefulWidget {
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final _formKey = GlobalKey<FormState>();
  final subjectIdController = TextEditingController();
  final subjectNameController = TextEditingController();
  final subjectSourceController = TextEditingController();
  final subjectGroupIdController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    subjectIdController.dispose();
    subjectNameController.dispose();
    subjectSourceController.dispose();
    subjectGroupIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          "add subject ".toUpperCase(),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(

      ),
      // Container(
      //   height: size.height,
      //   width: double.infinity,
      //   child: Form(
      //     key: _formKey,
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           Container(
      //               height: 700,
      //               decoration:
      //                   BoxDecoration(border: Border.all(color: Colors.black)),
      //               margin: const EdgeInsets.only(
      //                 top: 20.0,
      //                 left: 20.0,
      //                 right: 20.0,
      //               ),
      //               child: Column(
      //                 children: [
      //                   _formFieldContainer(
      //                     "ID: ",
      //                     child: TextFormField(
      //                       validator: (value) {
      //                         if (value == null || value.isEmpty) {
      //                           return 'Please enter text';
      //                         }
      //                         return null;
      //                       },
      //                       controller: subjectIdController,
      //                     ),
      //                   ),
      //                   _formFieldContainer(
      //                     "Name: ",
      //                     child: TextFormField(
      //                       validator: (value) {
      //                         if (value == null || value.isEmpty) {
      //                           return 'Please enter text';
      //                         }
      //                         return null;
      //                       },
      //                       controller: subjectNameController,
      //                     ),
      //                   ),
      //                   _formFieldContainer(
      //                     "Source: ",
      //                     child: TextFormField(
      //                       validator: (value) {
      //                         if (value == null || value.isEmpty) {
      //                           return 'Please enter text';
      //                         }
      //                         return null;
      //                       },
      //                       controller: subjectSourceController,
      //                     ),
      //                   ),
      //                   _formFieldContainer(
      //                     "SubjectGroupID: ",
      //                     child: TextFormField(
      //                       validator: (value) {
      //                         if (value == null || value.isEmpty) {
      //                           return 'Please enter text';
      //                         }
      //                         return null;
      //                       },
      //                       controller: subjectGroupIdController,
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(vertical: 5),
      //                     child: BaseOnTapWidget(
      //                       onTap: () {
      //                         final String id = subjectIdController.text;
      //                         final String name = subjectNameController.text;
      //                         final String source = subjectSourceController.text;
      //                         final int subjectGroupId =
      //                             int.parse(subjectGroupIdController.text);
      //
      //                         if (_formKey.currentState.validate()) {
      //                           SubjectModel subjectModel =
      //                           new SubjectModel(
      //                               id, name, source, subjectGroupId);
      //                           SubjectService.insert(subjectModel);
      //
      //                         }
      //                       },
      //                       child: Container(
      //                         padding: EdgeInsets.symmetric(
      //                             horizontal: 40, vertical: 20),
      //                         child: Text(
      //                           'Add Subject',
      //                           style: TextStyle(color: Colors.white),
      //                         ),
      //                         decoration: BoxDecoration(color: Colors.black),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               )),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
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
