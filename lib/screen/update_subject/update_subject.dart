import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/services/subject_service.dart';
import 'package:project/widget/base_ontap_widget.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class UpdateSubjectPage extends StatefulWidget {
  final String id;

  const UpdateSubjectPage({Key key, @required this.id}) : super(key: key);

  _UpdateSubjectPageState createState() => _UpdateSubjectPageState(this.id);
}

class _UpdateSubjectPageState extends State<UpdateSubjectPage> {
  DateTime selectedDate = DateTime.now();
  final String id;
  var subjectIdController = TextEditingController();
  var subjectNameController = TextEditingController();
  var subjectSourceController = TextEditingController();
  var subjectGroupIdController = TextEditingController();

  _UpdateSubjectPageState(this.id);

  void dispose() {
    // Clean up the controller when the widget is disposed.
    subjectIdController.dispose();
    subjectNameController.dispose();
    subjectSourceController.dispose();
    subjectGroupIdController.dispose();
    super.dispose();
  }

  SubjectModel subject;

  Future<void> load() async {
    SubjectService.read(id: id).then((value) {
      subject = value[0];
      subjectIdController.value =
          subjectIdController.value.copyWith(text: subject.id);
      subjectNameController.value =
          subjectIdController.value.copyWith(text: subject.name);
      subjectSourceController.value =
          subjectIdController.value.copyWith(text: subject.source);
      subjectGroupIdController.value =
          subjectIdController.value.copyWith(text: "${subject.subjectGroupId}");
    });
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext content) {
    Size size = MediaQuery.of(context).size;
    // subjectIdController.text = id;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "subject detail".toUpperCase(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _formFieldContainer(
                  "SubjectID: ",
                  child: TextFormField(controller: subjectIdController),
                ),
                _formFieldContainer(
                  "SubjectName: ",
                  child: TextFormField(controller: subjectNameController),
                ),
                _formFieldContainer(
                  "Source: ",
                  child: TextFormField(
                    controller: subjectSourceController,
                  ),
                ),
                _formFieldContainer(
                  "SubjectGroupID: ",
                  child: TextFormField(
                    decoration: InputDecoration(),
                    // initialValue:
                    // "${snapshot.data[0].subjectGroupId}",
                    controller: subjectGroupIdController,
                  ),
                ),
                BaseOnTapWidget(
                  onTap: () {
                    final String id = subjectIdController.text;
                    final String name = subjectNameController.text;
                    final String source = subjectSourceController.text;
                    final int subjectGroupId =
                        int.parse(subjectGroupIdController.text);
                    if (_formKey.currentState.validate()) {
                      SubjectModel subjectModel =
                          new SubjectModel(id, name, source, subjectGroupId);
                      SubjectService.update(subjectModel);
                    }
                  },
                  child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formFieldContainer(String title, {Widget child}) {
    return Container(
        width: MediaQuery.of(context).size.width,
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

  Widget _labelTitle(String title) {
    return Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }
}
