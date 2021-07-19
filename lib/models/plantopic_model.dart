class PlanTopicModel {
  int planTopicId;
  int progress;
  bool isComplete;
  int topicId;
  int planSubjectId;

  PlanTopicModel( this.progress, this.isComplete, this.topicId,
      this.planSubjectId);

  PlanTopicModel.fromJson(Map<String, dynamic> json) {
    this.planTopicId = json['planTopicId'];
    this.progress = json['progress'];
    this.isComplete = json['isComplete'];
    this.topicId = json['topicId'];
    this.planSubjectId = json['planSubjectId'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['progress'] = this.progress;
    data['isComplete'] = this.isComplete;
    data['topicId'] = this.topicId;
    data['planSubjectId'] = this.planSubjectId;
  }
}
