import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../logo.dart';

class CustomPassTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  Function(String)? onChanged;
  final String? labelText;

  CustomPassTextField({Key? key, required this.controller, this.hintText, this.onChanged, this.labelText}) : super(key: key);

  @override
  State<CustomPassTextField> createState() => _CustomPassTextFieldState();
}

class _CustomPassTextFieldState extends State<CustomPassTextField> {
  bool visibility = false;

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
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: visibility ? false : true,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: lightGrey,
          isDense: true,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                visibility = !visibility;
              });
            },
            icon: Icon(
              visibility ? Icons.visibility : Icons.visibility_off,
            ),
            color: redColor,
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            fontFamily: semibold,
            color: myBlack // Set the color of the label text
          ),
          hintStyle: const TextStyle(fontFamily: semibold, color: textfieldGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: myBlack),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: myWhite),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
