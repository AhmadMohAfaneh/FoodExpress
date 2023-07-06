import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/home_controller.dart';
import 'package:e_commerce/screens/cart_screen/cart_screen.dart';
import 'package:e_commerce/screens/search_screen/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/strings.dart';
import '../account_screen/account_screen.dart';
import 'home.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("here we go ");
    }
    Get.find<AuthController>();
    var controller = Get.put(HomeController());
    var navbarItems = [
      BottomNavigationBarItem(icon: Image.asset(icHome,width:26), label: homeSt),
      BottomNavigationBarItem(icon: Image.asset(icCart,width:26), label: cartSt),
      BottomNavigationBarItem(icon: Image.asset(icSearch,width:26), label: searchSt),
      BottomNavigationBarItem(icon: Image.asset(icAccount,width:26), label: accountSt)
    ];
    var navBody = [
       const HomeScreen(),
        CartScreen(),
      const SearchScreen(),
      const AccountScreen(),
    ];
    return  Scaffold(
     body: Column(
       children: [
         Obx(
           () => Expanded(child: navBody.elementAt(controller.currentNavIndex.value),
           ),
         ),
       ],
     ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItems,
          onTap: (value) {

            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}

