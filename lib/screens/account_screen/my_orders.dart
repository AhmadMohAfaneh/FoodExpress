import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/orders_controller.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/orders_model.dart';


class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderController = Get.put(OrdersController());
    var cartController = Get.put(CartController());
    var prductController = Get.put(ProductController());

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: StreamBuilder<List<Orders>>(
              stream: orderController.getUserAllOrdersData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (snapshot.hasError){
                  return Center(
                    child: Text(errorSt + snapshot.error.toString()),
                  );
                }
                else {
                  var ordersData = snapshot.data;
                  return SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              //                                                               your ordersSt
                              yourOrdersSt,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.bold,
                                  color: myWhite),
                            ),
                            Icon(
                              Icons.shopping_bag,
                              size: 50,
                              color: myWhite,
                            )
                          ],
                        ),
                        40.heightBox,
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: ordersData!.length,
                            itemBuilder: (context, ordersIndex) {
                              return Column(
                                children: [
                                  30.heightBox,
                                  Card(
                                    color: myWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(width: 1),
                                    ),
                                    child: Column(
                                      children: [
                                        10.heightBox,
                                        RichText(
                                          textAlign: TextAlign.center,
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
                                                //                                                               restaurantName fro the main pagea
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
                                          //                                                               orderDetSt
                                          orderDetSt,
                                          style: TextStyle(
                                            fontFamily: brygadaVariable,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
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
                                                  color: redColor),
                                            ),
                                          ],
                                        ),
                                        5.heightBox,
                                        5.heightBox,
                                        StreamBuilder<List<Product>>(
                                          stream: orderController.getProductDataFromOrderData(ordersData[ordersIndex].products.map((product) => product['p_id'].toString()).toList()),
                                          builder: (context, snapshot) {
                                            if(snapshot.connectionState == ConnectionState.waiting){
                                             return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                            else if(snapshot.hasError){
                                              return Center(
                                                child: Text(errorSt + snapshot.error.toString()),
                                              );
                                            }
                                            else {
                                              var productsData = snapshot.data;
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: productsData!.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceAround,
                                                    children:  [
                                                      Text(
                                                        productsData[index].name,
                                                        style: const TextStyle(
                                                          fontFamily: regular,
                                                          fontSize: 15,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                       Text(
                                                         cartController
                                                             .getQuantityPrice(
                                                           productsData[index],
                                                           ordersData[ordersIndex].products[index]
                                                           ['quantity']).roundToDouble().toString() + priceSt ,
                                                        style: const TextStyle(
                                                            fontFamily: regular,
                                                            fontSize: 15,
                                                            color: redColor),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children:  [
                                              const Text(
                                                //                                                               totalPrice
                                                totalPriceSt,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                //                                                               priceSt
                                                ordersData[ordersIndex].totalPrice.toString()+priceSt,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: redColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            )
        )
    );
  }
}
