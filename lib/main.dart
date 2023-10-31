import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/view/screens/HomePage.dart';

void main() {
  runApp(
    const Gautam(),
  );
}

class Gautam extends StatelessWidget {
  const Gautam({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
