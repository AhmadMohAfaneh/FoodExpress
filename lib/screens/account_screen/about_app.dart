import 'package:e_commerce/consts/colors.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(),
      body: Column(
        children: [
          20.heightBox,
          const Text(
            restaurantNameSt,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
         const  Text(
            appNameAccountScreenSt,
            style: TextStyle(fontSize: 18),
          ),
          const Text(
            versionSt,
            style: TextStyle(fontSize: 18),
          ),
         const  Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              appDescriptionSt,
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Text(
            contactUsSt,
            style: TextStyle(fontSize: 18),
          ),
         const  Text(
            followUsSt,
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon:  icFacebook,
                onPressed: () {
                  // Open Facebook page
                },
              ),
              IconButton(
                icon: const  ImageIcon(AssetImage(icTwitter)), onPressed: () {  },
              ),
              IconButton(
                icon: const ImageIcon(AssetImage(icInstegram)), onPressed: () {  },

              )
            ],
          ),
          const Text(
            appUpdatesSt,
            style: TextStyle(fontSize: 18),
          ),
         const  Text(
            updatesDone1St,
            style: TextStyle(fontSize: 18),
          ),
         const  Text(
            updatesDone2St,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
