import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/screens/admin_screens/admin_acount/admin_edit_profile.dart';
import 'package:e_commerce/screens/admin_screens/admin_home_screen.dart';
import 'package:e_commerce/screens/auth_screen/log_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/strings.dart';
import '../../../consts/styles.dart';
import '../../../customs/bg_widget.dart';
import '../../../customs/custom_menu_container.dart';
import '../../../customs/custom_text_button.dart';
import '../../account_screen/about_app.dart';
import '../../home_screen/menu/products.dart';

class AdminAccount extends StatelessWidget {
 const  AdminAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.heightBox,
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 150,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Vx.white,
                ),
                child: SizedBox(
                  height: 140,
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Vx.white,
                      elevation: 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(imgChapati, fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            15.heightBox,
            Column(
              children:  [
                const Text(restNameSt, style: TextStyle(
                    fontFamily: bold, fontSize: 22, color: myBlack),),
                50.heightBox,
                customTextButton(
                  onTap: () {
                    // Get.to(() => AdminEditProfileScreen());
                  },
                  text: editProfileSt,
                  assetImage: const AssetImage(icAccount),
                ),
                20.heightBox,

                customTextButton(                                              // app dialop shows app informai
                  onTap: () {
                    Get.put(AuthController().signOut(context));
                    Get.offAll(const LogInPage());
                  },
                  text: signOutSt,
                  assetImage: const AssetImage(icMyOrders),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
