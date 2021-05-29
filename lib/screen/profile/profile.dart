import 'package:flutter/material.dart';
import 'package:project/global/constant.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          //avatar image
          _profilePic(),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 20,
          ),
          _heading("Personal Details"),
          SizedBox(
            height: 10,
          ),
          _detailsCard("longpt@fpt.edu.vn", "Long"),
          SizedBox(
            height: 20,
          ),
          _heading("Settings"),
          SizedBox(
            height: 10,
          ),
          _settingCard(),
          SizedBox(
            height: 30,
          ),
          logoutButton()
        ],
      )),
    );
  }

  Widget _profilePic() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image:
                        AssetImage(Constants.IMAGE_FOLDER_REF + "user.png"))),
          ),
        ),
      ],
    );
  }

  Widget _heading(String heading) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        child: Text(
          heading,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  Widget _detailsCard(String email, String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each details
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                email,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text(name, style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each details
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings", style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.dashboard_customize),
              title: Text("About us", style: TextStyle(fontSize: 20)),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {
        print("Hello");
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout),
              SizedBox(
                width: 10,
              ),
              Text(
                "Logout",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
