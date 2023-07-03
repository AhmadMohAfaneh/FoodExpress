import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';

Widget adminContainer(title, description,  itemsImgs,quantity){
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
                    Text(quantitySt + quantity.toString(), style: const TextStyle(fontFamily: regular, fontSize: 15),),

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
