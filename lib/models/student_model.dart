class StudentModel{
  String studentId;
  String studentName;
  String StudentEmail;
  String majorId;

  StudentModel(this.studentId, this.studentName, this.StudentEmail, this.majorId);

  StudentModel.fromJson(Map<String, dynamic> json){
    this.studentId = json['studentId'];
    this.studentName = json['studentName'];
    this.StudentEmail = json['StudentEmail'];
    this.majorId = json['majorId'];

  }
  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['StudentEmail'] = this.StudentEmail;
    data['majorId'] = this.majorId;

  }
}