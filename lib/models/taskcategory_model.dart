class TaskCategoryModel{
  int taskCategoryId;
  String taskType;

  TaskCategoryModel(this.taskCategoryId, this.taskType);

  TaskCategoryModel.fromJson(Map<String, dynamic> json){
    this.taskCategoryId = json['taskCategoryId'];
    this.taskType = json['taskType'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskCategoryId'] = this.taskCategoryId;
    data['taskType'] = this.taskType;

  }
}