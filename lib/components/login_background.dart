import 'package:flutter/material.dart';
import 'package:project/global/constant.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                Constants.IMAGE_FOLDER_REF + "takenote_login.png",
                width: size.width * 0.3,
              )),
          child,
        ],
      ),
    );
  }
}
