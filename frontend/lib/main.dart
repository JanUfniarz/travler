import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/views/login_page.dart';

import 'change_notifiers/login_cn.dart';

void main()=> runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginCN>.value(
        value: LoginCN(),
      ),
    ],
    child: MaterialApp(home: LoginPage())
));