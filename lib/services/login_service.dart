import 'dart:convert';

import 'package:project/global/variable.dart';
import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/login_models.dart';

import 'auth_service.dart';

class LoginService{
  static Future<LoginModel> getToken() async {
    final String provider = AuthService.provider;
    final String token = AuthService.idToken;
    LoginModel model = new LoginModel(provider: provider, idToken: token);

    final response = await HttpHelper.post(LOGIN_ENDPOINT, model.toJson());
    if(response.statusCode == 200){
      final data = LoginModel.fromJson(jsonDecode(response.body));
      print("Token from api return: " + data.message);
      bearerToken = data.message;
      return data;
    }else{
      throw Exception('Login Failed');
    }
  }
}