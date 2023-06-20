import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/screens/admin_screens/admin_dishes/admin_add_dish.dart';
import 'package:e_commerce/screens/admin_screens/admin_dishes/admin_remove_dishes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/colors.dart';
import '../../../consts/images.dart';
import '../../../consts/strings.dart';
import '../../../consts/styles.dart';
import '../../../customs/custom_menu_container.dart';
import '../../../customs/custom_admin_orders_container.dart';
import '../../../customs/custom_elvated_button.dart';

class AdminDishes extends StatefulWidget {
  const AdminDishes({Key? key}) : super(key: key);

  @override
  _AdminDishesState createState() => _AdminDishesState();
}

class _AdminDishesState extends State<AdminDishes> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: myWhite,
        appBar: AppBar(
          backgroundColor: redColor,
          bottom: TabBar(
            indicatorColor: lightGrey,
            controller: tabController,
            tabs: const [
              Tab(text: 'Burgers'),
              Tab(text: 'Drinks'),
              Tab(text: 'Deserts'),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            buildCategoryListView(),
            buildCategoryListView(),
            buildCategoryListView(),
          ],
        ),
      );
  }

  Widget buildCategoryListView() {
    return Column(
      children: [
        Align(
          heightFactor: 1.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(yourDishesSt,
                  style: TextStyle(
                      fontFamily: bold, fontSize: 30, color: myBlack)),
              ImageIcon(AssetImage(icDishes),size: 45,color: myBlack,)
            ],
          ),
        ),
        10.heightBox,
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              20.heightBox,
              SizedBox(
                height: MediaQuery.of(context).size.height-370,
                // Set the  height for the ListView
                child: ListView.builder(
                  itemCount: 12,
                  // Replace with your actual item count
                  itemBuilder: (context, index) {
                    return menuContainer(
                        titleSt, discrSt, priceSt, itemsList[2],0,'no');
                  },
                ),
              ),
              20.heightBox,
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 22, bottom: 17, top: 8),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: customElevatedButton(
                            onPressed: () {Get.to(()=> RemoveDish());},
                            child: const Text(removeDishSt,style: TextStyle(color: redColor),),
                            fixedSize: const Size(140, 40),
                            color: myWhite,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 17, top: 8),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: customElevatedButton(
                            onPressed: () {Get.to(()=> AddDish());},
                            child: const Text(addDishSt),
                            fixedSize: const Size(140, 40),
                            color: redColor,
                          ),
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
    );
  }
}
