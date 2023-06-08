import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/custom_auth_button.dart';
import 'package:e_commerce/screens/cart_screen/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../consts/strings.dart';
import '../../../controllers/home_controller.dart';


class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int count = 0;
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
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
                        child: Image.asset(itemsImg, fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            15.heightBox,
            Column(
              children:  [
                const Text(titleSt, style: TextStyle(
                    fontFamily: bold, fontSize: 22, color: myBlack,)
                  ,),
                5.heightBox,
                const Text(discrSt,style: TextStyle(fontFamily: regular,fontSize: 18),),
                5.heightBox,
                const Text(priceSt, style: TextStyle(fontSize: 17,
                    fontFamily: orgenao,
                    color: redColor,
                    fontWeight: FontWeight.bold
                )
                ),
                15.heightBox,
                Container(
                  height: 50,
                  width: 170,
                  decoration:  BoxDecoration(
                    border: Border.all(width: 0.3,),
                    color: lightGrey,
                      borderRadius: BorderRadius.circular(18)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){}, icon: const ImageIcon(AssetImage(icMinus))),
                      Text(count.toString(),style: const TextStyle(fontSize: 30,fontFamily: bold),),
                      IconButton(onPressed: (){}, icon: const ImageIcon(AssetImage(icPlus),color: redColor,))
                    ],
                  ),
                ),
               40.heightBox,
               ElevatedButton(onPressed: () {},
                   style: ElevatedButton.styleFrom(
                     backgroundColor: redColor,
                     fixedSize: const Size( 340, 55),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(30)
                     )
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                 children:  [
                   const Text(addToCartSt,style:
                   TextStyle(fontSize: 18,fontFamily: regular),),
                   15.widthBox,
                   SizedBox(
                       height: 40,
                       width: 60,
                       child: Image.asset(cartIcon))
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
