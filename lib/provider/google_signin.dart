import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static GoogleSignIn googleSignIn;

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
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
      print("Credential token: ${credential.token}");
      print("Credential provider id: ${credential.providerId}");
      print("AccessToken: ${googleSignInAuthentication.accessToken}");
      print("ID Token: ${googleSignInAuthentication.idToken}");
      print("AccessToken.length: ${googleSignInAuthentication.accessToken.length}");
      print("IdToken.length: ${googleSignInAuthentication.idToken.length}");

    }
    return user;
  }

  static Future signOut() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
