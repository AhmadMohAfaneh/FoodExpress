import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/customs/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText,
    this.hintText,
    this.color,
    this.iconData,
    this.onIconPressed,
    this.onChanged,
    this.labelText,
    this.smallField = false,
    this.labelTextColor = textfieldGrey,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController controller;
  final Color? color;
  final IconData? iconData;
  final bool? obscureText;
  final VoidCallback? onIconPressed;
  Function(String)? onChanged;
  final String? labelText;
  final bool smallField;
  final Color labelTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText?? false,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: lightGrey,
          isDense: true,
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: semibold,
            color: labelTextColor,
          ),
          suffixIcon: IconButton(
            onPressed: onIconPressed,
            icon: Icon(
              iconData,
              color: redColor,
            ),
            color: Colors.black87,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: semibold, color: textfieldGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: myBlack),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: myWhite),
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: smallField
              ? const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0)
              : const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
      ),
    );
  }
}
