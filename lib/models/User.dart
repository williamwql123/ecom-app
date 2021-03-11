import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ecommerce_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

login(formData) async {
  final response =
      await http.post(Uri.https(kAPIDomain, 'api/login'), body: formData);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseResult = jsonDecode(response.body);

    return responseResult;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to login');
  }
}

logout() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.remove('isLogin');
  await sharedPreferences.remove('userInfo');
}

setLoginSession(data) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map userInfo = {
    'email': data['email'],
    'password': data['token'],
  };
  await sharedPreferences.setBool("isLogin", true);
  await sharedPreferences.setString("userInfo", jsonEncode(userInfo));
}

checkIsLogin() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.containsKey('isLogin')) {
    return sharedPreferences.getBool("isLogin");
  }
  return false;
}
