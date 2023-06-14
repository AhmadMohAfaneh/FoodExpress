
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/auth.controller.dart';
import 'package:e_commerce/controllers/category_controller.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/controllers/profile_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/custom_text_button.dart';
import 'package:e_commerce/screens/account_screen/about_app.dart';
import 'package:e_commerce/screens/account_screen/my_orders.dart';
import 'package:e_commerce/screens/account_screen/offers.dart';
import 'package:e_commerce/screens/account_screen/user_edit_profile.dart';
import 'package:e_commerce/screens/auth_screen/log_in_screen.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../consts/strings.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    var productsController = Get.put(ProductController());
    var categoryController = Get.find<CategoryController>();

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return const CircularProgressIndicator();
            }
              else{
                var data = snapshot.data!.docs[0];
                 // controller.nameController.text = data['name'];
                 // controller.addressController.text = data['address'];
                 // controller.phoneNumberController.text = data['phone number'];
               return Column(

            children: [

              165.heightBox,
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: myWhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      color: Vx.white,
                      elevation: 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                        data['imageUrl'] == '' ?
                        Image.asset(imgProfle, fit: BoxFit.cover,)
                            : Image.network(data['imageUrl'],fit: BoxFit.cover,)
                      ),
                    ),
                  ),
                ),
              ),
               Text("${data['name'].toString().capitalizeFirst}",style: const TextStyle(fontSize: 23,fontFamily: bold)),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset(icLocation,width: 26,height: 20,),
                   Text("${data["address"].toString().capitalizeFirst}",style: const TextStyle(fontSize: 17,fontFamily: regular),),
                 ],
               ),
              35.heightBox,
              customTextButton(
                onTap: () {
                 Get.to(() => const MyOrders());
                },
                text: myOrdersSt,
                assetImage: const AssetImage(icMyOrders),
              ),
              15.heightBox,

              customTextButton(
                onTap: () {
                  Get.to(() => const Offers());
                },
                text: offersSt,
                assetImage: const AssetImage(icOffers),
              ),
              15.heightBox,

              customTextButton(                                              // app dialop shows app informai
                onTap: () {
                    Get.to(() => const AboutApp());
                },
                text: aboutAppSt,
                assetImage: const AssetImage(icInfo),
              ),
              15.heightBox,

              customTextButton(                                              // app dialop shows app informai
                onTap: () {
                    Get.to(() => UserEditProfileScreen(data: data));
                },
                text: editProfileSt,
                assetImage: const AssetImage(icEditProfile),
              ),
              15.heightBox,
              customTextButton (                                              // app dialop shows app informai
                onTap : () async {

                await Get.put(AuthController()).signOut(context);

                  Get.offAll(() => const LogInPage());
                },
                text: signOutSt,
                assetImage: const AssetImage(icLogOut),
              ),
            ],
          );}},
        )
    ));
  }
}
