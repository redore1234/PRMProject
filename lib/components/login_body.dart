import 'package:flutter/material.dart';
import 'package:project/components/login_background.dart';
import 'package:project/global/constant.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/provider/google_signin.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Text(
            "TAKE NOTE",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Image.asset(
            Constants.IMAGE_FOLDER_REF + "school_login.png",
            height: size.height * 0.5,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: size.width * 0.8,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: Colors.orangeAccent,
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.login();
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "LOGIN BY FPT GMAIL",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    Constants.IMAGE_FOLDER_REF + "google.png",
                    height: 20,
                    width: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
