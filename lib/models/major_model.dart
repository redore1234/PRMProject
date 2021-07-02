class MajorModel{
  String id;
  String name;

  MajorModel(this.id, this.name);

  MajorModel.fromJson(Map<String, dynamic> json){
    this.id = json['majorId'];
    this.name = json['majorName'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['majorId'] = this.id;
    data['majorName'] = this.name;

  }
}