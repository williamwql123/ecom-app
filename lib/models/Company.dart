import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ecommerce_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Company> fetchCompany() async {
  final response = await http.get(Uri.https(kAPIDomain, 'api/getCompanyInfo'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseResult = jsonDecode(response.body);

    if (responseResult['error'] == 1) {
      throw Exception(responseResult['msg']);
    }

    return Company.fromJson(responseResult['data']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company');
  }
}

class Company {
  final String name;
  final String email;
  final String contactNo;
  final String address;
  final String logo;
  final splashData;

  Company(
      {this.name,
      this.email,
      this.contactNo,
      this.address,
      this.logo,
      this.splashData});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      email: json['email'],
      contactNo: json['contact_no'],
      address: json['address'],
      logo: json['logo_path'],
      splashData: json['company_data'],
    );
  }
}

checkIsFirstRun() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.containsKey('isFirstRun')) {
    return sharedPreferences.getBool("isFirstRun");
  } else {
    await sharedPreferences.setBool('isFirstRun', false);
    return true;
  }
}
