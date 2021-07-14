import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/student_model.dart';

class StudentService{
  
  static Future<StudentModel> read({String email, String bearerToken}) async{
    final response = await HttpHelper.get(SEARCH_STUDENT_ENPOINT +"/"+ email, bearerToken: bearerToken);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as StudentModel;
      return data;
    }else{
      throw Exception('Failed to get Student by email');
    }
  }

}