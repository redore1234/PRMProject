import 'package:flutter/material.dart';
import 'package:project/screen/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:project/screen/subject/dropdown_semester.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      //home: DropDown(),
    );
  }
}
