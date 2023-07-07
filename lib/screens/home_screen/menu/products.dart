import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/home_screen/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../consts/strings.dart';


class Products extends StatelessWidget {
  final Product? productsDada;
  const Products({Key? key,  this.productsDada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsController = Get.put(ProductController());
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            productsController.resetData();
            Get.back();
          },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: deviceHeight * 0.05),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: deviceHeight * 0.3,
                  width: deviceWidth * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38),
                    color: Vx.white,
                  ),
                  child: SizedBox(
                    height: deviceHeight * 0.2,
                    width: deviceWidth * 0.35,
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
                          child: Image.network(productsDada!.urlImage, fit: BoxFit.fill,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: deviceHeight * 0.02),
              Column(
                children:  [
                  Text(productsDada!.name, style: const TextStyle(
                    fontFamily: bold, fontSize: 22, color: myBlack,)
                    ,),
                  SizedBox(height: deviceHeight * 0.01),
                  Container(margin: EdgeInsets.only(left: deviceWidth * 0.05, right: deviceWidth * 0.05), child: Text(productsDada!.description, style: const TextStyle(fontFamily: regular, fontSize: 18), textAlign: TextAlign.center,)),
                  SizedBox(height: deviceHeight * 0.01),
                  Obx(()=>
                      Text(priceSt + productsController.totalPrice.value.toStringAsFixed(2), style: const TextStyle(fontSize: 19,
                          fontFamily: orgenao,
                          color: redColor,
                          fontWeight: FontWeight.bold
                      )
                      ),
                  ),
                  SizedBox(height: deviceHeight * 0.02),
                  Container(
                    height: deviceHeight * 0.06,
                    width: deviceWidth * 0.5,
                    decoration:  BoxDecoration(
                        border: Border.all(width: 0.3,),
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Obx( () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){
                          productsController.decreaseQuantity();
                          productsController.getProductAddedTotalPrice(product: productsDada!);
                        }, icon: const ImageIcon(AssetImage(icMinus))),
                        Text(productsController.quantity.value.toString(),style: const TextStyle(fontSize: 30,fontFamily: bold),),
                        IconButton(onPressed: (){
                          productsController.increaseQuantity();
                          productsController.getProductAddedTotalPrice(product: productsDada!);
                        }, icon: const ImageIcon(AssetImage(icPlus),color: redColor,))
                      ],
                    ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  ElevatedButton(
                      onPressed: () {
                        productsController.addToCart(productsDada!, currentUser!.uid,context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: redColor,
                          fixedSize: Size(deviceWidth * 0.85, deviceHeight * 0.07),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Text(addToCartSt,style:
                          TextStyle(fontSize: 18,fontFamily: regular),),
                          SizedBox(width: deviceWidth * 0.03),
                        ],
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
