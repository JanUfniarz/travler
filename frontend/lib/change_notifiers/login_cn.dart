// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginCN extends ChangeNotifier {
  static const String domain = "travler-vuyzipi4sq-lm.a.run.app";
  static const String path = "login";
  static const int version = 1;

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
      if (repeatPassword == null) return emptyAlert();
      if (password != repeatPassword) return notEqualPasswordAlert();
    }

    Uri url = Uri.parse(
        "https://$domain/v$version/$path/${registration ? "register" : "auth"}");

    Map<String, dynamic> body = {
      "login": login,
      "password": password
    };

    var res = registration
        ? await http.post(url, body: body)
        : await http.put(url, body: body);

    print(res.body);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(res.body),
        ),
      )
    ));
  }
  void emptyAlert() {}

  void notEqualPasswordAlert() {}
}