import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/screen/add_subject/add_subject.dart';
import 'package:project/screen/home/home.dart';
import 'package:project/screen/login/login.dart';
import 'package:project/screen/login/login_body.dart';
import 'package:project/screen/search_subject/search_subject.dart';
import 'package:project/screen/subject/subject.dart';
import 'package:project/screen/task/task.dart';
import 'package:project/screen/topic/topic.dart';
import 'package:project/semester/plansemester.dart';
import 'package:project/widget/form_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: LoginScreen(),
      //home: SearchSubjectPage(),
    );
  }
}