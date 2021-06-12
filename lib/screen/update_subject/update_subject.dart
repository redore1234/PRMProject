import 'package:flutter/material.dart';

class UpdateSubjectPage extends StatefulWidget {
  _UpdateSubjectPageState createState() => _UpdateSubjectPageState();
}

class _UpdateSubjectPageState extends State<UpdateSubjectPage> {
  @override
  Widget build(BuildContext content) {
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
                "UPDATE TASK DETAIL",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView()));
  }
}
