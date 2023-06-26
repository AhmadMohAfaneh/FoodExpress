import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/orders_controller.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/strings.dart';
import '../../../customs/bg_widget.dart';
import '../../../customs/custom_admin_orders_container.dart';
import '../../../customs/custom_elvated_button.dart';
import '../../../models/orders_model.dart';

class AdminOrdersDetails extends StatelessWidget {
  const AdminOrdersDetails( {Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var orderController = Get.put(OrdersController());
    print('here it goes the product daaatat');
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<List<Orders>>(
          stream: orderController.getAllUserOrdersData(),
          builder: ( context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text(errorSt + snapshot.error.toString()),
              );
            }
            else {
              var orderData = snapshot.data;
              return StreamBuilder(
                stream: orderController.getUserrDataForOrders(orderData![2].userId),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Center(
                      child: Text(errorSt + snapshot.error.toString()),
                    );
                  }
                  else {
                    var userData = snapshot.data!.docs;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(yourOrdersSt,
                                style: TextStyle(
                                    fontFamily: bold,
                                    fontSize: 30,
                                    color: myWhite)),
                            ImageIcon(
                              AssetImage(icAdminOrders), size: 45,
                              color: myWhite,)
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height - 180,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 30,
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
                                      35.heightBox,
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20),
                                            child: Align(
                                              widthFactor: 3.14,
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: regular),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: yourOrderFromSt
                                                            .substring(5, 16),
                                                        style: const TextStyle(
                                                            color: myBlack,
                                                            fontFamily: brygadaVariable,
                                                            fontSize: 22)),
                                                    TextSpan(
                                                        text: userData[0]['name'],
                                                        style: const TextStyle(
                                                            color: myBlack,
                                                            fontSize: 22,
                                                            fontFamily: regular,
                                                            fontWeight: FontWeight
                                                                .bold)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          5.heightBox,
                                          const Text(
                                            orderDetSt, style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: brygadaVariable),),
                                          5.heightBox,
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: regular),
                                              children: <TextSpan>[
                                                const TextSpan(
                                                    text: hintPhoneNumber,
                                                    style: TextStyle(
                                                        color: myBlack,
                                                        fontFamily: brygadaVariable,
                                                        fontSize: 15)),
                                                TextSpan(
                                                    text: userData[0]['phone number'],
                                                    style: const TextStyle(
                                                        color: myBlack,
                                                        fontSize: 15,
                                                        fontFamily: regular,
                                                        fontWeight: FontWeight
                                                            .bold)),
                                              ],
                                            ),
                                          ),
                                          5.heightBox,
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: regular),
                                              children: <TextSpan>[
                                                const TextSpan(
                                                    text: locationSt,
                                                    style: TextStyle(
                                                        color: myBlack,
                                                        fontFamily: brygadaVariable,
                                                        fontSize: 15)),
                                                TextSpan(
                                                    text: userData[0]['address'],
                                                    style: const TextStyle(
                                                        color: myBlack,
                                                        fontSize: 15,
                                                        fontFamily: regular,
                                                        fontWeight: FontWeight
                                                            .bold)),
                                              ],
                                            ),
                                          ),
                                          10.heightBox,
                                        ],
                                      ),
                                      5.heightBox,
                                      SizedBox(
                                        height: 250,
                                        // Set the desired height for the ListView
                                        child: StreamBuilder<List<Product>>(
                                          stream: orderController.getProductDataFromOrderData(orderData[0].products.map((product) => product['p_id'].toString()).toList()),
                                          builder: (context, snapshot) {
                                            var productData = snapshot.data;
                                            return ListView.builder(
                                              itemCount: orderData.length,
                                              itemBuilder: (context, index) {
                                                return adminContainer(
                                                    productData![index].name,
                                                    productData[index].description,
                                                    productData[index].urlImage,
                                                    orderData[index]
                                                        .products[index]['quantity']
                                                        .toString());
                                              },
                                            );
                                          }
                                        ),
                                      ),
                                      20.heightBox,
                                      Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 22,
                                                    bottom: 17,
                                                    top: 8),
                                                child: Align(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child: customElevatedButton(
                                                    onPressed: () {},
                                                    child: const Text("Regect",
                                                      style: TextStyle(
                                                          color: redColor),),
                                                    fixedSize: const Size(
                                                        120, 40),
                                                    color: myWhite,
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 17, top: 8),
                                                child: Align(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child: customElevatedButton(
                                                    onPressed: () {},
                                                    child: const Text(
                                                        "Accept "),
                                                    fixedSize: const Size(
                                                        120, 40),
                                                    color: redColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              );
            }
          }
        ),
      ),
    );
  }
}
