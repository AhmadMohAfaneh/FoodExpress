
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/auth.controller.dart';
import 'package:e_commerce/screens/auth_screen/reset_password_screen.dart';
import 'package:e_commerce/screens/auth_screen/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/strings.dart';
import '../../customs/custom_auth_button.dart';
import '../../customs/custom_google_Button.dart';
import '../../customs/custom_password_text_field.dart';
import '../../customs/custom_text-field.dart';
import '../../customs/logo.dart';


class LogInPage extends StatelessWidget {
   const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    var loginController = Get.put(LoginController());
    return  Scaffold(
     backgroundColor: redColor,
     body: SingleChildScrollView(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Center(
             child: Padding(
               padding:  EdgeInsets.only( top: MediaQuery.of(context).size.height/4-20, bottom: 25),
               child: Image.asset(imgWrittenLogo,width: MediaQuery.of(context).size.width-150),
             ),
           ),

           Center(
             child: Column(
               children: [
                 SizedBox(
                   height: MediaQuery.of(context).size.height/1.88,
                   width: MediaQuery.of(context).size.width-20,
                   // width: 400,
                   // height: 325,
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
                           15.heightBox,
                               Align(
                                 alignment: Alignment.bottomRight,
                                 child: GestureDetector(
                                     onTap: () {
                                       Get.to(() =>  const ResetPassword());
                                     },
                                     child: const Text(forgetPasswordSt,style: TextStyle(fontSize: 12,fontFamily: regular),)),
                               )
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
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               const Text(doesNotHaveAccountSt,style: TextStyle(fontSize: 12),),
                               TextButton(
                                 child: const Text(
                                   registerSt,
                                   style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: myBlack),
                                 ),
                                 onPressed: () {
                                   Get.offAll(SignUpPage());
                                 },
                               )
                             ],
                           ),

                         ],
                       ),
                     ),
                   ),
                 ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GoogleButton(onPressed: () {

                  }),
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
