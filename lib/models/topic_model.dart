class Topic{
  int topicId;
  String topicName;
  String topicDescription;
  String subjectId;

  Topic(this.topicId, this.topicName, this.topicDescription, this.subjectId);

  Topic.fromJson(Map<String, dynamic> json){
    this.topicId = json['topicId'];
    this.topicName = json['topicName'];
    this.topicDescription = json['topicDescription'];
    this.subjectId = json['subjectId'];

  }
  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicId'] = this.topicId;
    data['topicName'] = this.topicName;
    data['topicDescription'] = this.topicDescription;
    data['subjectId'] = this.subjectId;

  }
}