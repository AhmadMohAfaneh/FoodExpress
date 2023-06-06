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
          children:   [
                const Align(
                  heightFactor: 10,
                  alignment: Alignment.center,
                  child: Text(
                    restNameSt,style: TextStyle(
                      fontFamily: bold, fontSize: 22, color: myWhite)
                  ),
                ),
            30.heightBox,
            customTextButton(
              onTap: () {
                Get.to(() => const AdminAccount());
              },
              text: accountSt,
              assetImage: const AssetImage(icAccount),
            ),
            10.heightBox,

            customTextButton(                                              // app dialop shows app informai
              onTap: () {
                Get.to(() => const AdminOrders());
              },
              text: ordersSt,
              assetImage: const AssetImage(icMyOrders),
            ),
            10.heightBox,

            customTextButton(                                              // app dialop shows app informai
              onTap: () {
                Get.to(() => AdminDishes());
              },
              text: dishesSt,
              assetImage: const AssetImage(icMenu),
            ),
            10.heightBox,
            customTextButton(
              onTap: () {
                Get.to(() => const Offers());
              },
              text: offersSt,
              assetImage: const AssetImage(icOffers),
            ),
            10.heightBox,

              ],
            ),
      ),
    );
  }
}
