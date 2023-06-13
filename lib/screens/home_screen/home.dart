import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/category_controller.dart';
import 'package:e_commerce/controllers/home_controller.dart';
import 'package:e_commerce/customs/home_menu.dart';
import 'package:e_commerce/screens/home_screen/menu/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../models/category.model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Get.put(HomeController());
     var categoryController = Get.put(CategoryController());
    return SingleChildScrollView(
      child:  Container(
            color: lightGrey,
            width: context.screenWidth,
            height: context.screenHeight,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 5),
                    height: 160,
                    enlargeCenterPage: true,
                    itemCount: offersList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          offersList[index],
                          fit: BoxFit.fill,
                          alignment: Alignment.topLeft,
                        ),
                      );
                    },
                  ),
                  5.heightBox,
                  const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      menuSt,
                      style: TextStyle(fontFamily: bold, fontSize: 20),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<List<Category>>(
                        stream: categoryController.getCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('$errorSt ${snapshot.error}');
                          } else {
                            var categories = snapshot.data!;
                            return SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,

                                itemCount: categories.isEmpty ? 0 : categories
                                    .length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 5, 10, 5),
                                    child: GestureDetector(
                                      onTap: () => Get.to(MenuPage(categoryData: categories[index])),
                                      child: Container(
                                        child: homeMenu(
                                          categoryName: categories[index]
                                              .categoryName,
                                          menuImage: categories[index]
                                              .categoryUrlImage,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }),

                      Align(
                        alignment: Alignment.topCenter,
                        child: VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: false,
                          height: 150,
                          enlargeCenterPage: false,
                          itemCount: randomList.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  randomList[index],
                                  fit: BoxFit.fill,
                                  alignment: Alignment.topLeft,
                                ).marginSymmetric(horizontal: 5),
                              ),
                            );
                          },
                        ),
                      ),
                      10.heightBox,
                      const Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: Text(
                          topRatingSt,
                          style: TextStyle(fontFamily: bold, fontSize: 20),
                        ),
                      ),
                      5.heightBox,
                    ],
                  ),
                  SizedBox(
                    height: 135,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatingList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 90,
                              width: 140,
                              color: Colors.transparent,
                              child: Image.asset(
                                topRatingList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
      ),
    );
  }
}
