import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/category_controller.dart';
import 'package:e_commerce/controllers/home_controller.dart';
import 'package:e_commerce/customs/home_menu.dart';
import 'package:e_commerce/screens/home_screen/menu/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    var categoryController = Get.put(CategoryController());
    return Container(
      color: lightGrey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            AspectRatio(
              aspectRatio: 30 / 12,
              child: VxSwiper.builder(
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 5),
                enlargeCenterPage: true,
                itemCount: offersList.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    offersList[index],
                    fit: BoxFit.fill,
                    alignment: Alignment.topLeft,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                menuSt,
                style: TextStyle(fontFamily: bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<List<Category>>(
              stream: categoryController.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('$errorSt ${snapshot.error}');
                } else {
                  var categories = snapshot.data!;
                  return Expanded(
                    // here is the problem the size gives runder flex error if i changed it to any thing more than 50
                      // Set a fixed height for the ListView
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(), // Use ClampingScrollPhysics
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: GestureDetector(
                            onTap: () => Get.to(
                              MenuPage(categoryData: categories[index]),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    height: 90,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Image.network(
                                        categories[index].categoryUrlImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  categories[index].categoryName,
                                  style: const TextStyle(
                                    fontFamily: semibold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            AspectRatio(
              aspectRatio: 30 / 12,
              child: VxSwiper.builder(
                autoPlay: false,
                enlargeCenterPage: false,
                itemCount: randomList.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      randomList[index],
                      fit: BoxFit.fill,
                      alignment: Alignment.topLeft,
                    ).marginSymmetric(horizontal: 5),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                topRatingSt,
                style: TextStyle(fontFamily: bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 115,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatingList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 60,
                        width: 110,
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
