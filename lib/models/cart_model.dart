import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String cartId;
  final String userId;
   num totalPrice = 0 ;
  final List<Map<String, dynamic>> products;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.totalPrice,
    required this.products,
  });

  factory CartModel.fromFirestore(DocumentSnapshot doc){
    List<Map<String, dynamic>> productList = [];
    for (var element in List.from(doc['product_ids'])) {
      productList.add({
        'p_id' : element['p_id'],
        'quantity': element['quantity'],
      });
    }
    return CartModel(
      cartId : doc['c_id'],
      userId : doc['user_Id'],
      totalPrice: doc['total_price'],
      products: productList,
    );
  }
}
