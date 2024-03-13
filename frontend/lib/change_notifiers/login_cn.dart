// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginCN extends ChangeNotifier {
  static const String domain = "localhost:8080";
  static const String path = "login";
  static const int version = 1;
  static const Map<String, String> headers = {"Content-Type": "application/json"};

  String? login;
  String? password;
  String? repeatPassword;

  bool _registration = false;
  set registration(bool val) {
    _registration = val;
    notifyListeners();
  }
  bool get registration => _registration;

  void go(BuildContext context) async {
    if (login == null || password == null) return emptyAlert();

    if (registration) {
      if (repeatPassword == null) return show(context, "emptyAlert"); //emptyAlert();
      if (password != repeatPassword) return show(context, "notEqualPasswordAlert\n$password\n$repeatPassword"); //notEqualPasswordAlert();
    }

    Uri url = Uri.parse(
        "http://$domain/v$version/$path/${registration ? "register" : "auth"}");

    var body = jsonEncode({
      "login": login,
      "password": password
    });

    var res = registration
        ? await http.post(url, body: body, headers: headers)
        : await http.put(url, body: body, headers: headers);

    show(context, res.body);
  }
  void emptyAlert() {}

  void notEqualPasswordAlert() {}
}

//! temp
void show(BuildContext context, String text) => Navigator.push(context, MaterialPageRoute(
    builder: (context) => Scaffold(
      body: Center(
        child: Text(text),
      ),
    )
));