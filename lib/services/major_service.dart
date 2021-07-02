
import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/major_model.dart';
import 'package:project/models/subject_model.dart';

class MajorService{
  static Future<List<MajorModel>> read({String id}) async{
    final response = await HttpHelper.get(MAJOR_ENDPOINT);
    final data = jsonDecode(response.body) as List;
      List<MajorModel> lst = [];
      data.forEach((element) {
        lst.add(new MajorModel.fromJson(element));
      });
      return lst;
  }
}