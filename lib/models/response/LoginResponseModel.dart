class LoginResponseModel{
  String message;
  bool isSuccess;
  String errors;
  DateTime expireDate;

  LoginResponseModel(this.message, this.isSuccess, this.errors, this.expireDate);

  LoginResponseModel.fromJson(Map<String, dynamic> json){
    this.message = json['message'];
    this.isSuccess = json['isSuccess'];
    this.errors = json['errors'];
    this.expireDate = json['expireDate'];
  }
}