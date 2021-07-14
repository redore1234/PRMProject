import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/task_model.dart';
import 'package:project/models/topic_model.dart';

class TaskService{

  static Future<List<TaskModel>> read({String planTopicId, String id, String bearerToken}) async{
    //get all
    if (planTopicId == null && id == null) {
      final response = await HttpHelper.get(TASK_ENPOINT , bearerToken: bearerToken);
      print(response.body);
      final data = jsonDecode(response.body) as List;
      print(data);
      List<TaskModel> lst = [];
      data.forEach((element) {
        lst.add(new TaskModel.fromJson(element));
      });
      return lst;
    }
    // search by id
    else if (id != null && id!= "") {
      final response = await HttpHelper.get(TASK_ENPOINT +"/"+ id, bearerToken: bearerToken);
      final data = TaskModel.fromJson(jsonDecode(response.body));
      return [data];
    } else {
      final response = await HttpHelper.get(TASK_ENPOINT + "?PlanTopicId=" + planTopicId, bearerToken: bearerToken);
      final data = jsonDecode(response.body) as List;
      print(data);
      print("data task: ");
      List<TaskModel> lst = [];
      data.forEach((element) {
        print("has");
        lst.add(new TaskModel.fromJson(element));
        print("has1111");
      });

      return lst;
    }
  }
  static Future<TaskModel> insert(TaskModel taskModel, String bearerToken) async {
    final response = await HttpHelper.post(TASK_ENPOINT, taskModel.toJson(), bearerToken: bearerToken);
    print('post student');
    final data = TaskModel.fromJson(jsonDecode(response.body));
    return data;
  }
  static Future<TaskModel> update(TaskModel taskModel) async {
    // final response = await HttpHelper.put(SUBJECT_ENDPOINT, model.toJson());
    // print(response.body);
    // print(response.headers);
    // final data = TaskModel.fromJson(jsonDecode(response.body));
    // final data = await read(id: taskModel.taskId);
    // return data[0];
  }
  
}
