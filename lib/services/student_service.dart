import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/student_model.dart';

class StudentService{
  
  static Future<StudentModel> read({String email, String bearerToken}) async{
    final response = await HttpHelper.get(SEARCH_STUDENT_ENPOINT +"/"+ email, bearerToken: bearerToken);
    final data = jsonDecode(response.body) as StudentModel;
    return data;
  }
  static Future<StudentModel> insert(StudentModel student, String bearerToken) async {
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, student.toJson(), bearerToken: bearerToken);
    final data = StudentModel.fromJson(jsonDecode(response.body));
    return data;
  }
}