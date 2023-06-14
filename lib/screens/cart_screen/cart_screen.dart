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

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    var productController = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder<List<CartModel>>(
            stream: cartController.getCartData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var cartData = snapshot.data;
                return cartData!.isEmpty
                    ? Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/2-160),
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width - 25,
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
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: regular),
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
                                  style: TextStyle(
                                      fontFamily: brygadaVariable,
                                      fontSize: 18),
                                ),
                                5.heightBox,
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(5),
                                          bottom: Radius.circular(10)),
                                      border: Border.all(width: 0.5)),

                                ),

                               const  Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child:  Text(emptyCartSt,style: TextStyle(fontSize: 20,color: fontGrey),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height - 248,
                              width: MediaQuery.of(context).size.width - 30,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
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
                                            text: const TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: regular),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: yourOrderFromSt,
                                                    style: TextStyle(
                                                        color: myBlack,
                                                        fontFamily:
                                                            brygadaVariable,
                                                        fontSize: 22)),
                                                TextSpan(
                                                    text: restaurantNameSt,
                                                    style: TextStyle(
                                                        color: myBlack,
                                                        fontSize: 22,
                                                        fontFamily: regular,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          5.heightBox,
                                          const Text(
                                            orderDetSt,
                                            style: TextStyle(
                                                fontFamily: brygadaVariable,
                                                fontSize: 18),
                                          ),
                                          5.heightBox,
                                          SizedBox(
                                            height: 330,
                                            // Set the desired height for the ListView
                                            child: StreamBuilder<List<Product>>(
                                                stream: FirestoreServices
                                                    .getProductsByCart(
                                                        cartData[0]
                                                            .products
                                                            .map((product) =>
                                                                product['p_id'])
                                                            .toList()),
                                                //FirestoreServices.getProductsByCart(cartData![0].products.),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const CircularProgressIndicator();
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(errorSt +
                                                        snapshot.error
                                                            .toString());
                                                  } else {
                                                    var productsData =
                                                        snapshot.data;
                                                    return ListView.builder(
                                                      itemCount: cartData[0]
                                                          .products
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return cartContainer(
                                                          title: productsData![
                                                                  index]
                                                              .name,
                                                          description:
                                                              productsData[
                                                                      index]
                                                                  .description,
                                                          price: cartController
                                                              .getQuantityPrice(
                                                            productsData[index]
                                                                .price
                                                                .toDouble(),
                                                            cartData[0].products[
                                                                    index]
                                                                ['quantity'],
                                                          ),
                                                          itemsImgs:
                                                              productsData[
                                                                      index]
                                                                  .urlImage,
                                                          quantity: cartData[0]
                                                                      .products[
                                                                  index]
                                                              ['quantity'],
                                                        );
                                                      },
                                                    );
                                                  }
                                                }),
                                          ),
                                          Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                        top: Radius.circular(5),
                                                        bottom: Radius.circular(
                                                            10)),
                                                border: Border.all(width: 0.5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text(totalPrice,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: regular,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                100.widthBox,
                                                Text(
                                                    priceSt +
                                                        cartData[0]
                                                            .totalPrice
                                                            .toDouble()
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: regular,
                                                        color: redColor)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.heightBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: customElevatedButton(
                                              onPressed: () {
                                                cartController.deleteCart(
                                                    cartData[0].cartId);
                                              },
                                              color: myWhite,
                                              fixedSize: const Size(170, 50),
                                              child: const Text(
                                                cancelSt,
                                                style:
                                                    TextStyle(color: fontGrey),
                                              )),
                                        ),
                                        customElevatedButton(
                                            onPressed: () {},
                                            color: Colors.red,
                                            fixedSize: const Size(170, 50),
                                            child: const Text(checkOutSt))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Text(errorSt + snapshot.error.toString());
              }
            }),
      ),
    );
  }
}
