

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/notefication_controller.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/rating_model.dart';
import 'package:get/get.dart';

import '../consts/firebase_consts.dart';
import '../models/orders_model.dart';
import '../models/prducts_model.dart';
import '../models/products_rate.dart';

class OrdersController extends GetxController{
  NotificationController notificationController = NotificationController();
  RxMap<String, int> productRatings = <String, int>{}.obs;
  RxBool isOrderDetailsVisible = false.obs;
  RxBool orderStatus = true.obs;
  Map<String, double> productAverageRatings = {};

  // ProductRating getRating(String productId) {
  //   if (!productRatings.containsKey(productId)) {
  //     productRatings[productId] = ProductRating();
  //   }
  //   return productRatings[productId]!;
  // }


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
     print(cartData?.cartId);
    //create order
   await orderRef.set({
      'order_Id' : orderRef.id,
      'user_Id' : userId,
      'total_price': totalPrice,
      'date': DateTime.now(),
      'product_ids' : cartData!.products,
      'order_status_id' : statusRef.id
    }).then((value) => listenOrderStatus(statusRef.id));
   CartController cartController = CartController();
   cartController.deleteCart(cartData.cartId);
  }

  Stream<List<Orders>> getAllrOrdersData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('orders').orderBy('date',descending: true)
        .snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => Orders.fromFirestore(doc))
            .toList());

  }
  
  Stream<List<Orders>> getUserAllOrdersData(){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('orders').orderBy('date' , descending: true).where('user_Id', isEqualTo: auth.currentUser!.uid).snapshots().
    map((querySnapshot) => querySnapshot.docs.map((docs) => Orders.fromFirestore(docs)).toList());
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
  updateOrderStatus(statusId, statusName ,token,body,title){
    var db = FirebaseFirestore.instance;
    return db.collection('status').doc(statusId).
    update({
      'status_name' : statusName
    }).then((value) => orderStatus.value = true).then((value) => notificationController.sendPushMessage(token, body, title) );

  }

  Future<DocumentSnapshot> getUserrDataForOrders(String userId) async {
    var db = FirebaseFirestore.instance;
    return db.collection('users').doc(userId).get();
  }

  void toggleOrderDetailsVisible() {
    print(isOrderDetailsVisible.value);
    isOrderDetailsVisible.value = !isOrderDetailsVisible.value;
  }

  void listenOrderStatus(statusId) {
    getOrderStatus(statusId).listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var statusData = snapshot.docs.first.data() as Map<String, dynamic>;
        var statusName = statusData['status_name'];
      }
    });
  }

  Future<List<Rating>> getProductRating(String productId) async {
    var db = FirebaseFirestore.instance;
    try {
      var querySnapshot = await db.collection('rating').where('product_id', isEqualTo: productId).get();
      return querySnapshot.docs.map((doc) => Rating.fromFirestore(doc)).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  // this method is for rating products
  Future<void> ratingProduct({required String productId, int? ratingValue }) async {
    var db = FirebaseFirestore.instance;
    var docRef = db.collection('products').doc(productId);

    try {
      if (productRatings[productId] == null || productRatings[productId]! < ratingValue!) {
        await docRef.update({
          'number_of_rating': FieldValue.increment(1),
          'rating': FieldValue.increment(ratingValue as num),
        });
        productRatings[productId] = ratingValue!;
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<Product>> getTopRatedProducts() async {
    var db = FirebaseFirestore.instance;

    var productQuerySnapshot = await db.collection('products').get();
    var productList = productQuerySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();

    for (Product product in productList) {
      var averageRating =double.tryParse(product.rating.toString())??0.0;
      productAverageRatings[product.productId] = averageRating;
    }

    productList.sort((a, b) => productAverageRatings[b.productId]!.compareTo(productAverageRatings[a.productId]!));

    var topRatedProducts = productList.take(10).toList();

    return topRatedProducts;
  }


  Future<double> getAverageRating(String productId) async {
    var db = FirebaseFirestore.instance;
    try {
      var querySnapshot = await db.collection('rating').where('product_id', isEqualTo: productId).get();
      List<Rating> ratings = querySnapshot.docs.map((doc) => Rating.fromFirestore(doc)).toList();
      if (ratings.isEmpty) {
        return 0.0;
      }
      var sum = ratings.fold(0.0, (prev, curr) => prev + curr.ratingValue);
      return sum / ratings.length; // Average
    } catch (e) {
      print(e.toString());
      return 0.0;
    }
  }


}
class ProductAverageRating {
  double averageRating;

  ProductAverageRating({
    this.averageRating = 0.0
  });
}
