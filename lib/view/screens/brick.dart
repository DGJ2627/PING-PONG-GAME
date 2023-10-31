import 'package:flutter/material.dart';

class Mybrick extends StatelessWidget {
  const Mybrick({this.x, this.y ,this.brickWidth,this.thisISEnemy});

  final x;
  final y;
  final brickWidth;
  final thisISEnemy;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2*x + brickWidth) / (2-brickWidth), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisISEnemy ? Colors.deepPurple.shade300 :Colors.white,
          height: 20,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
        ),
      ),
    );
  }
}
