import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/cupertino.dart';

Widget menuContainer(String title,String description,String price,itemsImgs){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // padding for scren and border
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(title,style: const TextStyle(fontFamily: regular,fontSize: 17,fontWeight: FontWeight.bold),),
              5.heightBox,
              Text(description,style: const TextStyle(fontFamily: regular,fontSize: 15),),
              10.heightBox,
               Text(price,style: const TextStyle(fontFamily: regular,fontSize: 15,color: redColor),)
            ],
          ),
        ),
        SizedBox(
            height: 90,
            width:  90,
            child: Image.asset(itemsImgs)),
      ],
    ),
  );



}