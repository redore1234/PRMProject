import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/subject_model.dart';

class SubjectService {
  static Future<List<SubjectModel>> read({String searchValue, String id}) async {
    //get all
    if (searchValue == null && id == null) {
      final response = await HttpHelper.get(SUBJECT_ENDPOINT);
      final data = jsonDecode(response.body) as List;
      List<SubjectModel> lst = [];
      data.forEach((element) {
        lst.add(new SubjectModel.fromJson(element));
      });
      return lst;
    }
    // search by id
    else if (id != null && id!= "") {
        final response = await HttpHelper.get(SUBJECT_ENDPOINT +"/"+ id);
        final data = SubjectModel.fromJson(jsonDecode(response.body));
        return [data];
    } else {
      final response = await HttpHelper.get(SUBJECT_ENDPOINT + "?SubjectName=" + searchValue);
      final data = jsonDecode(response.body) as List;
      List<SubjectModel> lst = [];
      data.forEach((element) {
        lst.add(new SubjectModel.fromJson(element));
      });
      return lst;
    }

  }

  static Future<SubjectModel> insert(SubjectModel model) async {
    print(model.id);
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, model.toJson());
    print('post');
    final data = SubjectModel.fromJson(jsonDecode(response.body));
    print(data.id);
    return data;
  }

  static Future<String> delete(String id) async {
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, {"id": id});
    final data = jsonDecode(response.body) as String;
    return data;
  }

  static Future<SubjectModel> update(SubjectModel model) async {
    print(model.id);
    // final response = await HttpHelper.put(SUBJECT_ENDPOINT, model.toJson());
    // print(response.body);
    // print(response.headers);
    // final data = SubjectModel.fromJson(jsonDecode(response.body));
    final data = await read(id: model.id);
    return data[0];
  }
}

