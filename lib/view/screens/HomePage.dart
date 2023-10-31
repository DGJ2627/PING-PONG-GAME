import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/view/screens/ball.dart';
import 'package:pong_game/view/screens/brick.dart';
import 'package:pong_game/view/screens/coverscreen.dart';
import 'package:pong_game/view/screens/scorescreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //player
  double playerX = -0.2;
  double brickWidth = 0.4;
  int playerScore = 0;

  //enemy variable (top brick)
  double enemyBallX = -0.2;
  int enemyScore = 0;

  //ball variable
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  //game setting
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      // update
      updateDirection();

      //move ball
      moveBall();

      // enemy move
      moveEnemy();

      //check if player dead
      if (isPlayerDead()) {
        enemyScore++;
        timer.cancel();
        _showDialog(false);
      }

      if (iEnemyDead()) {
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }
    });
  }

  bool iEnemyDead() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }

  void moveEnemy() {
    setState(() {
      enemyBallX = ballX;
    });
  }

  void _showDialog(bool enemyDied) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              enemyDied ? "WHITE WIN" : "PURPLE WIN",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  color: enemyDied ? Colors.white : Colors.deepPurple.shade100,
                  child: Text(
                    "PLAY AGAIN",
                    style: TextStyle(
                        color: enemyDied ? Colors.white : Colors.deepPurple),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      enemyBallX = -0.2;
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  //update direction
  void updateDirection() {
    setState(() {
      //vertical
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      // horizontal
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  //move ball
  void moveBall() {
    setState(() {
      //vertical
      if (ballYDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.01;
      }

      // horizontal
      if (ballXDirection == direction.LEFT) {
        ballX -= 0.01;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += 0.01;
      }
    });
  }

  moveLeft() {
    setState(() {
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.1;
      }
    });
  }

  moveRight() {
    setState(() {
      if (!(playerX + brickWidth >= 1)) {
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        // if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
        //   moveLeft();
        // } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
        //   moveRight();
        // }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Center(
            child: Stack(
              children: [
                CoverScreen(
                  gameHaseStarted: gameHasStarted,
                ),

                //score  screen

                ScoreScreen(
                  gameStarted: gameHasStarted,
                  enemyScore: enemyScore,
                  playerScore: playerScore,
                ),

                //enemy top brick
                Mybrick(
                  x: enemyBallX,
                  y: -0.9,
                  brickWidth: brickWidth,
                  thisISEnemy: true,
                ),

                //player bottom brick
                Mybrick(
                  x: playerX,
                  y: 0.9,
                  thisISEnemy: false,
                  brickWidth: brickWidth,
                ),

                //ball
                Myball(
                  x: ballX,
                  y: ballY,
                  gameHasStarted: gameHasStarted,
                ),

                // controller game

                Align(
                  alignment: const Alignment(0.5, 0.5),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            moveLeft();
                          },
                          child:  Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,

                            ),
                            child: const Icon(CupertinoIcons.left_chevron,size: 30,),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            moveRight();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,

                            ),
                            child: const Icon(CupertinoIcons.right_chevron,size: 30,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                // Container(
                //   alignment: Alignment(playerX, 0.9),
                //   child: Container(
                //     width: 2,
                //     height: 20,
                //     color: Colors.red,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
