import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/orders_controller.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/admin_screens/admin_orders/admin_orders_details/status_waiting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../consts/strings.dart';
import '../../../../customs/bg_widget.dart';
import '../../../../customs/custom_admin_orders_container.dart';
import '../../../../customs/custom_elvated_button.dart';
import '../../../../models/orders_model.dart';

class AdminOrdersDetails extends StatelessWidget {
  const AdminOrdersDetails({
    Key? key,
    required this.ordersData, required this.orderDataWithoutIndex,
  }) : super(key: key);
  final Orders ordersData;
  final List<Orders> orderDataWithoutIndex;

  @override
  Widget build(BuildContext context) {

    var orderController = Get.put(OrdersController());
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(yourOrdersSt,
                        style: TextStyle(
                            fontFamily: bold, fontSize: 26, color: myWhite)),
                    ImageIcon(
                      AssetImage(icAdminOrders),
                      size: 45,
                      color: myWhite,
                    )
                  ],
                ),
                50.heightBox,
                SizedBox(
                  height: MediaQuery.of(context).size.height - 290,
                  width: MediaQuery.of(context).size.width - 35,
                  child: Column(
                    children: [
                      Expanded(
                        child: Card(
                          color: myWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 1),
                          ),
                          child: FutureBuilder<DocumentSnapshot>(
                            future: orderController.getUserrDataForOrders(ordersData.userId),
                            builder: (context , snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              else if (snapshot.hasError ||
                                  snapshot.data!.isNull) {
                                return SingleChildScrollView(
                                  child: Center(
                                    child: Text(errorSt +
                                        snapshot.error.toString()),
                                  ),
                                );
                              }
                              else {
                                var userData = snapshot.data;
                                return Column(
                                  children: [
                                    35.heightBox,
                                    Column(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: regular),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: yourOrderFromSt
                                                      .substring(
                                                      5, 16),
                                                  style: const TextStyle(
                                                      color: myBlack,
                                                      fontFamily: brygadaVariable,
                                                      fontSize: 22)),
                                               TextSpan(
                                                  text: userData!['name'],
                                                  style: const TextStyle(
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
                                              fontSize: 22,
                                              fontFamily: brygadaVariable),
                                        ),
                                        5.heightBox,
                                        RichText(
                                          text:  TextSpan(
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
                                                  text: userData['phone number'],
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
                                          text:  TextSpan(
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
                                                  text: userData['address'],
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
                                    StreamBuilder<List<Product>>(
                                        stream: orderController
                                            .getProductDataFromOrderData(
                                            ordersData.products.map((product) =>
                                                product['p_id'].toString())
                                                .toList()),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          else if (snapshot.hasError ||
                                              snapshot.data!.isEmpty) {
                                            return Center(
                                              child: Text(errorSt +
                                                  snapshot.error.toString()),
                                            );
                                          }
                                          else {
                                            var productFromOrderData = snapshot
                                                .data!;
                                            return SizedBox(
                                              height: 250,
                                              child: ListView.builder(
                                                itemCount: ordersData.products.length,
                                                itemBuilder: (context, index) {
                                                  return adminContainer(
                                                    productFromOrderData[index].name,
                                                    productFromOrderData[index].description,
                                                    productFromOrderData[index].urlImage,
                                                    ordersData.products[index]['quantity'],
                                                  );
                                                },
                                              ),
                                            );
                                        }
                                        }
                                    ),
                                    20.heightBox,
                                       StreamBuilder<QuerySnapshot>(
                                         stream: orderController.getOrderStatus(ordersData.orderStatusId),
                                         builder: (context, snapshot) {
                                                if(snapshot.connectionState == ConnectionState.waiting){
                                                  return const Center(
                                                    child: CircularProgressIndicator(),
                                                  );
                                                }
                                                else if (snapshot.hasError){
                                                 return Center(
                                                    child: Text(errorSt +
                                                        snapshot.error.toString()),
                                                  );
                                                }
                                                else{
                                           var statusData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                                           return Column(
                                            children: [
                                             if (statusData['status_name']  == 'Pending') Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                        onPressed: () {
                                                          orderController.updateOrderStatus(ordersData.orderStatusId, 'Rejected');
                                                        },
                                                        child: const Text(
                                                          "Reject",
                                                          style: TextStyle(
                                                              color: redColor),
                                                        ),
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
                                                        onPressed: () {
                                                           orderController.updateOrderStatus(ordersData.orderStatusId , 'Accepted');
                                                        },
                                                        child: const Text("Accept "),
                                                        fixedSize: const Size(
                                                            120, 40),
                                                        color: redColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                           )
                                             else if(
                                                statusData['status_name'] == 'Accepted')
                                               Align(
                                                 alignment: Alignment
                                                     .center,
                                                 child: customElevatedButton(
                                                   onPressed: () {
                                                     orderController.updateOrderStatus(ordersData.orderStatusId, 'Great news! \n Your order has been completed and is now on its way to you. \n We appreciate your patience and hope you enjoy your meal!');
                                                   },
                                                   child: const Text(
                                                     "Completed",
                                                     style: TextStyle(
                                                         color: whiteColor),
                                                   ),
                                                   fixedSize: const Size(
                                                       120, 40),
                                                   color: redColor,
                                                 ),
                                               )
                                               else if((statusData['status_name'] == 'Great news! \n Your order has been completed and is now on its way to you. \n We appreciate your patience and hope you enjoy your meal!'))
                                                 Align(
                                                   alignment: Alignment
                                                       .center,
                                                   child: customElevatedButton(
                                                     onPressed: () {
                                                       // orderController.ratingBoolean.value == true;
                                                       orderController.updateOrderStatus(ordersData.orderStatusId, 'Arrived');
                                                     },
                                                     child: const Text(
                                                       "Finish Order",
                                                       style: TextStyle(
                                                           color: whiteColor),
                                                     ),
                                                     fixedSize: const Size(
                                                         120, 40),
                                                     color: redColor,
                                                   ),
                                                 )

                                              else if(statusData['status_name'] == 'Rejected')
                                               const Text("Rejected",
                                                 style:TextStyle(
                                                   color: redColor,
                                                   fontSize: 22
                                               ),
                                               ),
                                                ],
                                            );
                                           }
                                         }
                                       ),
                                  ],
                                );
                              }
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                15.heightBox
              ],
            )));
  }
}
