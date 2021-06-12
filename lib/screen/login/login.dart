import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/login/login_body.dart';
import 'package:project/global/main-tab-bar.dart';
import 'package:project/provider/google_signin.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);

          if (provider.isSigningIn) {
            return buildLoading();
          } else if (snapshot.hasData) {
            return MainTabBar();
          } else {
            return LoginBody();
          }
        },
      ),
    )));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
