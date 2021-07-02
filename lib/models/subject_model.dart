import 'package:flutter/cupertino.dart';

class SubjectModel {
String id;
String name;
String source;
int subjectGroupId;

  SubjectModel(@required this.id,@required this.name,@required this.source,@required this.subjectGroupId);

  SubjectModel.fromJson(Map<String, dynamic> json) {
    this.id = json['subjectId'];
    this.name = json['subjectName'];
    this.source = json['source'];
    // this.date = json['Date'] == null ? "some date": json['Date'];
    this.subjectGroupId = json['subjectGroupId'];
}
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectId'] = this.id;
    data['subjectName'] = this.name;
    data['source'] = this.source;
    data['subjectGroupId'] = this.subjectGroupId;
    return data;
  }
}