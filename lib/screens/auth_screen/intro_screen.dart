
import 'package:e_commerce/controllers/auth.controller.dart';
import 'package:e_commerce/screens/admin_screens/admin_home_screen.dart';
import 'package:e_commerce/screens/auth_screen/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../customs/custom_auth_button.dart';
import 'log_in_screen.dart';

class IntroPage extends StatelessWidget {
    const IntroPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();
    return   Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.only(left: 85,right: 70),
              child:Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                color: myWhite,
                child: Image.asset(imgMyLogo,
                    height: 130,
                    width: 130),
              )

            ),
            const Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: SizedBox(
                  height: 55,
                  width: 340,
                  child: CustomButton(onPressed: () => Get.to(() =>  LogInPage()),text: loginSt,color: myWhite,textColor: redColor))
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15,left: 17),
              child: SizedBox(
                  height: 55,
                  width: 340,
                  child: CustomButton(onPressed: () {Get.to(() =>  SignUpPage());}, text: createAccountSt,color: redColor, textColor: myWhite)),
            ),
           // const Spacer(flex: 4,), // keep this after deleting the codes
          // delete this code here
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: SizedBox(

                  height: 55,
                  width: 340,
                  child: CustomButton(onPressed: () {Get.to(() => const AdminHomePage());}, text: "admin page demo",color: redColor, textColor: myWhite)),
            ),
          ],
        ),
      ),

    );
  }
}
