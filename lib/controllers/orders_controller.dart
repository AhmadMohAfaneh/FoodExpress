import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:get/get.dart';

import '../consts/firebase_consts.dart';
import '../models/orders_model.dart';
import '../models/prducts_model.dart';

class OrdersController extends GetxController{
   RxBool orderStatus = false.obs;
 late RxString displayedStatus ;
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
    return firestore.collection('orders').orderBy('date',descending: true)
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
   return db.collection('products').where('p_id' , whereIn:   orderProductsArray).snapshots().
    map((querySnapshot) => querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
    
  }
  
  
  
  Stream getOrderData(statusId){
    var db = FirebaseFirestore.instance;

   return db.collection('orders').where('user_Id' , isEqualTo: statusId).snapshots();
    
  }

// here foucus on that the status_id have space after the id
  getOrderStatus(statusId){
    var db = FirebaseFirestore.instance;
    print('before function status ');
    print(statusId);
     return  db.collection('status').where('status_id ', isEqualTo: statusId).snapshots();
  }
  updateOrderStatus(statusId, statusName){
    var db = FirebaseFirestore.instance;
    return db.collection('status').doc(statusId).
    update({
      'status_name' : statusName
    }).then((value) => orderStatus.value = true);

  }

  Future<DocumentSnapshot> getUserrDataForOrders(String userId) async {
    var db = FirebaseFirestore.instance;
    return db.collection('users').doc(userId).get();
  }







}