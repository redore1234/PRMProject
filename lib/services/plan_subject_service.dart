import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/plansemester_model.dart';
import 'package:project/models/plansubject_model.dart';

class PlanSubjectService{
  static Future<List<PlanSubjectModel>> read({int planSemesterId , String bearerToken}) async{
    print("123123" + bearerToken);

    final response = await HttpHelper.get(PLANSUBJECT_ENPOINT +"/"+ '$planSemesterId' , bearerToken: bearerToken);
    print(response);
    print(response.body);
    final data = jsonDecode(response.body) as List<PlanSubjectModel>;
    print(data);
    // List<PlanSubjectModel> lst = [];
    // data.forEach((element) {
    //   lst.add(new PlanSubjectModel.fromJson(element));
    // });
    return data;
  }
  static Future<PlanSubjectModel> insert(PlanSubjectModel planSemesterModel, String bearerToken) async {
    print(planSemesterModel.planSemesterId);
    final response = await HttpHelper.post(PLANSUBJECT_ENPOINT, planSemesterModel.toJson(), bearerToken: bearerToken);
    print('post');
    final data = PlanSubjectModel.fromJson(jsonDecode(response.body));
    return data;
  }
}