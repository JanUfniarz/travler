import 'package:flutter/material.dart';
import 'package:frontend/style/palette.dart';

class TravlerScaffold extends StatelessWidget {
  final Widget? body;
  const TravlerScaffold({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pal.background,
      body: body ?? const Placeholder(/*TODO make manin scaffold*/),
      appBar: PreferredSize(
        preferredSize: const Size(10, 40),
        child: AppBar(
          backgroundColor: Pal.primary,
        ),
      ),
    );
  }
}
