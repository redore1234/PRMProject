import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/plantopic_model.dart';
import 'package:project/models/topic_model.dart';

class PlanTopicService{

  static Future<List<PlanTopicModel>> read({String topicId, String id, String planSubjectId, String bearerToken}) async{
    //get all
    print("from plantopic: ");
    if (topicId == null && id == null && planSubjectId == null) {
      final response = await HttpHelper.get(PLANTOPIC_ENPOINT , bearerToken: bearerToken);
      print(response.body);
      final data = jsonDecode(response.body) as List;
      List<PlanTopicModel> lst = [];
      data.forEach((element) {
        lst.add(new PlanTopicModel.fromJson(element));
      });
      return lst;
    }
    // search by id
    else if (id != null && id!= "") {
      final response = await HttpHelper.get(PLANTOPIC_ENPOINT +"/"+ id, bearerToken: bearerToken);
      final data = PlanTopicModel.fromJson(jsonDecode(response.body));
      return [data];
    } else {
      http://localhost:3955/api/v1/plan-topics?PlanSubjectId=1&TopicId=1
      final response = await HttpHelper.get(PLANTOPIC_ENPOINT + "?PlanSubjectId=" + planSubjectId + "&TopicId=" + topicId, bearerToken: bearerToken);
      final data = jsonDecode(response.body) as List;
      List<PlanTopicModel> lst = [];
      data.forEach((element) {
        lst.add(new PlanTopicModel.fromJson(element));
      });
      return lst;
    }
  }
  static Future<TopicModel> insert(TopicModel topic, String bearerToken) async {
    print(topic.topicId);
    final response = await HttpHelper.post(PLANTOPIC_ENPOINT, topic.toJson(), bearerToken: bearerToken);
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
