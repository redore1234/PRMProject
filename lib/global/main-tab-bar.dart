import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/home/home.dart';
import 'package:project/screen/profile/profile.dart';

final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

class MainTabBar extends StatefulWidget {
  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(
            navigatorKey: firstTabNavKey,
            builder: (BuildContext context) => Home(),
          );
          // } else if (index == 1) {
          //   return CupertinoTabView(
          //     navigatorKey: secondTabNavKey,
          //     builder: (BuildContext context) => SchedulePage(),
          //   );
        } else {
          return CupertinoTabView(
            navigatorKey: secondTabNavKey,
            builder: (BuildContext context) => ProfilePage(),
          );
        }
      },
    );
  }
}
