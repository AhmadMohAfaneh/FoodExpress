import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/orders_controller.dart';
import 'package:e_commerce/customs/custom_admin_orders_container.dart';
import 'package:e_commerce/screens/admin_screens/admin_orders/admin_orders_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../consts/colors.dart';
import '../../../consts/strings.dart';
import '../../../customs/bg_widget.dart';
import '../../../customs/custom_elvated_button.dart';
import '../../../models/orders_model.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderController = Get.put(OrdersController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<List<Orders>>(
          stream: orderController.getAllUserOrdersData(),
          builder: (context, snapshot) {
            print('This is the order admin dataaaaaaaaaaaaaaaaaaaaa');
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(
                child: Text(errorSt + snapshot.error.toString()),
              );
            }
            else {
              var ordersData = snapshot.data;

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(yourOrdersSt,
                            style: TextStyle(
                                fontFamily: bold,
                                fontSize: 30,
                                color: myWhite)),
                        ImageIcon(AssetImage(icAdminOrders), size: 45,
                          color: myWhite,)
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 250,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 30,
                      child: ListView.builder(
                        itemCount: ordersData!.length,
                        itemBuilder: (context, index) {
                        return SingleChildScrollView(
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
                                      50.heightBox,
                                      Align(
                                        widthFactor: 3.6,
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text:  TextSpan(
                                            text: orderForIdSt,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: regular,
                                                fontWeight: FontWeight.bold
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ordersData[index].orderId,
                                                // change to order id
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      5.heightBox,
                                      SizedBox(
                                        height: 250,
                                        //////////////////////////////////////////////////////////////here get the data of the orders
                                        child: ListView.builder(
                                          itemCount: ordersData[index].products.length,
                                          itemBuilder: (context, index) {
                                            return adminContainer(
                                                titleSt, discrSt, priceSt,
                                                itemsList[1], 2);
                                          },
                                        ),
                                      ),
                                      20.heightBox,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          const Text(seeMoreDetailsSt,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: fontGrey),),
                                          70.widthBox,
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment
                                                    .centerRight,
                                                child: customElevatedButton(
                                                  onPressed: () {
                                                    Get
                                                        .to(() => const AdminOrdersDetails());
                                                  },
                                                  child: const Text(detailsSt),
                                                  fixedSize: const Size(90, 40),
                                                  color: redColor,
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
                          );
                        }
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        ),
      ),
    );
  }
}
