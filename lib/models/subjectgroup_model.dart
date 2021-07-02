class SubjectGroupModel{
  int subjectGroupId;
  String subjectGroupName;


  SubjectGroupModel(this.subjectGroupId, this.subjectGroupName);

  SubjectGroupModel.fromJson(Map<String, dynamic> json){
    this.subjectGroupId = json['subjectGroupId'];
    this.subjectGroupName = json['subjectGroupName'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectGroupId'] = this.subjectGroupId;
    data['subjectGroupName'] = this.subjectGroupName;

  }
}