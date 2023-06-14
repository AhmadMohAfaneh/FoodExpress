import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/customs/logo.dart';
import 'package:flutter/cupertino.dart';
import '../consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

Widget customTextButton({
  required VoidCallback onTap,
  required String text,
  AssetImage? assetImage,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: ImageIcon(assetImage, size: 28, color: myBlack),
              ),
              const SizedBox(width: 25),
              Text(
                text,
                style: const TextStyle(fontSize: 16, color: darkFontGrey, fontFamily: regular),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

