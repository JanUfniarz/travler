// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:frontend/change_notifiers/login_cn.dart';
import 'package:frontend/helpers/travler_scaffold.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';
import '../style/text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<LoginCN>(
    builder: (context, notifier, child) => TravlerScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Log in to continue:",
                style: TextStyles.simpleLight,
              ),
            ) as Widget,
          ] + List.generate(notifier.registration ? 3 : 2, (index) => Card(
            elevation: 40,
            color: Pal.background2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(["Login:", "Password:", "Repeat password:"][index],
                    style: TextStyles.simpleLight,
                  ),
                  TextField(
                    onChanged: [
                          (String text) => notifier.login = text,
                          (String text) => notifier.password = text,
                          (String text) => notifier.repeatPassword = text,
                    ][index],
                  ),
                ],
              ),
            ),
          ) as Widget) + List.generate(2, (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                onPressed: [
                      () => notifier.go(),
                      () => notifier.registration = !notifier.registration,
                ][index],
                style: ElevatedButton.styleFrom(
                    backgroundColor: [Pal.primary, Pal.background2][index]
                ),
                child: Text((notifier.registration ? ["Sign in", "Back"] : ["Log in", "Register"])[index],
                  style: [TextStyles.simpleDark, TextStyles.simpleLight][index],
                ),
              ),
            ),
          ) as Widget)..insert(4,
            !notifier.registration ? Text("You don't have an account?",
                style: TextStyles.simpleLight
            ) : const SizedBox(),
          ),
        ),
      ),
    ),
  );
}
