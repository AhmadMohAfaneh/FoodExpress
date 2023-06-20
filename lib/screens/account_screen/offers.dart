import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:e_commerce/customs/offers_container.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../consts/colors.dart';
import '../../consts/strings.dart';
import '../../consts/styles.dart';
import '../../models/prducts_model.dart';
import '../home_screen/menu/products.dart';

class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder <List<Product>>(
          stream: FirestoreServices.getProductsHaveOffers(),
          builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting){
               return const CircularProgressIndicator();
                 }
            else if(snapshot.hasError){
            return Text(errorSt + snapshot.error.toString());
            }
             else
            {
              var offerData = snapshot.data;
              return offerData!.isEmpty ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  40.heightBox,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 140,
                      child: Column(
                        children:  [
                          Image.asset(imgWrittenLogo,width: MediaQuery.of(context).size.width-150),
                          const Text(enjoyOfferSt,style: TextStyle(fontSize: 22,color: myWhite))
                        ],
                      ),
                    ),
                  ),
                  50.heightBox,
                  const Text(noOfferFoundSt,style: TextStyle(color: myBlack,fontSize: 22),),
                ],
              )

              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  40.heightBox,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 140,
                      child: Column(
                        children:  [
                          Image.asset(imgWrittenLogo,width: MediaQuery.of(context).size.width-150),
                          const Text(enjoyOfferSt,style: TextStyle(fontSize: 22,color: myWhite))
                        ],
                      ),
                    ),
                  ),
                  15.heightBox,

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(offersTitleSt,
                              style: TextStyle(
                                  fontFamily: semibold, fontSize: 18),),
                            10.widthBox,
                            const ImageIcon(AssetImage(icBestOffer)),
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
                        itemCount: offerData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Get.to(( Products(productsDada: offerData[index],))),
                            child: Container(

                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.6, style: BorderStyle
                                      .none),),
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    // offers data container is add data from firestore
                                    child: offersContainer (
                                      offerData[index].name,
                                      offerData[index].description,
                                      offerData[index].price.toStringAsFixed(2),
                                      offerData[index].urlImage,
                                      productController.calculateDiscountedPrice(offerData[index].price.toDouble(), offerData[index].productDiscountRate.toDouble()).toStringAsFixed(2),
                                    )
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        ),
      ),
    );
  }
}
