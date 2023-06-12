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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            45.heightBox,
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 240,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
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
                        child: Image.network(productsDada!.urlImage, fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            15.heightBox,
            Column(
              children:  [
                 Text(productsDada!.name, style: const TextStyle(
                    fontFamily: bold, fontSize: 22, color: myBlack,)
                  ,),
                5.heightBox,
                 Container(margin:const EdgeInsets.only(left: 20,right:10 ), child: Text(productsDada!.description,style: const TextStyle(fontFamily: regular,fontSize: 18),textAlign: TextAlign.center,)),
                5.heightBox,
                 Obx(()=>
                    Text(priceSt + productsController.totalPrice.value.toString(), style: const TextStyle(fontSize: 19,
                      fontFamily: orgenao,
                      color: redColor,
                      fontWeight: FontWeight.bold
                )
                ),
                 ),
                15.heightBox,
                Container(
                  height: 50,
                  width: 170,
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
                          productsController.getProductAddedTotalPrice(productPrice: productsDada!.price);
                        }, icon: const ImageIcon(AssetImage(icMinus))),
                        Text(productsController.quantity.value.toString(),style: const TextStyle(fontSize: 30,fontFamily: bold),),
                        IconButton(onPressed: (){
                          productsController.increaseQuantity();
                          productsController.getProductAddedTotalPrice(productPrice: productsDada!.price);
                        }, icon: const ImageIcon(AssetImage(icPlus),color: redColor,))
                      ],
                    ),
                  ),
                ),

               40.heightBox,
               ElevatedButton(onPressed: () {
                   productsController.addToCart(productsDada!, currentUser!.uid,context);
               },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: redColor,
                     fixedSize: const Size( 340, 55),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10)
                     )
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                 children:  [
                   const Text(addToCartSt,style:
                   TextStyle(fontSize: 18,fontFamily: regular),),
                   15.widthBox,
                 ],
               ))
              ],
            ),


          ],
        ),
      ),
    );
  }
}
