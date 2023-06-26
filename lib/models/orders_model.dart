import 'package:cloud_firestore/cloud_firestore.dart';
class Orders{
  final String orderId;
  final String userId;
  final Timestamp date;
  final  String orderStatusId;
  final List<Map<String, dynamic>> products;
  final num totalPrice;

  Orders({
    required this.orderId,
    required this.userId,
    required this.date,
    required this.orderStatusId,
      required this.products,
    required this.totalPrice});

  factory Orders.fromFirestore(DocumentSnapshot doc){
    List<Map<String, dynamic>> productList = [];
    for (var element in List.from(doc['product_ids'])) {
      productList.add({
        'p_id' : element['p_id'],
        'quantity': element['quantity'],
      });
    }
    return Orders(
      orderId: doc['order_Id'],
      userId : doc['user_Id'],
      date : doc['date'],
      orderStatusId : doc['order_status_id'],
      totalPrice: doc['total_price'],
      products: productList,
    );
  }
}