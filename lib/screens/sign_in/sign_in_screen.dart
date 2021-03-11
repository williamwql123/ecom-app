import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/User.dart';
import 'components/body.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    checkIsLogin().then((isLogin) {
      if (isLogin) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, ModalRoute.withName('/'));
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Body(),
    );
  }
}
