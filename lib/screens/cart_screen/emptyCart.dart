import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/cart_container.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/search_screen/search_screen.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../customs/custom_menu_container.dart';
import '../../customs/custom_elvated_button.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    var productController = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
          body: Center(
        child: Card(
          color: myWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1),
          ),
          child: Column(
            children: [
              10.heightBox,
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: 12, fontFamily: regular),
                  children: <TextSpan>[
                    TextSpan(
                        text: yourOrderFromSt,
                        style: TextStyle(
                            color: myBlack,
                            fontFamily: brygadaVariable,
                            fontSize: 22)),
                    TextSpan(
                        text: restaurantNameSt,
                        style: TextStyle(
                            color: myBlack,
                            fontSize: 22,
                            fontFamily: regular,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              5.heightBox,
              const Text(
                orderDetSt,
                style: TextStyle(fontFamily: brygadaVariable, fontSize: 18),
              ),
              5.heightBox,
              const Text("Nothing in your cart"),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(5), bottom: Radius.circular(10)),
                    border: Border.all(width: 0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(totalPrice,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: regular,
                            fontWeight: FontWeight.bold)),
                    100.widthBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
