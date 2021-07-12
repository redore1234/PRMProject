import 'account_models.dart';

class LoginModel {
  String provider;
  String idToken;
  String message;

// this.date = json['Date'] == null ? "some date": json['Date'];
  LoginModel({this.provider,  this.idToken});
  LoginModel.fromJson(Map<String, dynamic> json){
    this.message = json['message'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['idToken'] = this.idToken;
    return data;

  }


}