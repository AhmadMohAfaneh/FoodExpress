import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:get/get.dart';

import '../consts/firebase_consts.dart';
import '../models/orders_model.dart';
import '../models/prducts_model.dart';

class OrdersController extends GetxController{
  addOrder(Product product, CartModel? cartData , userId,totalPrice, qunatity)async{
    var db = FirebaseFirestore.instance;
    var orderRef = db.collection('orders').doc();
    var orderDoc = orderRef.get();
    var statusRef = db.collection('status').doc();
    var statusDoc = statusRef.get();
   await  statusRef.set({
      'status_id ' : statusRef.id,
      'status_name': 'Pending'
    });
   print("here is the cart data id ddddddddddddddddddddddddddddddddddd");
     print(cartData?.cartId);
    //create order
   await orderRef.set({
      'order_Id' : orderRef.id,
      'user_Id' : userId,
      'total_price': totalPrice,
      'date': DateTime.now(),
      'product_ids' : cartData!.products,
      'order_status_id' : statusRef.id
    });
   CartController cartController = CartController();
   cartController.deleteCart(cartData.cartId);
  }

  Stream<List<Orders>> getAllUserOrdersData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('orders')
        .snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => Orders.fromFirestore(doc))
            .toList());

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastOrderData() {
    final String userId = auth.currentUser!.uid;
    print("the current user is ");
    print(auth.currentUser!.uid);
    var db = FirebaseFirestore.instance;
    return db
        .collection('orders')
        .where('user_Id', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots();

  }
  
  Stream<List<Product>>getProductDataFromOrderData(orderProductsArray){
    var db = FirebaseFirestore.instance;
   return db.collection('products').where('p_id' , whereNotIn:  orderProductsArray).snapshots().
    map((querySnapshot) => querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
    
  }
  
  
  
  Stream getOrderData(statusId){
    var db = FirebaseFirestore.instance;
   return db.collection('orders').where('user_Id' , isEqualTo: statusId).snapshots();
    
  }

  getOrderStatus(statusId){
    var db = FirebaseFirestore.instance;
    return db.collection('status').where('status_id' , isEqualTo: statusId).snapshots();
  }
  getUserrDataForOrders(userId){
    var db = FirebaseFirestore.instance;
    return db.collection('users').where('id', isEqualTo: userId).snapshots();
    
  }





}