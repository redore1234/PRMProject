import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/topic_model.dart';

class TopicService {
  static Future<List<TopicModel>> read(
      {String subjectId, String id, String bearerToken}) async {
    //get all
    if (subjectId == null && id == null) {
      final response =
          await HttpHelper.get(TOPIC_ENPOINT, bearerToken: bearerToken);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        List<TopicModel> lst = [];
        data.forEach((element) {
          lst.add(new TopicModel.fromJson(element));
        });
        return lst;
      } else {
        throw Exception('Failed to get all topicModel');
      }
    }
    // search by id
    else if (id != null && id != "") {
      final response = await HttpHelper.get(TOPIC_ENPOINT + "/" + id,
          bearerToken: bearerToken);
      if (response.statusCode == 201) {
        final data = TopicModel.fromJson(jsonDecode(response.body));
        return [data];
      } else {
        throw Exception('Failed to search by topicId');
      }
    } else {
      final response = await HttpHelper.get(
          TOPIC_ENPOINT + "?SubjectId=" + subjectId,
          bearerToken: bearerToken);
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body) as List;
        List<TopicModel> lst = [];
        data.forEach((element) {
          lst.add(new TopicModel.fromJson(element));
        });
        return lst;
      } else {
        throw Exception('Failed to search by subjectID');
      }
    }
  }

  static Future<TopicModel> insert(TopicModel topic, String bearerToken) async {
    print(topic.topicId);
    final response = await HttpHelper.post(TOPIC_ENPOINT, topic.toJson(),
        bearerToken: bearerToken);
    if(response.statusCode == 201){
      final data = TopicModel.fromJson(jsonDecode(response.body));
      print(data.topicId);
      return data;
    }else{
      throw Exception('Failed to insert Topic');
    }
  }

  static Future<String> delete(String id, String bearerToken) async {
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, {"id": id});
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as String;
      return data;
    } else {
      throw Exception('Failed to delete Topic by id');
    }
  }

  static Future<TopicModel> update(TopicModel topicModel, String bearerToken) async {
    final response = await HttpHelper.put(SUBJECT_ENDPOINT, topicModel.toJson());
    final data = TopicModel.fromJson(jsonDecode(response.body));
    final updateSubject = await read(id: '$topicModel.topicId', bearerToken: bearerToken);
    return updateSubject[0];
  }
}
