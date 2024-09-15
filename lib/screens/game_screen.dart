// import 'dart:async';
// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
//
// class AirHockey extends StatefulWidget {
//   @override
//   _AirHockeyState createState() => _AirHockeyState();
// }
//
// class _AirHockeyState extends State<AirHockey> {
//   late Offset defaultBallPosition; // Default ball position
//   double playerOneXOffset = 0;
//   double playerTwoXOffset = 0;
//   Alignment ballDirection = Alignment.topRight;
//   double speed = 0.015;
//   late Offset ballPosition; // Initialize ball position
//   late Timer timer;
//   late Timer computerTimer;
//   late Timer countdownTimer;
//   late Size size;
//   int player1points = 0;
//   int player2points = 0;
//   double aiSpeed = 4.0; // Speed of AI paddle movement
//   int countdown = 4; // Countdown timer
//
//   void timerFunction(Timer t) {
//     Offset moveOffset = Offset(
//       speed * size.width * ballDirection.x,
//       speed * size.width * ballDirection.y,
//     );
//     Offset endOffset = ballPosition + moveOffset;
//     if (endOffset.dx < 20) {
//       ballDirection = Alignment(1, ballDirection.y);
//       endOffset = Offset(20 + (20 - endOffset.dx), endOffset.dy);
//       speed *= 1.05;
//     } else if (endOffset.dx + 40 > size.width) {
//       ballDirection = Alignment(-1, ballDirection.y);
//       endOffset = Offset(
//         size.width - (endOffset.dx - size.width),
//         endOffset.dy,
//       );
//       speed *= 1.05;
//     }
//     if (endOffset.dy < 70) {
//       double temp = (ballPosition.dy - 70) / (ballPosition.dy - endOffset.dy);
//       Offset tempOffset = ballPosition + moveOffset.scale(temp, temp);
//       if (playerOneXOffset < tempOffset.dx &&
//           playerOneXOffset + size.width / 3 > tempOffset.dx) {
//         ballDirection = Alignment(ballDirection.x, 1);
//         endOffset = Offset(endOffset.dx, 70 + (70 - endOffset.dy));
//         speed *= 1.05;
//       } else {
//         player2points += 1;
//         ballPosition = defaultBallPosition;
//         speed = 0.03;
//         timer.cancel();
//         computerTimer.cancel(); // Cancel computer movement timer
//         startCountdown(); // Start countdown before reinitializing timers
//       }
//     }
//     ///player 2
//     else if (endOffset.dy + 40 > size.height - 70) {
//       double temp = (size.height - 70 - ballPosition.dy) /
//           (endOffset.dy + 40 - ballPosition.dy);
//       Offset tempOffset = ballPosition + moveOffset.scale(temp, temp);
//
//       if (playerOneXOffset < tempOffset.dx &&
//           playerOneXOffset + size.width / 3 > tempOffset.dx) {
//         ballDirection = Alignment(ballDirection.x, -1);
//         endOffset = Offset(
//           endOffset.dx,
//           size.height - 70 - (endOffset.dy + 40 - size.height + 70),
//         );
//         speed *= 1.05;
//       } else {
//         player1points += 1;
//         ballPosition = defaultBallPosition;
//         speed = 0.03;
//         timer.cancel();
//         computerTimer.cancel(); // Cancel computer movement timer
//         startCountdown(); // Start countdown before reinitializing timers
//       }
//     }
//     // else if (endOffset.dy > size.height - 70) {
//     //   double temp = (size.height - 70 - ballPosition.dy) /
//     //       (endOffset.dy - ballPosition.dy);
//     //   Offset tempOffset = ballPosition + moveOffset.scale(temp, temp);
//     //
//     //   if (playerTwoXOffset < tempOffset.dx &&
//     //       playerTwoXOffset + size.width / 3 > tempOffset.dx) {
//     //     ballDirection = Alignment(ballDirection.x, -1);
//     //     endOffset = Offset(
//     //       endOffset.dx,
//     //       size.height - 70 - (size.height - 70 + endOffset.dy),
//     //     );
//     //     speed *= 1.05;
//     //   } else {
//     //     player1points += 1;
//     //     ballPosition = defaultBallPosition;
//     //     speed = 0.03;
//     //     timer.cancel();
//     //     computerTimer.cancel(); // Cancel computer movement timer
//     //     startCountdown(); // Start countdown before reinitializing timers
//     //   }
//     // }
//     setState(() {
//       ballPosition += moveOffset;
//     });
//   }
//
//   void computerMovementFunction(Timer t) {
//     double targetX = ballPosition.dx - size.width / 6; // Target position
//     double paddleCenterX = playerOneXOffset + size.width / 6;
//     double distanceToMove = targetX - paddleCenterX;
//
//     // Move AI paddle towards the target position smoothly
//     setState(() {
//       playerOneXOffset += distanceToMove.clamp(-aiSpeed, aiSpeed);
//       playerOneXOffset = playerOneXOffset.clamp(0.0, size.width - size.width / 3);
//     });
//   }
//
//   void initTimer() {
//     timer = Timer.periodic(Duration(milliseconds: 50), timerFunction);
//   }
//
//   void initComputerTimer() {
//     computerTimer = Timer.periodic(Duration(milliseconds: 20), computerMovementFunction); // Smoother movement
//   }
//
//   void startCountdown() {
//     countdown = 4;
//     countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         countdown--;
//       });
//       if (countdown == 0) {
//         timer.cancel();
//         initTimer();
//         initComputerTimer(); // Reinitialize computer movement timer
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     startCountdown(); // Start countdown on initialization
//   }
//
//   @override
//   void dispose() {
//     timer.cancel();
//     computerTimer.cancel();
//     countdownTimer.cancel();
//     super.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     size = MediaQuery.of(context).size;
//     defaultBallPosition = Offset(size.width / 2, size.height / 2.4);
//     ballPosition = defaultBallPosition;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     return Scaffold(
//
//       body: Stack(
//         children: <Widget>[
//           Align(
//             alignment: Alignment(0, -0.5),
//             // child: Transform.rotate(
//             //   angle: math.pi,
//               child: Text(
//                 '$player1points',
//                 style: TextStyle(fontSize: 60, color: Colors.yellow),
//               ),
//             // ),
//           ),
//           Align(
//             alignment: Alignment(0, 0.5),
//             child: Text(
//               '$player2points',
//               style: TextStyle(fontSize: 60, color: Colors.yellow),
//             ),
//           ),
//           if (countdown > 0)
//             Center(
//               child: Text(
//                 'Game will start in $countdown seconds',
//                 style: TextStyle(fontSize: 30, color: Colors.blue),
//               ),
//             ),
//           Positioned(
//             width: size.width / 3,
//             height: 30,
//             left: playerOneXOffset,
//             top: 40,
//             child: Container(
//               color: Colors.green,
//             ),
//           ),
//           Positioned(
//             width: size.width / 3,
//             height: 30,
//             left: playerTwoXOffset,
//             bottom: 40,
//             child: GestureDetector(
//               child: Container(
//                 color: Colors.red,
//               ),
//             ),
//           ),
//           Positioned(
//             left: ballPosition.dx - 20,
//             top: ballPosition.dy ,
//             width: 40,
//             height: 40,
//             child: Container(
//               decoration: BoxDecoration(
//                image: DecorationImage(
//                  image: AssetImage('assets/images/ball.webp'),
//                  fit: BoxFit.fill,
//                ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             height: size.height / 2,
//             child: GestureDetector(
//               onHorizontalDragUpdate: (dragUpdateDetails) {
//                 setState(() {
//                   playerTwoXOffset += dragUpdateDetails.delta.dx;
//                 });
//               },
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             height: size.height / 2,
//             child: GestureDetector(
//               onHorizontalDragUpdate: (dragUpdateDetails) {
//                 setState(() {
//                   playerTwoXOffset += dragUpdateDetails.delta.dx;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ice_hockey_ball/screens/settings_screen.dart';
import 'package:ice_hockey_ball/utils/screen_navigation_extension.dart';
import '../constants/color_const.dart';
import '../constants/image_const.dart';
import 'intro_screen.dart';

class AirHockey extends StatefulWidget {
  @override
  _AirHockeyState createState() => _AirHockeyState();
}

class _AirHockeyState extends State<AirHockey> {
  late Offset defaultBallPosition; // Default ball position
  late Offset defaultPlayerOnePosition; // Default position for Player One
  late Offset defaultPlayerTwoPosition; // Default position for Player Two
  double playerOneXOffset = 0;
  double playerTwoXOffset = 0;
  Alignment ballDirection = Alignment.topRight;
  double speed = 0.015;
  late Offset ballPosition; // Initialize ball position
  late Timer timer;
  late Timer computerTimer;
  late Timer countdownTimer;
  late Size size;
  int player1points = 0;
  int player2points = 0;
  double aiSpeed = 4.0; // Speed of AI paddle movement
  int countdown = 3; // Countdown timer

  void timerFunction(Timer t) {
    Offset moveOffset = Offset(
      speed * size.width * ballDirection.x,
      speed * size.width * ballDirection.y,
    );
    Offset endOffset = ballPosition + moveOffset;
    if (endOffset.dx < 20) {
      ballDirection = Alignment(1, ballDirection.y);
      endOffset = Offset(20 + (20 - endOffset.dx), endOffset.dy);
      speed *= 1.05;
    } else if (endOffset.dx + 40 > size.width) {
      ballDirection = Alignment(-1, ballDirection.y);
      endOffset = Offset(
        size.width - (endOffset.dx - size.width),
        endOffset.dy,
      );
      speed *= 1.05;
    }
    if (endOffset.dy < 70) {
      double temp = (ballPosition.dy - 70) / (ballPosition.dy - endOffset.dy);
      Offset tempOffset = ballPosition + moveOffset.scale(temp, temp);
      if (playerOneXOffset < tempOffset.dx &&
          playerOneXOffset + size.width / 3 > tempOffset.dx) {
        ballDirection = Alignment(ballDirection.x, 1);
        endOffset = Offset(endOffset.dx, 70 + (70 - endOffset.dy));
        speed *= 1.05;
      } else {
        player2points += 1;
        var box = GetStorage();
        var player2Score = box.read("p2") ?? 0;
        if(player2Score < player2points){
          box.write("p2", player2points);
        }

        Get.defaultDialog(
            barrierDismissible: false,
            contentPadding: EdgeInsets.all(20.w),
            backgroundColor: mainColor.withOpacity(0.5),
            title: "congratulations".tr,
            titleStyle: TextStyle(color: whiteColor, fontSize: 20.sp),
            middleText: "player2_won".tr,

            middleTextStyle: TextStyle(color: whiteColor, fontSize: 16.sp),
            confirm: TextButton(
                onPressed: () {
                  resetPositions(); // Reset positions on player 1 score
                  // Cancel computer movement timer
                  startCountdown();
                  Get.back();
                },
                child: Image.asset(
                  restartImg,
                  width: 30.w,
                  height: 30.h,
                )),
            cancel: TextButton(
                onPressed: () {
                  resetPositions();
                  Get.offAll(const IntroScreen());
                },
                child: Image.asset(
                  homeImg,
                  width: 30.w,
                  height: 30.h,
                )));

        timer.cancel();
        computerTimer.cancel(); // Cancel computer movement timer

      }
    }
    // Player 2 score
    else if (endOffset.dy + 40 > size.height - 70) {
      double temp = (size.height - 70 - ballPosition.dy) /
          (endOffset.dy + 40 - ballPosition.dy);
      Offset tempOffset = ballPosition + moveOffset.scale(temp, temp);

      if (playerOneXOffset < tempOffset.dx &&
          playerOneXOffset + size.width / 3 > tempOffset.dx) {
        ballDirection = Alignment(ballDirection.x, -1);
        endOffset = Offset(
          endOffset.dx,
          size.height - 70 - (endOffset.dy + 40 - size.height + 70),
        );
        speed *= 1.05;
      } else {
        player1points += 1;
        var box = GetStorage();
        var player1Score = box.read("p1") ?? 0;
        if(player1Score < player1points){
          box.write("p1", player1points);
        }

        Get.defaultDialog(
            barrierDismissible: false,
            contentPadding: EdgeInsets.all(20.w),
            backgroundColor: mainColor.withOpacity(0.5),
            title: "congratulations".tr,
            titleStyle: TextStyle(color: whiteColor, fontSize: 20.sp),
            middleText: "player1_won".tr,

            middleTextStyle: TextStyle(color: whiteColor, fontSize: 16.sp),
            confirm: TextButton(
                onPressed: () {
                  resetPositions(); // Reset positions on player 1 score
                  // Cancel computer movement timer
                  startCountdown();
                  Get.back();
                },
                child: Image.asset(
                  restartImg,
                  width: 30.w,
                  height: 30.h,
                )),
            cancel: TextButton(
                onPressed: () {
                  resetPositions();
                  Get.offAll(const IntroScreen());
                },
                child: Image.asset(
                  homeImg,
                  width: 30.w,
                  height: 30.h,
                )));
          //Get.snackbar('Game Over', 'Player 1 wins!',snackPosition: SnackPosition.BOTTOM,colorText: whiteColor,backgroundColor: mainColor);
        timer.cancel();
        computerTimer.cancel();
        // Start countdown before reinitializing timers
      }
    }
    setState(() {
      ballPosition += moveOffset;
    });
  }

  void computerMovementFunction(Timer t) {
    double targetX = ballPosition.dx - size.width / 6; // Target position
    double paddleCenterX = playerOneXOffset + size.width / 6;
    double distanceToMove = targetX - paddleCenterX;

    // Move AI paddle towards the target position smoothly
    setState(() {
      playerOneXOffset += distanceToMove.clamp(-aiSpeed, aiSpeed);
      playerOneXOffset = playerOneXOffset.clamp(0.0, size.width - size.width / 3);
    });
  }

  void initTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 50), timerFunction);
  }

  void initComputerTimer() {
    computerTimer = Timer.periodic(const Duration(milliseconds: 20), computerMovementFunction); // Smoother movement
  }

  void startCountdown() {
    countdown = 3;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });
      if (countdown == 0) {
        timer.cancel();
        initTimer();
        initComputerTimer(); // Reinitialize computer movement timer
      }
    });
  }

  void resetPositions() {
    setState(() {
      ballPosition = defaultBallPosition;
      playerOneXOffset = defaultPlayerOnePosition.dx;
      playerTwoXOffset = defaultPlayerTwoPosition.dx;
      speed = 0.03;
    });
  }

  @override
  void initState() {
    getScore();
    super.initState();
    startCountdown(); // Start countdown on initialization
  }
getScore()async{
    var box = GetStorage();
    var player1Score = box.read("p1") ?? 0;
    var player2Score = box.read("p2") ?? 0;
    setState(() {
      player1points = player1Score;
      player2points = player2Score;
    });

}
  @override
  void dispose() {
    timer.cancel();
    computerTimer.cancel();
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    defaultBallPosition = Offset(size.width / 2, size.height / 2.4);
    defaultPlayerOnePosition = Offset(size.width / 2 - size.width / 6, 40); // Player one default position
    defaultPlayerTwoPosition = Offset(size.width / 2 - size.width / 6, size.height - 70); // Player two default position
    ballPosition = defaultBallPosition;
    playerOneXOffset = defaultPlayerOnePosition.dx;
    playerTwoXOffset = defaultPlayerTwoPosition.dx;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
          ),

        ),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 55.h,
                left: 10.w,
                child: GestureDetector(
                    onTap: (){
                      context.navigateAndRemoveUntil(const IntroScreen(), false);
                    },
                    child: Image.asset('assets/images/back_btn.webp',width: 30.w,height: 30.h,))),
            Positioned(
                top: 55.h,
                right: 10.w,
                child: GestureDetector(
                    onTap: (){
                      timer.cancel();
                      computerTimer.cancel();
                      context.navigateAndRemoveUntil(const SettingsScreen(fromScreen: "g",), true);
                    },
                    child: Image.asset('assets/images/setting_icon.webp',width: 30.w,height: 30.h,))),
            Align(
              alignment: const Alignment(0, -0.5),
              child: Text(
                '$player1points',
                style: const TextStyle(fontSize: 60, color: Colors.yellow),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.5),
              child: Text(
                '$player2points',
                style: const TextStyle(fontSize: 60, color: Colors.yellow),
              ),
            ),
            if (countdown > 0)
              Center(
                child: Text(
                  'game_will_start'.tr+countdown.toString()+'seconds'.tr,
                  style:  TextStyle(fontSize: 18.sp, color: Colors.blue),
                ),
              ),
            Positioned(
              width: size.width / 3,
              height: 30,
              left: playerOneXOffset,
              top: 40,
              child: Container(
                color: Colors.green,
              ),
            ),
            Positioned(
              width: size.width / 3,
              height: 30,
              left: playerTwoXOffset,
              bottom: 40,
              child: GestureDetector(
                child: Container(
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              left: ballPosition.dx - 20,
              top: ballPosition.dy,
              width: 40,
              height: 40,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ball.webp'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: size.height / 2,
              child: GestureDetector(
                onHorizontalDragUpdate: (dragUpdateDetails) {
                  setState(() {
                    playerTwoXOffset += dragUpdateDetails.delta.dx;
                  });
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: size.height / 2,
              child: GestureDetector(
                onHorizontalDragUpdate: (dragUpdateDetails) {
                  setState(() {
                    playerTwoXOffset += dragUpdateDetails.delta.dx;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
