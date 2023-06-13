import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/screens/auth_screen/sign_up_page.dart';
import 'package:e_commerce/controllers/auth.controller.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  void handleSwipe(Direction direction) {
    switch (direction) {
      case Direction.right:
        Get.to(() => SignUpPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity!.isNegative) {
          handleSwipe(Direction.right);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/1.3,
                child: Image.asset(imgNewLogo,),
              ),
              const Text(welcomingSt,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(swipeRegSt,
                style: TextStyle(fontSize: 18, color: introSwipeColor),
              ),
              const SizedBox(height: 20),
              Icon(Icons.arrow_forward_ios, size: 50, color: introSwipeColor,),
            ],
          ),
        ),
      ),
    );
  }
}

enum Direction { left, right }
