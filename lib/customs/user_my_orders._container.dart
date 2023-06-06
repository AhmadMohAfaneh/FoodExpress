// import 'package:e_commerce/consts/consts.dart';
// import 'package:e_commerce/consts/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
//
// Widget myOrdersContainer(String title,String description,String price){
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//
//         Container(
//           decoration:  BoxDecoration(border: Border.all(width: 1,color: Vx.gray300)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // padding for scren and border
//               Padding(
//                 padding: const EdgeInsets.only(left: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                    Row(
//                      children:  [
//                        const Text(orderStatusSt,style: TextStyle(fontFamily: regular,fontSize: 17,color: fontGrey),),
//                        150.widthBox,
//                        const Text(orderStatusAcceptedST,style: TextStyle(fontFamily: regular,fontSize: 17,color: Colors.green),),
//                      ],
//                    ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(ordersSt,style: TextStyle(fontFamily: bold,fontSize: 17,),),
//                         190.widthBox,
//                         const Text(priceWordSt,style: TextStyle(fontFamily: regular,fontSize: 17,color: redColor),),
//                       ],
//                     ),
//                     Row(
//                       children:   [
//                         Text(title,style: const TextStyle(fontFamily: regular,fontSize: 17,),),
//                         125.widthBox,
//                         Text(price,style:  const TextStyle(fontFamily: regular,fontSize: 15,color: redColor),),
//                         25.widthBox,
//
//
//                       ],
//                     ),
//                     5.heightBox,
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }