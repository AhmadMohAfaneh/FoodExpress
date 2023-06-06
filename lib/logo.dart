import 'package:flutter/material.dart';
import 'consts/colors.dart';
class AppConst {

    static Widget logoCons() {
      // "FoodExpress"
      Text firstLogoText =  const Text("Food", style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: myBlack),);
      Text lastLogoText = const Text("Express", style: TextStyle(fontSize: 40,
          fontWeight: FontWeight.bold,
          color: myWhite),);
      return Row(children: [firstLogoText, lastLogoText],);
    }
}