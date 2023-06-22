import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:get/get.dart';

import '../models/prducts_model.dart';

class OrdersController extends GetxController{
  addOrder(Product product, CartModel? cartData , userId,totalPrice, qunatity)async{
    var db = FirebaseFirestore.instance;
    var orderRef = db.collection('orders').doc();
    var orderDoc = orderRef.get();
    //create order
   await orderRef.set({
      'order_Id' : orderRef.id,
      'user_Id' : userId,
      'total_price': totalPrice,
      'date': DateTime.now(),
      'product_ids' : [{
        'p_id' : product.productId,
        'quantity': cartData?.products[0]['quantity']
      }]
    });




  }





}