import 'dart:convert';

import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/login_models.dart';
import 'package:project/provider/google_signin.dart';

class LoginService{

  static Future<LoginModel> getToken() async {
    final String provider = Authentication.provider;
    final String token = Authentication.token;
    LoginModel model = new LoginModel(provider: provider, idToken: token);

    final response = await HttpHelper.post(LOGIN_ENDPOINT, model.toJson());
    final data = LoginModel.fromJson(jsonDecode(response.body));
    print("Token: " + data.message);
    return data;
  }

}