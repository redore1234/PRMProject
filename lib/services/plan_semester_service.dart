import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/plansemester_model.dart';

class PlanSemesterService{
  static PlanSemesterModel planSemesterModel;
  static Future<List<PlanSemesterModel>> read({String studentId, String semesterId, bool isComplete,  String JWTToken}) async{

    final response = await HttpHelper.get(PLANSEMESTER_ENPOINT + "?StudentId=" + studentId, bearerToken: JWTToken);
    final data = jsonDecode(response.body) as List;
    List<PlanSemesterModel> lst = [];
    if(isComplete == null){
      data.forEach((element) {
        lst.add(new PlanSemesterModel.fromJson(element));
      });

    }else{
      data.forEach((element) {
        planSemesterModel = new PlanSemesterModel.fromJson(element);
        if(planSemesterModel.isComplete == isComplete)
        lst.add(planSemesterModel);
      });

    }

    return lst;
  }
  static Future<PlanSemesterModel> insert(PlanSemesterModel planSemesterModel, String bearerToken) async {
    print(planSemesterModel.planSemesterId);
    final response = await HttpHelper.post(PLANSEMESTER_ENPOINT, planSemesterModel.toJson(), bearerToken: bearerToken);
    final data = PlanSemesterModel.fromJson(jsonDecode(response.body));
    return data;
  }
}