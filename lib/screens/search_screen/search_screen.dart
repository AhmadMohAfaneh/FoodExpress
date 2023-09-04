import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/controllers/search_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/auth_screen/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../customs/custom_menu_container.dart';
import '../home_screen/menu/products.dart';
import 'package:e_commerce/controllers/search_controller.dart' as mySearchController;


class SearchScreen extends StatelessWidget {
const SearchScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
var productController = Get.put(ProductController());
return Scaffold(
backgroundColor: whiteColor,
body: GetBuilder<mySearchController.SearchController>(
init: mySearchController.SearchController(),
builder: (searchController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextField(
                              onChanged: (value) {
                                searchController.update();
                              },
                              controller: searchController.searchTextController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: myBlack, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIconColor: myBlack,
                                  filled: true,
                                  hoverColor: myWhite,
                                  focusColor: myWhite,
                                  isDense: true,
                                  fillColor: myWhite,
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.search,
                                        size: 30,
                                      )),
                                  hintText: searchHint,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)))),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .where('search_keys',
                                    arrayContains: searchController
                                        .searchTextController.text)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError ||
                                      snapshot.data == null) {
                                    return Center(
                                      child:
                                      Text(errorSt + snapshot.error.toString()),
                                    );
                                  } else {
                                    var productsAsSearched = snapshot.data;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: productsAsSearched?.docs.length,
                                      itemBuilder: (BuildContext context, index) {
                                        return GestureDetector(
                                          onTap: () => Get.to(Products(
                                            productsDada: Product(
                                              name: productsAsSearched.docs[index]
                                                  .data()['p_name'],
                                              price: productsAsSearched.docs[index]
                                                  .data()['p_price'],
                                              description: productsAsSearched
                                                  .docs[index]
                                                  .data()['p_description'],
                                              urlImage: productsAsSearched.docs[index]
                                                  .data()['p_urlimage'],
                                              offer: productsAsSearched.docs[index]
                                                  .data()['p_offer'],
                                              categoryId: productsAsSearched.docs[index]
                                                  .data()['category_id'],
                                              productId: productsAsSearched.docs[index]
                                                  .data()['p_id'],
                                              productDiscountRate:
                                              productsAsSearched.docs[index]
                                                  .data()['p_discount_rate'],
                                              rating: productsAsSearched.docs[index].data()['rating'],
                                              numberOfRating: productsAsSearched.docs[index]
                                                  .data()['number_of_rating'],),
                                          )),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.6,
                                                  style: BorderStyle.none),
                                            ),
                                            child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: menuContainer(
                                                    productsAsSearched!.docs[index]
                                                        .data()['p_name'],
                                                    productsAsSearched.docs[index]
                                                        .data()['p_description'],
                                                    productsAsSearched.docs[index]
                                                        .data()['p_price']
                                                        .toDouble()
                                                        .toString(),
                                                    productsAsSearched.docs[index]
                                                        .data()['p_urlimage'],
                                                    productController
                                                        .calculateDiscountedPrice(
                                                        productsAsSearched
                                                            .docs[index]
                                                            .data()['p_price']
                                                            .toDouble(),
                                                        productsAsSearched
                                                            .docs[index]
                                                            .data()[
                                                        'p_discount_rate']
                                                            .toDouble()),
                                                    productsAsSearched.docs[index]
                                                        .data()['p_offer'])),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }),
                          ),
                        ),
                        // Expanded(
                        //     child: StreamBuilder(
                        //       stream: FirebaseFirestore.instance
                        //           .collection('products')
                        //           .where('search_keys',
                        //           arrayContains: searchController
                        //               .searchTextController.text)
                        //           .snapshots(),
                        //       builder: (context, snapshot) {
                        //         if (snapshot.hasData) {
                        //           return ListView.builder(
                        //               itemCount:
                        //               snapshot.data?.docs.length,
                        //               itemBuilder: (context, index) {
                        //                 return Text(snapshot
                        //                     .data?.docs[index]
                        //                     .data()['p_name']);
                        //               });
                        //         }
                        //         return const SizedBox();
                        //       },
                        //     ))
                      ],
                    ))
              ],
            );
          }),
    );
  }
}