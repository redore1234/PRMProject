import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/home/home.dart';
import 'package:project/screen/profile/profile.dart';
import 'package:project/screen/search_subject/search_subject.dart';
import 'package:project/screen/subject/subject.dart';
import 'package:project/screen/subject/subject.dart';
import 'package:project/screen/task/task.dart';
import 'package:project/screen/topic/topic.dart';

final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> forthTabNavKey = GlobalKey<NavigatorState>();

class MainTabBar extends StatefulWidget {

  // const MainTabBar({Key key, @required this.studentID})
  //     : super(key: key);
  _MainTabBarState createState() =>
      _MainTabBarState();
}
class _MainTabBarState extends State<MainTabBar> {
  _MainTabBarState();
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Subject"),
            icon: Icon(Icons.add_task_outlined),
          ),
          BottomNavigationBarItem(
            title: Text("Task"),
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(
            navigatorKey: firstTabNavKey,
              builder: (BuildContext context) => Home(),
            // builder: (BuildContext context) => TopicPage(topicId: 4, subjectId: "PRM391", planSubjectId: 3),
          );
        } else if (index == 1) {
          return CupertinoTabView(
            navigatorKey: secondTabNavKey,
            builder: (BuildContext context) => SubjectPage(),
          );
        } else if (index == 2) {
          return CupertinoTabView(
            navigatorKey: thirdTabNavKey,
            builder: (BuildContext context) => AddTaskSubject(),
          );
        } else {
          return CupertinoTabView(
            navigatorKey: forthTabNavKey,
            builder: (BuildContext context) => ProfilePage(),

          );
        }
      },
    );
  }
}
