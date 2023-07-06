import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../consts/colors.dart';
import '../consts/styles.dart';

Future orderWaiting(){
  return Get.defaultDialog(
    content: Column(
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: regular,
            ),
            children: <TextSpan>[
              TextSpan(
                //                                                               yourOrderFromSt
                text: thanksStatment,
                style: TextStyle(
                  color: myBlack,
                  fontFamily: brygadaVariable,
                  fontSize: 22,
                ),
              ),
              TextSpan(
                //                                                               restaurantName from the main page
                text: restaurantNameSt,
                style: TextStyle(
                  color: myBlack,
                  fontSize: 22,
                  fontFamily: regular,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Text("This is ahmad afaneh "),
      ],
    ),
  );

}