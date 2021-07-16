class LoginModel {
  String provider;
  String idToken;


  LoginModel(this.provider, this.idToken);

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['idToken'] = this.idToken;
    return data;
  }
}