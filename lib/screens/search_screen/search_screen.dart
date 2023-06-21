import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/controllers/search_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../customs/custom_menu_container.dart';
import '../home_screen/menu/products.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = Get.put(SearchController());
    var productController = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70), // here I replaced your heightBox
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width-40,
                child: StreamBuilder<List<Product>>(
                    stream: searchController.getProducts(),
                    builder: (context, snapshot) {
                      var products = snapshot.data;
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if (snapshot.hasError){
                        return Center(child: Text(errorSt + snapshot.error.toString()));
                      }
                      else {
                        searchController.dataFromStreamList.clear();
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          searchController.dataFromStreamList.add(snapshot
                              .data![i].name.toLowerCase());
                        }

                        return Column(
                          children: [
                            TextField(
                                onChanged: (value) {
                                  print(searchController.searchTextController.text);
                                  if(snapshot.hasData){searchController.checkingControllerWithList();
                                  searchController.filterdProductsName.clear();
                                  }
                                },
                                controller: searchController.searchTextController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    focusedBorder:  OutlineInputBorder(
                                      borderSide: const BorderSide(color: myBlack,width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIconColor: myBlack,
                                    filled: true,
                                    hoverColor: myWhite,
                                    focusColor: myWhite,
                                    isDense: true,
                                    fillColor: myWhite,
                                    suffixIcon: IconButton(onPressed: () {
                                    },
                                        icon: const Icon(Icons.search,size: 30,)),
                                    hintText: searchHint,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    )
                                )
                            ),
                            Expanded( // here I added Expanded
                              child: SingleChildScrollView(
                                child: StreamBuilder<List<Product>>(
                                    stream: searchController.getProductsAsSearched(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      else if (snapshot.hasError || snapshot.data!.isEmpty) {
                                        return Center(
                                          child: Text(errorSt +
                                              snapshot.error.toString()),
                                        );
                                      }
                                      else {
                                        var productsAsSearched = snapshot.data;
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: productsAsSearched?.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            print( "here is the name ${productsAsSearched![index]
                                                .name}");
                                            print("here is the price${productsAsSearched![index]
                                                .price}");
                                            print(productsAsSearched![index]
                                                .offer);
                                            print(productsAsSearched![index]
                                                .urlImage);
                                            print(productsAsSearched![index]
                                                .description);
                                            return GestureDetector(
                                              onTap: () => Get.to((Products(
                                                  productsDada: productsAsSearched[index]))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 0.6,
                                                      style: BorderStyle
                                                          .none),),
                                                child: Align(
                                                    alignment: Alignment
                                                        .bottomLeft,
                                                    child: menuContainer(
                                                        productsAsSearched![index]
                                                            .name,
                                                        productsAsSearched[index]
                                                            .description,
                                                        productsAsSearched[index]
                                                            .price.toDouble()
                                                            .toString(),
                                                        productsAsSearched[index]
                                                            .urlImage,
                                                        productController
                                                            .calculateDiscountedPrice(
                                                            productsAsSearched[index]
                                                                .price
                                                                .toDouble(),
                                                            productsAsSearched[index]
                                                                .productDiscountRate
                                                                .toDouble()),
                                                        productsAsSearched[index]
                                                            .offer
                                                    )
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } ),
                              ),
                            )
                          ],
                        );
                      }
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
