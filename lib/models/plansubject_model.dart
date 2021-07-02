class PlanSubjectModel{
  int planSubjectId;
  int priority;
  int progress;
  DateTime createDate;
  bool isComplete;
  int planSemesterId;
  String subjectId;

  PlanSubjectModel(this.planSubjectId, this.priority, this.progress, this.createDate,
      this.isComplete, this.planSemesterId, this.subjectId);

  PlanSubjectModel.fromJson(Map<String, dynamic> json) {
    this.planSubjectId = json['planSubjectId'];
    this.priority = json['priority'];
    this.progress = json['progress'];
    this.createDate = json['createDate'];
    this.isComplete = json['isComplete'];
    this.planSemesterId = json['planSemesterId'];
    this.subjectId = json['subjectId'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['planSubjectId'] = this.planSubjectId;
    data['priority'] = this.priority;
    data['progress'] = this.progress;
    data['createDate'] = this.createDate;
    data['isComplete'] = this.isComplete;
    data['planSemesterId'] = this.planSemesterId;
    data['subjectId'] = this.subjectId;
  }
}