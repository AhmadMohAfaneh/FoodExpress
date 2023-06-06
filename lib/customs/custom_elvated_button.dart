
import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';

Widget customElevatedButton({required VoidCallback onPressed, required Widget child,required Size fixedSize,required Color color}){
  return   ElevatedButton(onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: fixedSize,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          )
      ),
      child: child);
}