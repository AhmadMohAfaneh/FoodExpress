import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/home_screen/menu/products.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/strings.dart';
import '../../../customs/bg_widget.dart';
import '../../../customs/custom_menu_container.dart';
import '../../../models/category.model.dart';


class MenuPage extends StatelessWidget {
  final Category ?categoryData;
   const MenuPage({Key? key, this.categoryData}) : super(key: key);

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
                        child: Image.network(categoryData!.categoryUrlImage, fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            15.heightBox,
            Column(
              children: [
                 const Text(restaurantNameSt, style: TextStyle(
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
              child: StreamBuilder<List<Product>>(
                  stream: FirestoreServices.getProductsByCat(categoryData!.categoryId),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      var products = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Get.to(( Products(productsDada: products[index]))),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.6, style: BorderStyle.none),),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: menuContainer(products[index].name, products[index].description, products[index].price.toDouble().toString(), products[index].urlImage)
                              ),
                            ),
                          );
                        },
                      );
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else{
                      return Text("null${snapshot.error}");
                    }
                  }),
            ),

          ],
        ),
      ),
    );
  }
}


