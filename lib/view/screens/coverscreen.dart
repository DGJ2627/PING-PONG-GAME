import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {

  final bool gameHaseStarted;
  CoverScreen({required this.gameHaseStarted});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child:  Text(gameHaseStarted ? ' ' : "T A P   T O   P L A Y",style:  TextStyle(color: Colors.white),),
    );
  }
}
