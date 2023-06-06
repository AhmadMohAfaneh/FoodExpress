import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/strings.dart';
import '../../controllers/auth.controller.dart';
import '../../customs/custom_auth_button.dart';
import '../../customs/custom_password_text_field.dart';
import '../../customs/custom_text-field.dart';
import '../../logo.dart';
import '../home_screen/home_screen.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());
  final SignupController signupController = SignupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 85, top: 53, bottom: 25),
              child: AppConst.logoCons(),
            ),
            Column(
              children: [
                SizedBox(
                  width: 390,
                  height: 520,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 20, left: 20, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          25.heightBox,
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: signupController
                                      .registerUsernameController,
                                  obscureText: false,
                                  hintText: hintUserName,
                                  iconData: Icons.drive_file_rename_outline,
                                  labelText: hintUserName,
                                  smallField: true,
                                  labelTextColor: myBlack,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: signupController
                                      .registerPhoneNumberController,
                                  obscureText: false,
                                  hintText: hintPhoneNumber,
                                  iconData: Icons.phone,
                                  labelText: hintPhoneNumber,
                                  smallField: true,
                                  labelTextColor: myBlack,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller:
                                signupController.registerAddressController,
                            obscureText: false,
                            hintText: hintAddress,
                            iconData: Icons.home_outlined,
                            labelText: addressSt,
                            labelTextColor: myBlack,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller:
                                signupController.registerEmailController,
                            obscureText: false,
                            hintText: hintEmail,
                            iconData: Icons.email,
                            labelText: emailSt,
                            labelTextColor: myBlack,
                          ),
                          const SizedBox(height: 10),
                          CustomPassTextField(
                            controller: signupController.registerPassController,
                            hintText: hintPassword,
                            labelText: passwordSt,
                          ),
                          const SizedBox(height: 10),
                          CustomPassTextField(
                            controller: signupController
                                .registerRetypePasswordController,
                            hintText: hintPassword,
                            labelText: retypePasswordSt,
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  activeColor: Colors.red,
                                  checkColor: Colors.white,
                                  value: signupController.isCheck.value,
                                  onChanged: (value) {
                                    signupController.isCheck.value = value!;
                                  },
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: const TextSpan(
                                    text: termsStatementSt,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: regular),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: termsSt,
                                          style: TextStyle(
                                              color: redColor,
                                              fontFamily: regular,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: termsCont,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: regular)),
                                      TextSpan(
                                          text: termsLastSt,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontFamily: regular)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(()=>
                              SizedBox(
                                  height: 50,
                                  width: 120,
                                  child: authController.isLoading.value ? const CircularProgressIndicator() :  CustomButton(
                                     onPressed: () async {
                                       if(signupController.emptyInfoFields == true ) {
                                         authController.isLoading.value = true ;
                                         try {
                                           await authController.signupMethod(
                                               email: signupController.registerEmailController.text,
                                               password: signupController.registerPassController.text,
                                               context: context
                                           ).then((value) {
                                             return signupController.storeUserData(
                                               name: signupController.registerUsernameController.text,
                                               address: signupController.registerAddressController.text,
                                               phoneNumber: signupController.registerPhoneNumberController.text,
                                               userType: 'user',
                                             );
                                           }).then((value) {
                                             Get.offAll(() => const Home());
                                             VxToast.show(context, msg: "successfully logged in ");
                                           });
                                         } catch (e) {
                                        {
                                          print(e);
                                          Get.offAll(() => SignUpPage());
                                        }
                                        }
                                       // first if statement
                                       }else {
                                         {
                                           VxToast.show(context, msg: signupController.errorMessage.value);
                                           null;}
                                       }


                                      // Get.off(() => ProfilePage());
                                      // here the condition
                                    },
                                    text: signupSt,
                                    color: signupController.isCheck.value
                                        ? redColor
                                        : Colors.white,
                                    textColor: Colors.white,
                                  )),
                          ),
                        ],
                      ),
                  ),
                ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
