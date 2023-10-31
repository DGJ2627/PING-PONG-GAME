import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
   ScoreScreen({super.key,required this.gameStarted,required this.enemyScore,required this.playerScore});

  final bool gameStarted;
  final int enemyScore;
  final int playerScore;

  @override
  Widget build(BuildContext context) {
    return gameStarted ? Stack(
      children: [
        Container(
          alignment: const Alignment(0, 0),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width/4,
            color: Colors.grey.shade800,
          ),
        ),

        Container(
          alignment: const Alignment(0, -0.2),
          child: Text(enemyScore.toString(),style: TextStyle(color: Colors.grey.shade800,fontSize: 50),),
        ),

        Container(
          alignment: const Alignment(0, 0.2),
          child: Text(playerScore.toString(),style: TextStyle(color: Colors.grey.shade800,fontSize: 50),),
        ),
      ],
    ) : Container();
  }
}
