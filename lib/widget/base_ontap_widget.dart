import 'package:flutter/cupertino.dart';

class BaseOnTapWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const BaseOnTapWidget({Key key, this.onTap, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }

}