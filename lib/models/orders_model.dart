import 'package:cloud_firestore/cloud_firestore.dart';
class Orders{
  final String orderId;
  final String userId;
  final DateTime date;
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

  //factory Product.fromFirestore(DocumentSnapshot doc) {
  //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  factory Orders.fromFirestore(DocumentSnapshot doc){
    List<Map<String, dynamic>> productList = [];
    for (var element in List.from(doc['product_ids'])) {
      productList.add({
        'p_id' : element['p_id'],
        'quantity': element['quantity'],
      });
    }
    return Orders(
      orderId: doc['order_id'],
      userId : doc['user_Id'],
      date : doc['order_date'],
      orderStatusId : doc['status_id'],
      totalPrice: doc['total_price'],
      products: productList,
    );
  }
}