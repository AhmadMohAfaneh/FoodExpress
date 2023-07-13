import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../consts/firebase_consts.dart';

class NotificationController extends GetxController{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestPermission();
    getToken();
  }
  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null ) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            '1',
            'channel name',
            channelDescription: "channel.description",
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            enableVibration: true,

            icon: 'launch_background',
          ),
        ),
      );
    }
  }


  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      // setState(() {
        var mtoken = token;
        print("my token is $mtoken");
      // });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({
      'token': token,
    });
  }
  void sendPushMessage(String token,  body,  title) async {
    try {
      var response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=AAAAZRYkHhM:APA91bHub33tla049FQFp2p223HMasitnuIkouv_wX93FgH4ItMKEkSVQITkM0mSmeXPvDYZIlKh35jRn3snfe6ife48gsp6B5-oQ7fT2iGxKjIsmIg5I95rGSotyM0zgc8H6sPtCn_B'
          },
          body: jsonEncode({
            "to" : token,
            "notification" : {
              "body" : body,//status type
              "title": title
            },
            "data" : {
              "body" : body,
              "title": title,
            }
          })
      );
      print(response.statusCode.toString());
    } catch (e) {
      print(e.toString());
    }
  }

}