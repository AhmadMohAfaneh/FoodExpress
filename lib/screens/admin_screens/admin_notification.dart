// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce/consts/consts.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
//
// class AdminNoti extends StatefulWidget {
//   const AdminNoti({Key? key}) : super(key: key);
//
//   @override
//   State<AdminNoti> createState() => _AdminNotiState();
// }
//
// class _AdminNotiState extends State<AdminNoti> {
//   // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   //     FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     requestPermission();
//     getToken();
//   }
//   // void showFlutterNotification(RemoteMessage message) {
//   //   RemoteNotification? notification = message.notification;
//   //   AndroidNotification? android = message.notification?.android;
//   //   if (notification != null && android != null ) {
//   //     flutterLocalNotificationsPlugin.show(
//   //       notification.hashCode,
//   //       notification.title,
//   //       notification.body,
//   //       NotificationDetails(
//   //         android: AndroidNotificationDetails(
//   //           '1',
//   //          'channel name',
//   //           channelDescription: "channel.description",
//   //           // TODO add a proper drawable resource to android, for now using
//   //           //      one that already exists in example app.
//   //           icon: 'launch_background',
//   //         ),
//   //       ),
//   //     );
//   //   }
//   // }
//   // void requestPermission() async {
//   //   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   //   NotificationSettings settings = await messaging.requestPermission(
//   //     alert: true,
//   //     announcement: false,
//   //     badge: true,
//   //     carPlay: false,
//   //     criticalAlert: false,
//   //     sound: true,
//   //   );
//   //   FirebaseMessaging.onMessage.listen(showFlutterNotification);
//   //
//   //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //     print('User granted permission');
//   //   } else if (settings.authorizationStatus ==
//   //       AuthorizationStatus.provisional) {
//   //     print('User granted provisional permission');
//   //   } else {
//   //     print('User declined or has not accepted permission');
//   //   }
//   // }
//   //
//   // void getToken() async {
//   //   await FirebaseMessaging.instance.getToken().then((token) {
//   //     setState(() {
//   //       var mtoken = token;
//   //       print("my token is $mtoken");
//   //     });
//   //     saveToken(token!);
//   //   });
//   // }
//   //
//   // void saveToken(String token) async {
//   //   await FirebaseFirestore.instance
//   //       .collection('users')
//   //       .doc(auth.currentUser!.uid)
//   //       .update({
//   //     'token': token,
//   //   });
//   // }
//
//   // void sendPushMessage(String token, String body, String title) async {
//   //   try {
//   //     var response = await http.post(
//   //         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//   //         headers: <String, String>{
//   //           'Content-Type': 'application/json',
//   //           'Authorization': 'key=AAAAZRYkHhM:APA91bHub33tla049FQFp2p223HMasitnuIkouv_wX93FgH4ItMKEkSVQITkM0mSmeXPvDYZIlKh35jRn3snfe6ife48gsp6B5-oQ7fT2iGxKjIsmIg5I95rGSotyM0zgc8H6sPtCn_B'
//   //         },
//   //         body: jsonEncode({
//   //           "to" : token,
//   //           "notification" : {
//   //             "body" : "Body of Your Notification",//status type
//   //             "title": "your delivery :"
//   //           },
//   //           "data" : {
//   //             "body" : "Body of Your Notification in Data",
//   //             "title": "Title of Your Notification in Title",
//   //           }
//   //         })
//   //     );
//   //     print(response.statusCode.toString());
//   //   } catch (e) {
//   //     print(e.toString());
//   //   }
//   // }
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController bodyController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Container(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text("Hello "),
//             TextField(
//               controller: nameController,
//             ),
//             TextField(
//               controller: titleController,
//             ),
//             TextField(controller: bodyController),
//             ElevatedButton(
//                 onPressed: () async {
//                   String name = nameController.text;
//                   String titleText = titleController.text;
//                   String bodyText = bodyController.text;
//                   var list = await FirebaseFirestore.instance
//                       .collection('users')
//                       .get();
//
//                   showModalBottomSheet(
//                       context: context,
//                       builder: (context) {
//                         return ListView.builder(
//                             itemCount: list.docs.length,
//                             itemBuilder: (context, i) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     if (list.docs[i].data()['token'] != null)
//                                       sendPushMessage(
//                                           list.docs[i].data()['token'],
//                                           bodyText,
//                                           titleText);
//                                   },
//                                   child: Container(
//                                     color: Colors.red,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                           list.docs[i].data()['name'] ?? "???"),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             });
//                       });
//                 },
//                 child: const Text("The button"))
//           ],
//         )),
//       ),
//     );
//   }
// }
