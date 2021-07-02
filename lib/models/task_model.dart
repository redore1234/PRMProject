class TaskModel{
  int taskId;
  String taskDecription;
  DateTime createDate;
  double estimateTime;
  double effortTime;
  DateTime dueDate;
  int priority;
  int isComplete;
  int planTopicId;
  int taskCategoryId;

  TaskModel(this.taskId, this.taskDecription, this.createDate, this.estimateTime, this.effortTime, this.dueDate, this.priority, this.isComplete
      ,this.planTopicId, this.taskCategoryId);

  TaskModel.fromJson(Map<String, dynamic> json){
    this.taskId = json['taskId'];
    this.taskDecription = json['taskDecription'];
    this.createDate = json['createDate'];
    this.estimateTime = json['estimateTime'];
    this.effortTime = json['effortTime'];
    this.dueDate = json['dueDate'];
    this.priority = json['priority'];
    this.isComplete = json['isComplete'];
    this.planTopicId = json['planTopicId'];
    this.taskCategoryId = json['taskCategoryId'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['taskDecription'] = this.taskDecription;
    data['createDate'] = this.createDate;
    data['estimateTime'] = this.estimateTime;
    data['effortTime'] = this.effortTime;
    data['dueDate'] = this.dueDate;
    data['priority'] = this.priority;
    data['isComplete'] = this.isComplete;
    data['planTopicId'] = this.planTopicId;
    data['taskCategoryId'] = this.taskCategoryId;
  }
}