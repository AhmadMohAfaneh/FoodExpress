import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/cart_container.dart';
import 'package:e_commerce/screens/search_screen/search_screen.dart';
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
    return bgWidget(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 160,
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
                                  fontFamily: brygadaVariable, fontSize: 18),
                            ),
                            5.heightBox,
                            SizedBox(
                              height: 330, // Set the desired height for the ListView
                              child: ListView.builder(
                                itemCount: 4, // Replace with your actual item count
                                itemBuilder: (context, index) {
                                  return cartContainer(titleSt, discrSt, priceSt, itemsList[1]);
                                },
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration:  BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(5),bottom: Radius.circular(10)),
                              border: Border.all(width: 0.5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:  [
                                  const Text(totalPrice,style: TextStyle(fontSize: 20,fontFamily: regular,fontWeight: FontWeight.bold)),
                                 100.widthBox,
                                  const Text(priceSt,style: TextStyle(fontSize: 20,fontFamily: regular,color: redColor)),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: customElevatedButton(
                                  onPressed: () {},
                                  color: myWhite,
                                  fixedSize:const Size(170, 50),
                                  child:  const Text(cancelSt,style: TextStyle(color: fontGrey),)),
                            ),
                            customElevatedButton(
                                onPressed: () {},
                                color: Colors.red,
                                fixedSize:const Size(170, 50),
                                child: const  Text(checkOutSt))
                          ],
                        )
                    ],
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

