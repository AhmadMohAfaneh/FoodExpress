import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/screens/admin_screens/admin_home_screen.dart';
import 'package:e_commerce/screens/auth_screen/intro_screen.dart';
import 'package:e_commerce/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'consts/strings.dart';
import 'controllers/auth.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: restaurantNameSt,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
      fontFamily: regular,
    ),
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading spinner while waiting
        } else {
          if (snapshot.hasData) {
            //  signed in
            print("///////////////////////////////////////${snapshot.data!.uid}");
            return const Home();

          } else {
            //  not signed in
            return const  IntroPage();
          }
        }
      },
    ),
  ));
}
