import 'package:flutter/cupertino.dart';

import '../consts/consts.dart';
import '../consts/strings.dart';

Widget adminContainer(String title,String description,String price,itemsImgs,int quantity){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [

        Container(
          decoration:  BoxDecoration(border: Border.all(width: 1,color: Vx.gray300)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // padding for scren and border
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    Text(title,style: const TextStyle(fontFamily: regular,fontSize: 17,fontWeight: FontWeight.bold),),
                    5.heightBox,
                    Text(description,style: const TextStyle(fontFamily: regular,fontSize: 15),),
                    10.heightBox,
                    Row(
                      children:   [
                        const Text(quantitySt,style:  TextStyle(fontFamily: regular,fontSize: 15),),
                        25.widthBox,
                         Text(quantity.toString(),style: const TextStyle(fontSize:14,fontFamily: regular,fontWeight: FontWeight.bold),),

                      ],
                    ),
                    5.heightBox,
                  ],
                ),
              ),
              SizedBox(
                  height: 90,
                  width:  90,
                  child: Image.asset(itemsImgs)),
            ],
          ),
        ),
      ],
    ),
  );



}