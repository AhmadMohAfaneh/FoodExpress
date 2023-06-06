import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/logo.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

class CustomButton extends StatelessWidget {
   const CustomButton({Key? key, required this.text, required this.onPressed, required this.color, required this.textColor}) : super(key: key);
  final String? text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

       // height: 55,
      //   width: 340,

      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),

      ),
        onPressed: onPressed,
        child: Text(text?? "",style: TextStyle(color: textColor,fontFamily: bold)),);}}
