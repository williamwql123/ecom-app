import 'package:ecommerce_app/models/User.dart';
import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:ecommerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loggedIn = false;

  void initState() {
    super.initState();
    checkIsLogin().then((isLogin) {
      setState(() {
        loggedIn = isLogin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: (loggedIn) ? [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Profile",
            icon: "assets/icons/User Icon.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Logout",
            icon: "assets/icons/Log out.svg",
            press: () {
              logout();
              final snackBar = SnackBar(
                  content: Text('Logout successful. Hope to see you soon.'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, ModalRoute.withName('/'));
            },
          ),
        ] 
        : [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Sign In",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          )
        ]
      ),
    );
  }
}
