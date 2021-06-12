import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/global/constant.dart';
import 'package:project/provider/google_signin.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

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
          _detailsCard(user.email, user.displayName),
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
          logoutButton(context)
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
    return Container(
        width: 130,
        child: Text(
          heading,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 14),
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

  Widget logoutButton(context) {
    return InkWell(
      onTap: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.logout();
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
