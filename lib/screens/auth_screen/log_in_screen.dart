
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/auth.controller.dart';
import 'package:e_commerce/screens/auth_screen/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/strings.dart';
import '../../customs/custom_auth_button.dart';
import '../../customs/custom_google_Button.dart';
import '../../customs/custom_password_text_field.dart';
import '../../customs/custom_text-field.dart';
import '../../logo.dart';


class LogInPage extends StatelessWidget {
   const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    LoginController loginController = LoginController();
   return  Scaffold(
     backgroundColor: redColor,
     body: SingleChildScrollView(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.only(left: 85,top: 100,bottom: 90),
             child: AppConst.logoCons(),
           ),

           Center(
             child: Column(
               children: [
                 SizedBox(
                   width: 400,
                   height: 325,
                   child: Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0),
                     ),
                     elevation: 8,
                     color: Colors.white,
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(
                         children:  [
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               15.heightBox,
                                const Text(emailSt,style: TextStyle(color: Colors.red,fontSize: 16,fontFamily: semibold),),
                           5.heightBox,
                           CustomTextField(
                             controller: loginController.emailController,
                             obscureText: false,
                             hintText: hintEmail,
                             iconData: Icons.email,
                           ),
                           const SizedBox(height: 15),

                             const Text(passwordSt,style: TextStyle(color: Colors.red,fontSize: 16,fontFamily: semibold),),
                           5.heightBox,
                           CustomPassTextField(controller: loginController.passwordController,
                             hintText: hintPassword,),
                           10.heightBox,
                             ],
                           ),
                           10.heightBox,
                           Obx(() =>
                              SizedBox(
                               height: 50,
                               width: 120,
                               child: authController.isLoading.value ? const CircularProgressIndicator(): CustomButton(
                                 onPressed: () async {
                                   if(loginController.emptyInfoFields == true) {
                                     authController.isLoading.value = true;
                                     authController.loginMethod(
                                         email: loginController.emailController.text,
                                         password: loginController.passwordController.text,
                                         context: context
                                     );
                                   }
                                   else{
                                     VxToast.show(context, msg: loginController.errorMessage.value);
                                         null;
                                   }

                                 },
                                 text: loginSt,
                                 color: redColor,
                                 textColor: myWhite,
                               ),
                             ),
                           ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() =>  ResetPassword());
                                },
                                  child: const Text(forgetPasswordSt,style: TextStyle(fontSize: 12,fontFamily: regular),)),
                            )
                         ],
                       ),
                     ),
                   ),
                 ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GoogleButton(onPressed: () {}),
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
