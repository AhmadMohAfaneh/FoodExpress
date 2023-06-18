import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:flutter/material.dart';


class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 50, right: 20, left: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              30.heightBox,
                              Card(
                                //    card is used for the msin custom pae
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        // padding for scren and border
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    //                                                               orderStatusSt
                                                    orderStatusSt,
                                                    style: TextStyle(
                                                        fontFamily: regular,
                                                        fontSize: 17,
                                                        color: fontGrey),
                                                  ),
                                                  145.widthBox,
                                                  const Text(
                                                    //                                                               orderStatusAcceptedSt
                                                    orderStatusAcceptedST,
                                                    style: TextStyle(
                                                        fontFamily: regular,
                                                        fontSize: 17,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    //                                                               orderSt
                                                    ordersSt,
                                                    style: TextStyle(
                                                      fontFamily: bold,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  190.widthBox,
                                                  const Text(
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    5.heightBox,
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: const [
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: 120),
                                              //                                                               titleSt
                                              child: Text(
                                                titleSt,
                                                style: TextStyle(
                                                  fontFamily: regular,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: 40),
                                              child: Text(
                                                //                                                               StpriceSt
                                                priceSt,
                                                style: TextStyle(
                                                    fontFamily: regular,
                                                    fontSize: 15,
                                                    color: redColor),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: const [
                                          Text(
                                            //                                                               totalPrice
                                            totalPriceSt,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            //                                                               priceSt
                                            priceSt,
                                            style: TextStyle(
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
              ),
            )
        )
    );
  }
}
