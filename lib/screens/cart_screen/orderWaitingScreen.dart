import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/orders_controller.dart';
import 'package:e_commerce/customs/orderWaitingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/colors.dart';
import '../../consts/strings.dart';
import '../../consts/styles.dart';
import '../../models/orders_model.dart';

class OrderWaitingScreen extends StatelessWidget {
  const OrderWaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ordersController = Get.put(OrdersController());
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: StreamBuilder(
            stream: ordersController.getLastOrderData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (snapshot.hasError) {
                print('order data ');
                print(snapshot.data);
                return Center(child: Text(errorSt + snapshot.error.toString()));
              }
              else {
                var lastOrderData = snapshot.data!.docs.first.data();
                print("the lastOrderData");
                print(lastOrderData);
                print(lastOrderData['order_status_id']);
                return  StreamBuilder <QuerySnapshot>(
                  stream: ordersController.getOrderStatus(lastOrderData['order_status_id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if (snapshot.hasError) {
                      print('order data ');
                      print(snapshot.data);
                      return Center(child: Text(errorSt + snapshot.error
                          .toString()));
                    }
                    else {
                      var statusData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                      print("status data is here");
                      print(statusData);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                  // order waiting screen                                                           yourOrderFromSt
                                  text: thanksStatment,
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
                          const Text('Waiting for a response'),
                          const Text("Your Orders status is"),
                           Text(statusData['status_name'],
                            style: TextStyle(color: redColor),),

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