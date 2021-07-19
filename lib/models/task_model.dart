class TaskModel{
  int taskId;
  String taskDescription;
  String createDate;
  int estimateTime;
  int effortTime;
  String dueDate;
  int priority;
  bool isComplete;
  int planTopicId;
  int taskCategoryId;

  TaskModel(this.taskDescription, this.createDate, this.estimateTime, this.effortTime, this.dueDate, this.priority, this.isComplete
      ,this.planTopicId, this.taskCategoryId);




  TaskModel.fromTaskModel(TaskModel taskModel){
    this.taskDescription = taskModel.taskDescription;
    this.estimateTime = taskModel.estimateTime;
    this.effortTime = taskModel.effortTime;
    this.dueDate = taskModel.dueDate;
    this.priority = taskModel.priority;
    this.isComplete = isComplete;
  }

  TaskModel.fromJson(Map<String, dynamic> json){
    this.taskId = json['taskId'];
    this.taskDescription = json['taskDescription'];
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
    data['taskDescription'] = this.taskDescription;
    data['createDate'] = this.createDate;
    data['estimateTime'] = this.estimateTime;
    data['effortTime'] = this.effortTime;
    data['dueDate'] = this.dueDate;
    data['priority'] = this.priority;
    data['isComplete'] = this.isComplete;
    data['planTopicId'] = this.planTopicId;
    data['taskCategoryId'] = this.taskCategoryId;
    return data;
  }
}
