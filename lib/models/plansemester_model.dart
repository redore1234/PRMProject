class PlanSemesterModel{
  int planSemesterId;
  String planSemesterName;
  String studentId;
  String semesterId;
  String  createDate;
  bool isComplete;

  PlanSemesterModel(this.planSemesterId, this.planSemesterName, this.studentId, this.semesterId,
      this.createDate, this.isComplete);

  PlanSemesterModel.fromJson(Map<String, dynamic> json) {
    this.planSemesterId = json['planSemesterId'];
    this.planSemesterName = json['planSemesterName'];
    this.studentId = json['studentId'];
    this.semesterId = json['semesterId'];
    this.createDate = json['createDate'];
    this.isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['planSemesterId'] = this.planSemesterId;
    data['planSemesterName'] = this.planSemesterName;
    data['studentId'] = this.studentId;
    data['semesterId'] = this.semesterId;
    data['createDate'] = this.createDate;
    data['isComplete'] = this.isComplete;
    return data;
  }
}