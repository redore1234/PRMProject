import 'package:flutter/material.dart';
import 'package:project/components/login_background.dart';

class LoginBody extends StatelessWidget {
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
            "assets/images/school_login.png",
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
              onPressed: () {},
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
                    "assets/images/google.png",
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
