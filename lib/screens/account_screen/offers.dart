import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/offers_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../consts/colors.dart';
import '../../consts/strings.dart';
import '../../consts/styles.dart';
import '../home_screen/menu/products.dart';

class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);

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
              child: SizedBox(
                height: 140,
                child:  Column(
                  children: const [
                    Text(restNameSt, style: TextStyle(
                        fontFamily: bold, fontSize: 22, color:myWhite),),

                  ],
                ),
              ),
            ),
            15.heightBox,

             Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                     const Text(offersTitleSt,
                        style: TextStyle(fontFamily: semibold, fontSize: 18),),
                      10.widthBox,
                     const  ImageIcon(AssetImage(icBestOffer)),
                    ],
                  )),
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
                  itemCount: itemsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.to(( Products())),
                      child: Container(

                          decoration: BoxDecoration(
                            border: Border.all(width: 0.6, style: BorderStyle
                                .none),),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                                                                                                                                   // offers data container is add data from firestore
                              child: offersContainer(titleSt, discrSt, priceSt, offersList[index]))),
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
