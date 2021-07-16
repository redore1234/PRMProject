import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/subject_model.dart';

class SubjectService {
  static Future<List<SubjectModel>> read(
      {String searchValue, String subjectId, String JWTToken}) async {
    //get all
    if (searchValue == null && subjectId == null) {
      final response =
          await HttpHelper.get(SUBJECT_ENDPOINT, bearerToken: JWTToken);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        List<SubjectModel> lst = [];
        data.forEach((element) {
          lst.add(new SubjectModel.fromJson(element));
        });
        return lst;
      } else {
        throw Exception('Failed to get all subject');
      }
    }
    // search by id
    else if (subjectId != null && subjectId != "") {
      final response = await HttpHelper.get(SUBJECT_ENDPOINT + "/" + subjectId,
          bearerToken: JWTToken);
      if (response.statusCode == 200) {
        final data = SubjectModel.fromJson(jsonDecode(response.body));
        return [data];
      } else {
        throw Exception('Failed to search by id ');
      }
    } else {
      final response = await HttpHelper.get(
          SUBJECT_ENDPOINT + "?SubjectName=" + searchValue,
          bearerToken: JWTToken);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        List<SubjectModel> lst = [];
        data.forEach((element) {
          lst.add(new SubjectModel.fromJson(element));
        });
        return lst;
      } else {
        throw Exception('Failed to search by subujectName ');
      }
    }
  }

  static Future<SubjectModel> insert(
      SubjectModel model, String bearerToken) async {
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, model.toJson(),
        bearerToken: bearerToken);
    if (response.statusCode == 201) {
      final data = SubjectModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Failed to insert subject');
    }
  }

  static Future<String> delete(String id, String JWTToken) async {
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, {"id": id});
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as String;
      return data;
    } else {
      throw Exception('Failed to delete subject by id');
    }
  }

  static Future<SubjectModel> update(SubjectModel model, String JWTToken) async {
    print(model.id);
    final response = await HttpHelper.put(SUBJECT_ENDPOINT, model.toJson());
    print(response.body);
    print(response.headers);
    final data = SubjectModel.fromJson(jsonDecode(response.body));
    final updateSubject = await read(subjectId: model.id, JWTToken: JWTToken);
    return updateSubject[0];
  }
}
