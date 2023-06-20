import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/products_controller.dart';

Widget menuContainer(title, description, price, itemsImgs,newPrice,offer){
 var  productController = Get.put(ProductController());
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // padding for screen and border
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: const TextStyle(fontFamily: regular,fontSize: 17,fontWeight: FontWeight.bold),),
                5.heightBox,
                Text(description,style: const TextStyle(fontFamily: regular,fontSize: 15), softWrap: true), // removed maxLines
                10.heightBox,
                offer.toLowerCase() == "yes" ?
                    //change all code
                Row(
                  children: [
                    Text(priceSt + price, style: const TextStyle(fontFamily: regular, fontSize: 15, color: redColor, decoration: TextDecoration.lineThrough),),
                    20.widthBox,
                   Text(priceSt + newPrice.toString(),style: const TextStyle(fontFamily: regular,fontSize: 15,color: redColor)),
                  ],
                )
            :   Text(priceSt + price, style: const TextStyle(fontFamily: regular, fontSize: 15, color: redColor),),

              ],
            ),
          ),
        ),
        SizedBox(
            height: 90,
            width:  90,
            child: Image.network(itemsImgs)
        ),
      ],
    ),
  );
}
