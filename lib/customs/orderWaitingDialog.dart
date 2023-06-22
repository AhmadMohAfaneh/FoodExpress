import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future orderWaiting(){
  return Get.defaultDialog(
    title: "Thank You for ordering from$restNameSt",
    content: const Text("This is ahmad afaneh "),
  );

}