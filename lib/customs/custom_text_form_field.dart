import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

Widget customTextFormField({controller,labelText, required String? Function(dynamic value) validator}){
  return  TextFormField(
    controller: controller,
    decoration:  InputDecoration(fillColor: redColor,labelText: labelText,labelStyle: const TextStyle(color: fontGrey)),
    validator: validator,
  );




}