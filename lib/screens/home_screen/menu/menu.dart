import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/screens/home_screen/menu/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/strings.dart';
import '../../../customs/bg_widget.dart';
import '../../../customs/custom_menu_container.dart';


class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

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
                        child: Image.asset(imgBurgersMenu, fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            15.heightBox,
            Column(
              children: [
                 const Text(restNameSt, style: TextStyle(
                    fontFamily: bold, fontSize: 22, color: myBlack),),
                GestureDetector(
                    child: const Text(callUsSt, style: TextStyle(fontSize: 17,
                        fontFamily: orgenao,
                        color: redColor,
                        fontWeight: FontWeight.bold
                    )
                    )
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(dishesSt,
                    style: TextStyle(fontFamily: semibold, fontSize: 18),)),
            ),
            10.heightBox,
            Expanded(
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: itemsList.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.to((const Products())),
                      child: Container(

                          decoration: BoxDecoration(
                            border: Border.all(width: 0.6, style: BorderStyle
                                .none),),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: menuContainer(
                                  titleSt, discrSt, priceSt, itemsList[2]))),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


