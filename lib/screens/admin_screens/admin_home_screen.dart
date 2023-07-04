import 'package:e_commerce/consts/colors.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/custom_text_button.dart';
import 'package:e_commerce/screens/admin_screens/admin_acount/admin_acount.dart';
import 'package:e_commerce/screens/admin_screens/admin_dishes/admin_dishes.dart';
import 'package:e_commerce/screens/admin_screens/admin_orders/admin_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../consts/styles.dart';
import '../account_screen/about_app.dart';
import '../account_screen/offers.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height/8,
                width: MediaQuery.of(context).size.width/1.5,
                child: Image.asset(imgWrittenLogo,fit: BoxFit.fill,)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/5.5,
                      width: MediaQuery.of(context).size.width/2.2,
                      child: LayoutBuilder(
                        builder: (BuildContext ctx, BoxConstraints constraints) {
                          return Column(
                            children: [
                              GestureDetector(
                                child: Card(
                                  color: lightRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: SizedBox(
                                      height: constraints.minHeight-30 ,
                                      width: constraints.maxWidth-15 ,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Image.asset(icAccountAvatar),
                                      )),
                                ),
                                onTap: () => Get.to(() => const AdminAccount()),
                              ),
                              const Text(accountSt,style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          );
                        },
                      )
                        ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/5.5,
                        width: MediaQuery.of(context).size.width/2.2,
                        child: LayoutBuilder(
                          builder: (BuildContext ctx, BoxConstraints constraints) {
                            return Column(
                              children: [
                                GestureDetector(
                                  child: Card(
                                    color: lightRed,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: SizedBox(
                                        height: constraints.maxHeight-30 ,
                                        width: constraints.maxWidth-15 ,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Image.asset(icClipboard,),
                                        )),
                                  ),
                                  onTap: () =>  Get.to(() => const AdminOrders())
                                ),
                                const Text(ordersSt,style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            );
                          },
                        )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height/5.5,
                        width: MediaQuery.of(context).size.width/2.2,
                        child: LayoutBuilder(
                          builder: (BuildContext ctx, BoxConstraints constraints) {
                            return Column(
                              children: [
                                GestureDetector(
                                  child: Card(
                                    color: lightRed,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: SizedBox(
                                        height: constraints.maxHeight-30 ,
                                        width: constraints.maxWidth-15 ,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Image.asset(icFoodDelivery,fit: BoxFit.contain,),
                                        )),
                                  ),
                                  onTap: () =>  Get.to(() => const AdminDishes()),
                                ),
                                const Text(dishesSt,style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            );
                          },
                        )
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/5.5,
                        width: MediaQuery.of(context).size.width/2.2,
                        child: LayoutBuilder(
                          builder: (BuildContext ctx, BoxConstraints constraints) {
                            return Column(
                              children: [
                                GestureDetector(
                                  child: Card(
                                    color: lightRed,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: SizedBox(
                                        height: constraints.maxHeight-30 ,
                                        width: constraints.maxWidth-15 ,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Image.asset(icAdminDiscount,fit: BoxFit.contain,),
                                        )),
                                  ),
                                  onTap: () => Get.to(() => const Offers()),
                                ),
                                const Text(offersSt,style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            );
                          },
                        )
                    ),
                  ],
                ),

                  ],
                ),
          ],
        ),

      )
    );
  }
}
