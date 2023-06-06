
import 'dart:ui';

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../consts/styles.dart';
import '../../customs/custom_auth_button.dart';
import '../../customs/custom_password_text_field.dart';
import '../../customs/custom_text-field.dart';
import '../../logo.dart';

class ResetPassword extends StatelessWidget {
   ResetPassword({Key? key}) : super(key: key);

  TextEditingController emailForResetPassword  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: redColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 85,top: 40,bottom: 42),
              child: AppConst.logoCons(),
            ),
             Padding(
              padding: EdgeInsets.only(bottom: 22),
              child: Text(resetPasswordSt,style:TextStyle(color: myWhite,fontSize: 22),),
            ),

            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    height: 310,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 8,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            20.heightBox,
                            const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                resetPassword,
                                style: TextStyle(
                                    color: myBlack,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                           20.heightBox,
                           const Text(emailSt,style: TextStyle(color: redColor,fontSize: 16,fontFamily: semibold)),
                           10.heightBox,
                           CustomTextField(controller: emailForResetPassword,hintText: hintEmail, obscureText: false,),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomButton(
                                  onPressed: () {},
                                  text: resetPasswordButSt,
                                  color: redColor,
                                  textColor: myWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );



  }
}



