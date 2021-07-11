import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/student_model.dart';

class StudentService{
  
  static Future<StudentModel> read({String email, String bearerToken}) async{
    final response = await HttpHelper.get(SEARCH_STUDENT_ENPOINT +"/"+ email, bearerToken: bearerToken);
    print(response.statusCode);
    final data = jsonDecode(response.body) as StudentModel;
    print(data.studentId);

    return data;
  }
  static Future<StudentModel> insert(StudentModel student, String bearerToken) async {
    print(student.studentId);
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, student.toJson(), bearerToken: bearerToken);
    print('post student');
    final data = StudentModel.fromJson(jsonDecode(response.body));
    print(data.studentId);
    return data;
  }
}