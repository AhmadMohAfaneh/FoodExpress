import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/screens/admin_screens/admin_home_screen.dart';
import 'package:e_commerce/screens/admin_screens/admin_notification.dart';
import 'package:e_commerce/screens/auth_screen/intro_screen.dart';
import 'package:e_commerce/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'consts/strings.dart';
import 'controllers/auth_controller.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.getInitialMessage();
  Get.put(AuthController());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: restaurantNameSt,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
      fontFamily: regular,
    ),
    // home: AdminNoti()
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              if (snapshot.data!.uid == "uy6GIrrmOWev0lpQcBOPdGO6vyx1"){
                return const AdminHomePage();
              }else{
                //  signed in
                print(
                    "///////////////////////////////////////${snapshot.data!.uid}");
                return const Home();
              }
            }  else {
              //  not signed in
              return const  IntroPage();
            }
          }
        },
  )
  )
  );
}
