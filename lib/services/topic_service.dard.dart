import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/topic_model.dart';

class TopicService{

  static Future<List<Topic>> read({String id, String bearerToken}) async{
    final response = await HttpHelper.get(STUDENT_ENDPOINT, bearerToken: bearerToken);
    print(response.statusCode);
    final data = jsonDecode(response.body) as List;
    print(data);
    List<Topic> lst = [];
    data.forEach((element) {
      lst.add(new Topic.fromJson(element));
    });
    return lst;
  }
  static Future<Topic> insert(Topic topic, String bearerToken) async {
    print(topic.topicId);
    final response = await HttpHelper.post(SUBJECT_ENDPOINT, topic.toJson(), bearerToken: bearerToken);
    print('post student');
    final data = Topic.fromJson(jsonDecode(response.body));
    print(data.topicId);
    return data;
  }
}