import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget offersContainer(String title,String description,String price,itemsImgs){
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
              Row(
                children: [
                  Text(price,style: const TextStyle(fontFamily: regular,fontSize: 15,color: redColor),),
                 40.widthBox,
                 const  Text("JOD 2.5",style: TextStyle(fontFamily: regular,fontSize: 15,color: redColor),),
                ],
              )
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