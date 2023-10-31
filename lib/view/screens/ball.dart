import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Myball extends StatelessWidget {
  final x;
  final y;
  final bool gameHasStarted;

  const Myball({super.key, this.x, this.y,required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container(
            alignment: Alignment(x, y),
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          )
        : Container(
            alignment: Alignment(x, y),
            child: AvatarGlow(
              endRadius: 60,
              child: Material(
                elevation: 8,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  radius: 7,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          );
  }
}
