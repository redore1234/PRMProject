import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/plansemester_model.dart';

class PlanSemesterService{
  static Future<List<PlanSemesterModel>> read({String studentId, String semesterId,  String bearerToken}) async{
    final response = await HttpHelper.get(PLANSEMESTER_ENPOINT + "?StudentId=" + studentId, bearerToken: bearerToken);
    print(response.statusCode);
    final data = jsonDecode(response.body) as List;
    print(data);
    List<PlanSemesterModel> lst = [];
    data.forEach((element) {
      lst.add(new PlanSemesterModel.fromJson(element));
    });
    return lst;
  }
  static Future<PlanSemesterModel> insert(PlanSemesterModel planSemesterModel, String bearerToken) async {
    print(planSemesterModel.planSemesterId);
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, planSemesterModel.toJson(), bearerToken: bearerToken);
    print('post');
    final data = PlanSemesterModel.fromJson(jsonDecode(response.body));
    print(data.studentId);
    return data;
  }
}