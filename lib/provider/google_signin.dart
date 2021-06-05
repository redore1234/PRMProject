import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => this._isSigningIn;

  set isSigningIn(value) {
    this._isSigningIn = value;
    notifyListeners();
  }

  Future login() async {
    _isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      _isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      _isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
