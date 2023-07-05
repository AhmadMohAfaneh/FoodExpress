import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/orders_controller.dart';
import 'package:e_commerce/customs/custom_admin_orders_container.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/admin_screens/admin_orders/admin_orders_details/admin_orders_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../consts/strings.dart';
import '../../../customs/bg_widget.dart';
import '../../../customs/custom_elvated_button.dart';
import '../../../models/orders_model.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product? productsDataForDetails;
    var orderController = Get.put(OrdersController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<List<Orders>>(
          stream: orderController.getAllUserOrdersData(),
          builder: (context, snapshot) {
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
                        itemBuilder: (context, orderIndex) {
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: RichText(
                                            text:  TextSpan(
                                              text: orderForIdSt,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: regular,
                                                  fontWeight: FontWeight.bold
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: ordersData[orderIndex].orderId,
                                                  // change to order id
                                                  style: const TextStyle(
                                                    color: fontGrey,
                                                    fontSize: 15
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      5.heightBox,
                                      StreamBuilder<List<Product>>(
                                        stream: orderController.getProductDataFromOrderData(ordersData[orderIndex].products.map((product) => product['p_id'].toString()).toList()),
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

                                            var productFromOrderData = snapshot.data!;
                                            print(productFromOrderData);

                                            return SizedBox(
                                              height: 250,
                                              child: ListView.builder(
                                                itemCount: ordersData[orderIndex]
                                                    .products.length,
                                                itemBuilder: (context, index) {
                                                  productsDataForDetails = snapshot.data![index];
                                                  return adminContainer(
                                                      productFromOrderData[index]
                                                          .name, productFromOrderData[index].description,
                                                      productFromOrderData[index].urlImage, ordersData[orderIndex].products[index]['quantity']);
                                                },
                                              ),
                                            );
                                          }

                                        }
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
                                                    Get.to(() =>   AdminOrdersDetails(ordersData: ordersData[orderIndex],orderDataWithoutIndex: ordersData));
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
