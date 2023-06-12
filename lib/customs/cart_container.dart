

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget cartContainer(String title,String description,String price,itemsImgs,quantity){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          decoration:  BoxDecoration(border: Border.all(width: 1,color: Vx.gray300)),
          child: Row(
            children: [
              // padding for screen and border
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.heightBox,
                      Text(
                        title,
                        style: const TextStyle(fontFamily: regular,fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                     20.heightBox,
                      Text(
                        description,
                        style: const TextStyle(fontFamily: regular,fontSize: 15),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          Text(price,style:  const TextStyle(fontFamily: regular,fontSize: 15,color: redColor),),
                          15.widthBox,
                          Text(
                            quantity.toString(),
                            style: const TextStyle(fontFamily: regular,fontSize: 15,),
                          ),
                          25.widthBox,
                          const Text(removeFromCart,style: TextStyle(fontSize:14,fontFamily: regular),),
                          GestureDetector(child: const ImageIcon(AssetImage(icTrash),size: 18,)),
                        ],
                      ),
                      5.heightBox,
                    ],
                  ),
                ),
              ),
              SizedBox(
                  height: 90,
                  width: 90,
                  child: Image.network(itemsImgs)
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
