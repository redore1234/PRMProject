import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/semester_model.dart';

class SemesterService {
  static Future<List<SemesterModel>> read(
      {String id, String bearerToken}) async {
    final response =
        await HttpHelper.get(SEMESTER_ENPOINT, bearerToken: bearerToken);
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      List<SemesterModel> lst = [];
      data.forEach((element) {
        lst.add(new SemesterModel.fromJson(element));
      });
      return lst;
    } else {
      throw Exception('Failed to get all Semester');
    }
  }
}
