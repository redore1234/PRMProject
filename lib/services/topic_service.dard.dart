import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/topic_model.dart';

class TopicService{

  static Future<List<TopicModel>> read({String subjectId, String id, String bearerToken}) async{
    //get all
    print("From subjectservice");
    if (subjectId == null && id == null) {
      final response = await HttpHelper.get(TOPIC_ENPOINT , bearerToken: bearerToken);
      print(response.body);
      final data = jsonDecode(response.body) as List;
      List<TopicModel> lst = [];
      data.forEach((element) {
        lst.add(new TopicModel.fromJson(element));
      });
      return lst;
    }
    // search by id
    else if (id != null && id!= "") {
      final response = await HttpHelper.get(TOPIC_ENPOINT +"/"+ id, bearerToken: bearerToken);
      final data = TopicModel.fromJson(jsonDecode(response.body));
      return [data];
    } else {
      final response = await HttpHelper.get(TOPIC_ENPOINT + "?SubjectId=" + subjectId, bearerToken: bearerToken);
      final data = jsonDecode(response.body) as List;
      List<TopicModel> lst = [];
      data.forEach((element) {
        lst.add(new TopicModel.fromJson(element));
      });
      return lst;
    }
  }
  static Future<TopicModel> insert(TopicModel topic, String bearerToken) async {
    print(topic.topicId);
    final response = await HttpHelper.post(TOPIC_ENPOINT, topic.toJson(), bearerToken: bearerToken);
    print('post student');
    final data = TopicModel.fromJson(jsonDecode(response.body));
    print(data.topicId);
    return data;
  }
  static Future <TopicModel> getTopicById({String subjectId, String id, String bearerToken}) async{
    final response = await HttpHelper.get(TOPIC_ENPOINT +"/"+ id, bearerToken: bearerToken);
    final data = TopicModel.fromJson(jsonDecode(response.body));
    return data;
  }
}
