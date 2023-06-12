import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
   final String cartId;
   final String userId;
   final num totalPrice;
   final Map<String, num> productId;

  CartModel({required this.cartId, required this.userId,
    required this.totalPrice, required this.productId});


  factory CartModel.fromFirestore(DocumentSnapshot doc){
    return CartModel(
      cartId : doc['cart_id'],
      userId : doc['userId'],
      totalPrice: doc['total_Price'],
      productId : doc[{'p_id','quantity'}]
    );
  }
}