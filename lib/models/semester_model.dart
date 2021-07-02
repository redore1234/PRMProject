class SemesterModel{
  String semesterId;
  String semesterName;
  DateTime startDate;
  DateTime endDate;

  SemesterModel(this.semesterId, this.semesterName, this.startDate, this.endDate);

  SemesterModel.fromJson(Map<String, dynamic> json){
    this.semesterId = json['semesterId'];
    this.semesterName = json['semesterName'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['semesterId'] = this.semesterId;
    data['semesterName'] = this.semesterName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;

  }
}