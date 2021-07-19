import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/helpers/http_helpers.dart';
import 'package:project/models/login_models.dart';
import 'package:project/models/student_model.dart';
import 'package:project/services/student_service.dart';

class AuthService {
  static GoogleSignIn googleSignIn;
  static String idToken;
  static String provider;
  static String userId;
  static String email;
  static String jwtToken;

  static Future<User> signInWithGoogle(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        email = auth.currentUser.email;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthService.customSnackBar(
              content:
                  'The account already exists with a different credential.',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthService.customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          AuthService.customSnackBar(
            content: 'Error occurred using Google Sign-In. Try again.',
          ),
        );
      }
      // print("Credential token: ${credential.token}");
      // print("Credential provider id: ${credential.providerId}");
      // print("AccessToken: ${googleSignInAuthentication.accessToken}");
      // print("ID Token: ${googleSignInAuthentication.idToken}");
      // print("AccessToken.length: ${googleSignInAuthentication.accessToken.length}");
      // print("IdToken.length: ${googleSignInAuthentication.idToken.length}");
      idToken = "${googleSignInAuthentication.idToken}";
      provider = "${credential.providerId}";
      await getJWTToken();
      await getUserId();
    }
    return user;
  }

  static Future signOut() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  static SnackBar customSnackBar({@required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future getJWTToken() async {
    LoginModel model = new LoginModel(provider: provider, idToken: idToken);

    final response = await HttpHelper.post(LOGIN_ENDPOINT, model.toJson());
    if (response.statusCode == 200) {
      final data = LoginModel.fromJson(jsonDecode(response.body));
      jwtToken = data.message;
      return data;
    } else {
      throw Exception('Login Failed');
    }
  }

  static Future getUserId() async {
    print("email: " + email.toString());
    print("jwtToken: " + jwtToken.toString());
    // StudentModel model =  await StudentService.read(email: email, bearerToken: jwtToken);
    // userId = model.studentId;
    userId = "SE130720";
  }
}
