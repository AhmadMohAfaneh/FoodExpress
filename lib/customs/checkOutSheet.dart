import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';
import '../consts/styles.dart';
import '../controllers/cart_controller.dart';
import '../models/prducts_model.dart';
import 'custom_elvated_button.dart';

Future checkOutSheet(CartModel? cartData, List<Product>? productsData, BuildContext context){
  var cartController = Get.find<CartController>();
  return Get.bottomSheet(
    SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height/2,
        color: myWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),  // Added padding here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(paymentSummarySt,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.start),
              10.heightBox,
              Card(
                color: myWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    10.heightBox,
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: regular,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            //                                                               yourOrderFromSt
                            text: yourOrderFromSt,
                            style: TextStyle(
                              color: myBlack,
                              fontFamily: brygadaVariable,
                              fontSize: 22,
                            ),
                          ),
                          TextSpan(
                            //                                                               restaurantName from the main page
                            text: restaurantNameSt,
                            style: TextStyle(
                              color: myBlack,
                              fontSize: 22,
                              fontFamily: regular,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    5.heightBox,
                    const Text(
                      paymentDetSt,
                      style: TextStyle(
                        fontFamily: brygadaVariable,
                        fontSize: 18,
                      ),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Changed to spaceBetween
                      children: const [
                        Text(
                          //                                                               orderSt
                          ordersSt,
                          style: TextStyle(
                            fontFamily: bold,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          //                                                               priceWordSt
                          priceWordSt,
                          style: TextStyle(
                              fontFamily: regular,
                              fontSize: 17,
                              color: myBlack),
                        ),
                      ],
                    ),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Changed to spaceBetween
                      children:  [
                        const Text(
                          cartTotalSt,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          priceSt + cartData!.totalPrice.toDouble().toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 17,
                            color: myBlack,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Changed to spaceBetween
                        children:  [
                          const Text(
                            deliveryfeeSt,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            priceSt + deliveryFeeSt.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 17,
                              color: myBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Changed to spaceBetween
                        children:  [
                          const Text(
                            salesTaxSt,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            //                                                               priceSt
                            priceSt + cartController.calculateTaxes(cartData.totalPrice.toDouble()).roundToDouble().toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 17,
                              color: myBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Changed to spaceBetween
                        children:  [
                          const Text(
                            totalAmount,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            //                                                               priceSt
                            priceSt + (cartData.totalPrice.toDouble() + cartController.calculateTaxes(cartData.totalPrice.toDouble())).toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 20,
                              color: myBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customElevatedButton(
                      onPressed: (){
                        Get.back();},
                      child: const Text(cancelSt,
                        style: TextStyle(color: redColor,fontSize: 16),),
                      fixedSize: const Size(130, 50), color: whiteColor),
                  40.widthBox,
                  customElevatedButton(onPressed: (){
                  },
                      child: const Text(checkOutSt,
                          style: TextStyle(color: whiteColor,fontSize: 16)),
                      fixedSize: const Size(130, 50), color: redColor),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
