import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../controllers/orders_controller.dart';
import '../../models/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    var ordersController = Get.put(OrdersController());
    var categoryController = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(homeSt),
      ),
      body: Container(
        color: lightGrey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  SizedBox(height: 30),
                  // Rest of your existing code
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.15,
                    child: VxSwiper.builder(
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 5),
                      enlargeCenterPage: true,
                      itemCount: offersList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width:MediaQuery.of(context).size.width*0.75,
                          child: Image.asset(
                            offersList[index],
                            fit: BoxFit.fill,
                            alignment: Alignment.topLeft,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      menuSt,
                      style: TextStyle(fontFamily: bold, fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 7),
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
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(), // Use ClampingScrollPhysics
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 1),
                                child: GestureDetector(
                                  onTap: () => Get.to(
                                    MenuPage(categoryData: categories[index]),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: SizedBox(
                                          height: 80,
                                          child: Image.network(
                                            categories[index].categoryUrlImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        categories[index].categoryName,
                                        style:  const TextStyle(
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.20,
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
                      style: TextStyle(fontFamily: bold, fontSize: 17),
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
                          padding:  EdgeInsets.fromLTRB(10, 10, 10, 5),
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
             StreamBuilder(
                  stream: ordersController.getLastOrderData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(errorSt + snapshot.error.toString()));
                    }
                    else if(snapshot.data!.docs.isEmpty){
                      return const Text("");
                    }else {
                      var lastOrderData = snapshot.data!.docs.first.data();
                      return StreamBuilder<QuerySnapshot>(
                        stream: ordersController.getOrderStatus(lastOrderData['order_status_id']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text(errorSt + snapshot.error.toString()));}
                           else if ( snapshot.data!.docs.isEmpty) {
                            return const Text("");
                          }
                           else {
                            var statusData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                            return statusData['status_name'] != "Order is finished" ?Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  ordersController.toggleOrderDetailsVisible();
                                },
                                child: Obx(() =>
                                    AnimatedContainer(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                        height: ordersController.isOrderDetailsVisible.value ? 400 : 60,
                                        color: ordersController.isOrderDetailsVisible.value ? Colors.grey[300]!.withOpacity(1) :Colors.grey[300]!.withOpacity(0.7),
                                        padding: const EdgeInsets.all(16),
                                        child: ordersController.isOrderDetailsVisible.value?

                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: regular,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: thanksStatment,
                                                      style: TextStyle(
                                                        color: myBlack,
                                                        fontFamily: brygadaVariable,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: restaurantNameSt,
                                                      style: TextStyle(
                                                        color: myBlack,
                                                        fontSize: 22,
                                                        fontFamily: regular,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: ordersController.isOrderDetailsVisible.value,
                                                child: statusData['status_name'] == 'Great news! \n Your order has been completed and is now on its way to you. \n We appreciate your patience and hope you enjoy your meal!' ?
                                               Column(
                                                 children: [
                                                   RichText(
                                                       textAlign: TextAlign.center,
                                                       text:TextSpan(
                                                     children: <TextSpan> [
                                                       TextSpan(
                                                         text:  statusData['status_name'].toString().substring(0,11),
                                                         style:const TextStyle(
                                                           backgroundColor: redColor,
                                                             color: myWhite,
                                                           fontFamily: regular,
                                                             fontWeight: FontWeight.bold,
                                                             fontSize: 20
                                                         ),
                                                       ),
                                                       TextSpan(
                                                         text: statusData['status_name'].toString().substring(11),
                                                         style: const TextStyle(
                                                           color: myBlack,

                                                         )
                                                       )

                                                     ]
                                                   )),
                                                   Padding(
                                                     padding: const EdgeInsets.fromLTRB(60, 30, 60, 60),
                                                     child: AspectRatio(
                                                       aspectRatio: 15/14,
                                                       child: Image.asset(icFoodDelivery,
                                                         fit: BoxFit.fill,),
                                                     ),
                                                   )
                                                 ],
                                               )
                                                    : statusData['status_name'] == 'Accepted' ?
                                                Column(
                                                  children: [
                                                    const Text("Order In Progress",style: TextStyle(
                                                        fontSize: 20,color: myWhite,backgroundColor: myBlack
                                                    ),),

                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(60, 30, 60, 60),
                                                      child: AspectRatio(
                                                        aspectRatio: 15/14,
                                                        child: Image.asset(icApproved,
                                                          fit: BoxFit.fill,),
                                                      ),
                                                    )
                                                    // Text(
                                                    //   statusData['status_name'],
                                                    //   style: const TextStyle(color: redColor,fontFamily: regular,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,
                                                    //   softWrap: true,
                                                    // ),
                                                  ],
                                                )
                                                    : statusData['status_name'] == 'Rejected' ?
                                                Column(
                                                  children: [
                                                    const Text("Oops! Your order was rejected",style: TextStyle(
                                                      fontSize: 18,color: redColor,backgroundColor: myWhite
                                                    ),),

                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(60, 30, 60, 60),
                                                      child: AspectRatio(
                                                        aspectRatio: 15/14,
                                                        child: Image.asset(icRejected,
                                                          fit: BoxFit.fill,),
                                                      ),
                                                    )
                                                    // Text(
                                                    //   statusData['status_name'],
                                                    //   style: const TextStyle(color: redColor,fontFamily: regular,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,
                                                    //   softWrap: true,
                                                    // ),
                                                  ],
                                                )

                                                : statusData['status_name'] == "Pending" ?
                                                Column(
                                                  children: [
                                                    const Text("Awaiting Confirmation",style: TextStyle(
                                                        fontSize: 18,color: myWhite,backgroundColor: myBlack
                                                    ),),

                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(60, 30, 60, 60),
                                                      child: AspectRatio(
                                                        aspectRatio: 15/14,
                                                        child: Image.asset(icWaitingClock,
                                                          fit: BoxFit.fill),
                                                      ),
                                                    )
                                                  ],
                                                )
                                                    : statusData['status_name'] == "Rating" ?
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:  [
                                                    GestureDetector(
                                                        onTap:(){
                                                          ordersController.firstStarRating.value != ordersController.firstStarRating.value;
                                                        } ,
                                                        child:  Icon(Icons.star,color: ordersController.firstStarRating.value ?Colors.yellow[900]:Colors.yellow[300],size: 20, )),

                                                  ],
                                                )


                                                :
                                                Column(
                                                  children: [
                                                    const Text("Your Orders status is"),
                                                    Text(
                                                      statusData['status_name'],
                                                      style: const TextStyle(color: myBlack,fontFamily: regular,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,
                                                      softWrap: true,
                                                    ),
                                                  ],
                                                )

                                              ),
                                            ],
                                          ),
                                        ) :const Align(
                                          alignment: Alignment.center,
                                          child: Text('Tap for Order Status',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10.0,
                                                  color: Colors.black,
                                                  offset: Offset(5.0, 5.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),

                                ),
                              ),
                            )  :Container();
                          }
                        },
                      );
                    }
                  },
                ),

          ],
        ),
      ),
    );
  }
}