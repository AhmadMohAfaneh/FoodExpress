
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/auth.controller.dart';
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
import '../../consts/consts.dart';
import '../../consts/strings.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return const CircularProgressIndicator();
            }
              else{
                var data = snapshot.data!.docs[0];
               return Column(

            children: [
              140.heightBox,
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: myWhite,
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
                          borderRadius: BorderRadius.circular(100),
                        ),
                        color: Vx.white,
                        elevation: 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(imgProfilePic, fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
               Text("${data['name']}",style: const TextStyle(fontSize: 23,fontFamily: bold)),
               Text("$locationSt${data["address"]}",style: const TextStyle(fontSize: 14,fontFamily: regular),),
              30.heightBox,
              customTextButton(
                onTap: () {
                 Get.to(() => const MyOrders());
                },
                text: myOrdersSt,
                assetImage: const AssetImage(icMyOrders),
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

              customTextButton(                                              // app dialop shows app informai
                onTap: () {
                    Get.to(() => const AboutApp());
                },
                text: aboutAppSt,
                assetImage: const AssetImage(icInfo),
              ),
              10.heightBox,

              customTextButton(                                              // app dialop shows app informai
                onTap: () {
                    Get.to(() => UserEditProfileScreen(data: data));
                },
                text: editProfileSt,
                assetImage: const AssetImage(icEditProfile),
              ),
              10.heightBox,
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
