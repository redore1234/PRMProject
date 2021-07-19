import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/task_model.dart';
import 'package:project/models/topic_model.dart';

class TaskService {

  static Future<List<TaskModel>> read(
      {String planTopicId, String id, String JWTToken}) async {
    //get all
    if (planTopicId == null && id == null) {
      final response = await HttpHelper.get(
          TASK_ENPOINT, bearerToken: JWTToken);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        List<TaskModel> lst = [];
        data.forEach((element) {
          lst.add(new TaskModel.fromJson(element));
        });
        return lst;
      } else {
        throw Exception('Failed to load task');
      }
    }
    // search by id
    else if (id != null && id != "") {
      final response = await HttpHelper.get(
          TASK_ENPOINT + "/" + id, bearerToken: JWTToken);
      if (response.statusCode == 200) {
        final data = TaskModel.fromJson(jsonDecode(response.body));
        return [data];
      } else {
        throw Exception('Failed to search by id');
      }
    } else {
      final response = await HttpHelper.get(
          TASK_ENPOINT + "?PlanTopicId=" + planTopicId,
          bearerToken: JWTToken);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        List<TaskModel> lst = [];
        data.forEach((element) {
          lst.add(new TaskModel.fromJson(element));
        });
        return lst;
      } else {
        throw Exception('Failed to search by planTopicId');
      }
    }
  }

  static Future<TaskModel> insert(TaskModel taskModel,
      String JWTToken) async {
    final response = await HttpHelper.post(
        TASK_ENPOINT, taskModel.toJson(), bearerToken: JWTToken);
    print("code" + response.statusCode.toString());
    if (response.statusCode == 201) {
      final data = TaskModel.fromJson(jsonDecode(response.body));
      return data;
    }else{
      throw Exception('Failed to insert task');
    }
  }


  static Future<String> delete(String taskId, String JWTToken) async {
    final response = await HttpHelper.delete(TASK_ENPOINT + "/" + taskId, bearerToken: JWTToken);
    print(response.statusCode);
    print(response.body);
    // if (response.statusCode == 204) {
    //   final data = await jsonDecode(response.body) as String;
    //   return data;
    // } else {
    //   throw Exception('Failed to delete task by taskId');
    // }
  }

  static Future<TaskModel> update(TaskModel taskModel, int taskId, String JWTToken) async {
    final response = await HttpHelper.put(TASK_ENPOINT + "/" + '$taskId',  taskModel.toJson(), bearerToken: JWTToken);
    print(TASK_ENPOINT + "/" + '$taskId');
    print(response.statusCode);
    print(response.body);
    // final data = TaskModel.fromJson(jsonDecode(response.body) );
    final updateSubject = await read(id: '$taskId', JWTToken: JWTToken);
    return updateSubject[0];
  }
}