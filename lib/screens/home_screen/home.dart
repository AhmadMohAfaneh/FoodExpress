import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/category_controller.dart';
import 'package:e_commerce/controllers/home_controller.dart';
import 'package:e_commerce/controllers/notefication_controller.dart';
import 'package:e_commerce/customs/custom_elvated_button.dart';
import 'package:e_commerce/customs/home_menu.dart';
import 'package:e_commerce/models/prducts_model.dart';
import 'package:e_commerce/screens/home_screen/menu/menu.dart';
import 'package:e_commerce/screens/home_screen/menu/products.dart';
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
    var notificationController = Get.put(NotificationController());
    notificationController.onInit();
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
                    child: FutureBuilder<List<Product>>(
                      future: ordersController.getTopRatedProducts(),
                      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 60,
                                    width: 110,
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to( Products(productsDada: snapshot.data![index]));
                                      },
                                      child: Image.network(
                                        snapshot.data![index].urlImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
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

                            // //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            return FutureBuilder<DocumentSnapshot>(
                                future: ordersController.getUserrDataForOrders(lastOrderData['user_Id']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                else if (snapshot.hasError ||
                                    snapshot.data!.isNull) {
                                  return Center(
                                    child: Text(errorSt +
                                        snapshot.error.toString()),
                                  );
                                }
                                else {
                                  var userData = snapshot.data;
                                  return statusData['status_name'] !=
                                      "Order is finished" ? Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        ordersController
                                            .toggleOrderDetailsVisible();
                                      },
                                      child: Obx(() =>
                                          AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                              height: ordersController
                                                  .isOrderDetailsVisible.value
                                                  ? 400
                                                  : 60,
                                              color: ordersController
                                                  .isOrderDetailsVisible.value
                                                  ? Colors.grey[300]!
                                                  .withOpacity(1)
                                                  : Colors.grey[300]!
                                                  .withOpacity(0.7),
                                              padding: const EdgeInsets.all(16),
                                              child: ordersController
                                                  .isOrderDetailsVisible.value ?

                                              SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    RichText(
                                                      textAlign: TextAlign
                                                          .center,
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
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                        visible: ordersController
                                                            .isOrderDetailsVisible
                                                            .value,
                                                        child: statusData['status_name'] ==
                                                            'Great news! \n Your order has been completed and is now on its way to you. \n We appreciate your patience and hope you enjoy your meal!'
                                                            ?
                                                        Column(
                                                          children: [
                                                            RichText(
                                                                textAlign: TextAlign
                                                                    .center,
                                                                text: TextSpan(
                                                                    children: <
                                                                        TextSpan>[
                                                                      TextSpan(
                                                                        text: statusData['status_name']
                                                                            .toString()
                                                                            .substring(0, 11),
                                                                        style: const TextStyle(
                                                                            backgroundColor: redColor,
                                                                            color: myWhite,
                                                                            fontFamily: regular,
                                                                            fontWeight: FontWeight
                                                                                .bold, fontSize: 20
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                          text: statusData['status_name']
                                                                              .toString()
                                                                              .substring(11),
                                                                          style: const TextStyle(
                                                                            color: myBlack,

                                                                          )
                                                                      )

                                                                    ]
                                                                )),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  60, 30, 60, 60),
                                                              child: AspectRatio(
                                                                aspectRatio: 15 / 14,
                                                                child: Image
                                                                    .asset(
                                                                  icFoodDelivery,
                                                                  fit: BoxFit.fill,),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            : statusData['status_name'] ==
                                                            'Accepted' ?
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              "Order In Progress",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: myWhite,
                                                                  backgroundColor: myBlack
                                                              ),),

                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  60, 30, 60,
                                                                  60),
                                                              child: AspectRatio(
                                                                aspectRatio: 15 /
                                                                    14,
                                                                child: Image
                                                                    .asset(
                                                                  icApproved,
                                                                  fit: BoxFit
                                                                      .fill,),
                                                              ),
                                                            )
                                                            // Text(
                                                            //   statusData['status_name'],
                                                            //   style: const TextStyle(color: redColor,fontFamily: regular,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,
                                                            //   softWrap: true,
                                                            // ),
                                                          ],
                                                        )
                                                            : statusData['status_name'] ==
                                                            'Rejected' ?
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              "Oops! Your order was rejected",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: redColor,
                                                                  backgroundColor: myWhite
                                                              ),),

                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  60, 30, 60,
                                                                  60),
                                                              child: AspectRatio(
                                                                aspectRatio: 15 /
                                                                    14,
                                                                child: Image
                                                                    .asset(
                                                                  icRejected,
                                                                  fit: BoxFit
                                                                      .fill,),
                                                              ),
                                                            ),

                                                            customElevatedButton(onPressed: (){
                                                              ordersController.updateOrderStatus(lastOrderData['order_status_id'],"Order is finished",userData!['token'] ,"Thank you For Ordering From FoodExpress", "FoodExpress");
                                                            }, child: const Text("Finish Order",textAlign: TextAlign.center,style: TextStyle(color: myWhite,fontSize: 20)),
                                                                fixedSize: const Size(150, 60), color: redColor)
                                                            // Text(
                                                            //   statusData['status_name'],
                                                            //   style: const TextStyle(color: redColor,fontFamily: regular,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,
                                                            //   softWrap: true,
                                                            // ),
                                                          ],
                                                        )

                                                            : statusData['status_name'] ==
                                                            "Pending" ?
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              "Awaiting Confirmation",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: myWhite,
                                                                  backgroundColor: myBlack
                                                              ),),

                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  60, 30, 60,
                                                                  60),
                                                              child: AspectRatio(
                                                                aspectRatio: 15 /
                                                                    14,
                                                                child: Image
                                                                    .asset(
                                                                    icWaitingClock,
                                                                    fit: BoxFit
                                                                        .fill),
                                                              ),
                                                            )
                                                          ],
                                                        )

                                                            : statusData['status_name'] ==
                                                            'Arrived' ?
                                                        StreamBuilder<
                                                            List<Product>>(
                                                          stream: ordersController
                                                              .getProductDataFromOrderData(
                                                            lastOrderData['product_ids']
                                                                .map((
                                                                product) =>
                                                                product['p_id']
                                                                    .toString())
                                                                .toList(),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            } else if (snapshot
                                                                .hasError ||
                                                                snapshot.data!
                                                                    .isEmpty) {
                                                              return Center(
                                                                child: Text(
                                                                    errorSt +
                                                                        snapshot
                                                                            .error
                                                                            .toString()),
                                                              );
                                                            } else {
                                                              var productsData = snapshot
                                                                  .data;
                                                              return Column(
                                                                children: [
                                                                  const Text(
                                                                    'Great news',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily: regular,
                                                                        color: myWhite,
                                                                        backgroundColor: redColor,
                                                                        fontSize: 22
                                                                    ),),
                                                                  const Text(
                                                                    'Your Order has arrived',
                                                                    style: TextStyle(
                                                                        fontSize: 18
                                                                    ),),
                                                                  const Text(
                                                                    "Dont forget to Rate your order",
                                                                    style: TextStyle(
                                                                        fontSize: 18
                                                                    ),),
                                                                  // customElevatedButton(onPressed: (){
                                                                  // },
                                                                  //
                                                                  //     child: const Text("Rate your Order?"),
                                                                  //     fixedSize: const Size(150, 50), color: redColor),
                                                                  SizedBox(

                                                                    height: 250,

                                                                    child: ListView
                                                                        .builder(
                                                                        scrollDirection: Axis
                                                                            .vertical,
                                                                        shrinkWrap: true,
                                                                        itemCount: productsData!
                                                                            .length,
                                                                        itemBuilder: (
                                                                            context,
                                                                            index) {
                                                                          var product = productsData[index];
                                                                          var rating = ordersController
                                                                              .getRating(
                                                                              productsData[index]
                                                                                  .productId);
                                                                          return Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                    .spaceBetween,
                                                                                children: [
                                                                                  // padding for screen and border
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          left: 12),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .start,
                                                                                        children: [
                                                                                          Text(
                                                                                            productsData[index]
                                                                                                .name,
                                                                                            style: const TextStyle(
                                                                                                fontFamily: regular,
                                                                                                fontSize: 17,
                                                                                                fontWeight: FontWeight
                                                                                                    .bold),),
                                                                                          5.heightBox,
                                                                                          // here add the rate code
                                                                                          Obx(() =>
                                                                                              Row(
                                                                                                children: [
                                                                                                  GestureDetector(
                                                                                                      onTap: () async {
                                                                                                        rating.firstStarRating.value = !rating.firstStarRating.value;
                                                                                                        if (rating.firstStarRating.value) {await ordersController.ratingProduct(productsData[index].productId, 1);
                                                                                                        }
                                                                                                      },
                                                                                                      child: Icon(
                                                                                                        Icons.star,
                                                                                                        color: rating.firstStarRating.value ? Colors.yellow[900] : Colors.yellow[400],)),
                                                                                                  GestureDetector(
                                                                                                      onTap: () async {
                                                                                                        rating.secondStarRating.value = !rating.secondStarRating.value;
                                                                                                        if (rating.secondStarRating.value) {
                                                                                                          await ordersController.ratingProduct(productsData[index].productId, 2);
                                                                                                        }
                                                                                                      },
                                                                                                      child: Icon(
                                                                                                        Icons.star, color: rating.secondStarRating.value ? Colors.yellow[900] : Colors.yellow[400],)),
                                                                                                  GestureDetector(
                                                                                                      onTap: () async {
                                                                                                        rating.thirdStarRating.value = !rating.thirdStarRating.value;
                                                                                                        if (rating.thirdStarRating.value) {
                                                                                                          await ordersController.ratingProduct(productsData[index].productId, 3);
                                                                                                        }
                                                                                                      },
                                                                                                      child: Icon(
                                                                                                        Icons
                                                                                                            .star,
                                                                                                        color: rating.thirdStarRating.value ? Colors.yellow[900] : Colors.yellow[400],)),
                                                                                                  GestureDetector(
                                                                                                      onTap: () async {
                                                                                                        rating.fourthStarRating.value = !rating.fourthStarRating.value;
                                                                                                        if (rating.fourthStarRating.value) {
                                                                                                          await ordersController.ratingProduct(productsData[index].productId, 4);
                                                                                                        }
                                                                                                      },
                                                                                                      child: Icon(
                                                                                                        Icons.star, color: rating.fourthStarRating.value ? Colors.yellow[900] : Colors.yellow[400],)),
                                                                                                  GestureDetector(
                                                                                                      onTap: () async {
                                                                                                        rating
                                                                                                            .fifthStarRating.value = !rating.fifthStarRating.value;
                                                                                                        if (rating.fifthStarRating.value) {
                                                                                                          await ordersController
                                                                                                              .ratingProduct(productsData[index].productId, 5);
                                                                                                        }
                                                                                                      },
                                                                                                      child: Icon(
                                                                                                        Icons.star,
                                                                                                        color: rating.fifthStarRating.value ? Colors.yellow[900] : Colors.yellow[400],)),

                                                                                                ],
                                                                                              ),
                                                                                          )

                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 90,
                                                                                    width: 90,
                                                                                    child: Image
                                                                                        .network(
                                                                                        productsData[index]
                                                                                            .urlImage),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                                  ),
                                                                  customElevatedButton(
                                                                      onPressed: () {
                                                                        ordersController.updateOrderStatus(lastOrderData['order_status_id'],"Order is finished",userData!['token'] ,"Thank you For Ordering From FoodExpress", "FoodExpress");
                                                                      },
                                                                      child: const Text(
                                                                          'Finished?'),
                                                                      fixedSize: const Size(
                                                                          100, 60),
                                                                      color: redColor)
                                                                ],
                                                              );
                                                            }
                                                          },
                                                        )
                                                            : Column(
                                                          children: [
                                                            const Text(
                                                                "Your Orders status is"),
                                                            Text(
                                                              statusData['status_name'],
                                                              style: const TextStyle(
                                                                  color: myBlack,
                                                                  fontFamily: regular,
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  fontSize: 20),
                                                              textAlign: TextAlign
                                                                  .center,
                                                              softWrap: true,
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ) : const Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Tap for Order Status',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 10.0,
                                                        color: Colors.black,
                                                        offset: Offset(
                                                            5.0, 5.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ),
                                      ),
                                    ),
                                  ) : Column(
                                    children: [
                                      Container(),
                                    ],
                                  );
                                }
                              }
                            );
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