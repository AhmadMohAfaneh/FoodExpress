import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/cart_container.dart';
import 'package:e_commerce/customs/checkOutSheet.dart';
import 'package:e_commerce/customs/orderWaitingDialog.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/cart_screen/orderWaitingScreen.dart';
import 'package:e_commerce/screens/search_screen/search_screen.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controllers/orders_controller.dart';
import '../../customs/custom_menu_container.dart';
import '../../customs/custom_elvated_button.dart';

class CartScreen extends StatelessWidget {
    CartScreen({Key? key}) : super(key: key);
  List<Product>? productDataParam;
  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    var productController = Get.put(ProductController());
    var ordersController = Get.put(OrdersController());
    var quantityDataForOrders;
    var productDataIdForOrders;
    var totalAmountForOrders;
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder<List<CartModel>>(
            stream: cartController.getCartData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var cartData = snapshot.data;
                return cartData!.isEmpty || cartData[0].products.isEmpty
                    ? Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/2-220),
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 248,
                          width: MediaQuery.of(context).size.width - 30,
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
                              height: MediaQuery.of(context).size.height - 220,
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
                                            height: MediaQuery.of(context).size.height/2.35,

                                            child: StreamBuilder<List<Product>>(
                                                stream: FirestoreServices.getProductsByCart(
                                                  cartData[0].products.map((product) => product['p_id'].toString()).toList(),
                                                ),

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
                                                    productDataParam = productsData;
                                                    return ListView.builder(
                                                      itemCount: cartData[0]
                                                          .products
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        quantityDataForOrders = cartData[0].products[index];
                                                        print(quantityDataForOrders);
                                                        productDataIdForOrders =  productsData![index];
                                                        print(productDataIdForOrders);
                                                       totalAmountForOrders =  (cartData[0].totalPrice.toDouble() + cartController.calculateTaxes(cartData[0].totalPrice.toDouble())).toStringAsFixed(2);
                                                        return  cartContainer(
                                                          onTapTrash:(){
                                                            print("done");
                                                            cartController.removeCartOrder(cartData[0].cartId, productsData[index].productId);
                                                            print("done");
                                                          },
                                                          title: productsData[
                                                                  index]
                                                              .name,
                                                          description:
                                                              productsData[
                                                                      index]
                                                                  .description,
                                                          price: cartController
                                                              .getQuantityPrice(
                                                            productsData[index],
                                                            cartData[0].products[
                                                                    index]
                                                                ['quantity'],
                                                          ).toString(),
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
                                                const Text(totalPriceSt,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontFamily: regular,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                100.widthBox,
                                                Text(
                                                    priceSt +
                                                        cartData[0]
                                                            .totalPrice.toStringAsFixed(2)
                                                            ,
                                                    style: const TextStyle(
                                                        fontSize: 17,
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
                                          child: customElevatedButton (
                                              onPressed: () async {
                                              await Get.defaultDialog(
                                                     title: removeAllCartDialogTitleSt,
                                                     titleStyle: const TextStyle(color: fontGrey),
                                                  content: SizedBox(
                                                    height: MediaQuery.of(context).size.height/4,
                                                    width: MediaQuery.of(context).size.width-10,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:   [
                                                        SizedBox(height: MediaQuery.of(context).size.height/8-30, width: MediaQuery.of(context).size.width-200,child: Image.asset(imgAlertMessage),),
                                                       const Text(warningSt,style: TextStyle(color: redColor)),
                                                       const Padding(
                                                         padding: EdgeInsets.only(left: 10,top: 5),
                                                         child: Center(child: Text(removeAllCartDialogMidTextSt,style: TextStyle(color: fontGrey,fontSize: 13),softWrap: true,maxLines: 2,)),
                                                       ),
                                                        20.heightBox,
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Expanded(
                                                              // button for dialog box
                                                              child: customElevatedButton(
                                                                  onPressed: (){
                                                                Get.back();},
                                                                  child: const Text(cancelSt,
                                                                    style: TextStyle(color: redColor,fontSize: 16),),
                                                                  fixedSize: const Size(150, 50), color: whiteColor),
                                                            ),
                                                            20.widthBox,
                                                            Expanded(
                                                              child: customElevatedButton(onPressed: (){
                                                                cartController.deleteCart(
                                                                  cartData[0].cartId).then((back) => Get.back());
                                                                },
                                                                  child: const Text(removeSt,
                                                                    style: TextStyle(color: whiteColor,fontSize: 16)),
                                                                  fixedSize: const Size(150, 50), color: redColor),
                                                            ),


                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              color: myWhite,
                                              fixedSize: const Size(150, 50),
                                              child: const Text(
                                                cancelSt,
                                                style:
                                                    TextStyle(color: fontGrey),
                                              )),
                                        ),
                                        10.widthBox,
                                        Expanded(
                                          // button for dialog box
                                          child: customElevatedButton(
                                              onPressed: () {
                                                checkOutSheet(cartData[0],productDataParam,context,() async {

                                                 await ordersController.addOrder(
                                                      productDataIdForOrders,
                                                      cartData[0],
                                                      currentUser!.uid,
                                                     double.tryParse(totalAmountForOrders),
                                                    quantityDataForOrders,////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                  );
                                                 Get.to(()=> const OrderWaitingScreen());
                                                },);
                                              },
                                              color: redColor,
                                              fixedSize: const Size(130, 50),
                                              child: const Text(checkOutSt)),
                                        )
                                      ],
                                    ),
                                    /////////////
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
