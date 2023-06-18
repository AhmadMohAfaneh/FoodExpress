

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/products_controller.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/screens/cart_screen/emptyCart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/prducts_model.dart';

class CartController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Stream<List<CartModel>> getCartData() {
    // get the uid of the currently logged in user
    final String userId = _auth.currentUser!.uid;
    // now use this userId to get the cart data
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('carts')
        .where('user_Id', isEqualTo: userId)
        .snapshots()
        .map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => CartModel.fromFirestore(doc))
            .toList());
  }

  Future<void> deleteCart(String cartId){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('carts').doc(cartId).delete();
  }

  // Stream<List<CartModel>> getCartData(String currentUserId){
  //   var db = FirebaseFirestore.instance;
  //   return db.collection('carts').where('user_Id', isEqualTo: currentUserId).snapshots().map((querySnapshot) =>
  //       querySnapshot.docs.map((doc) => CartModel.fromFirestore(doc)).toList());

  getQuantityPrice(singlePrice, quantity){
   var totalPrice = singlePrice * quantity;
    return totalPrice.toString();
  }

  Future<void> removeCartOrder(String cartId, String productId) async {
    print("remove func is started");
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch the cart
    DocumentSnapshot cartDoc = await firestore.collection('carts').doc(cartId).get();
    CartModel cart = CartModel.fromFirestore(cartDoc);
    DocumentSnapshot productDoc = await firestore.collection('products').doc(productId).get();
    Product product = Product.fromFirestore(productDoc);

    // Find the product in the cart's product list
    var productInCart = cart.products.firstWhere((product) => product['p_id'] == productId, orElse: () => {});
    if (productInCart.isNotEmpty) {
      // Calculate the price of the product being removed
       double? productPrice = product.price.toDouble();
       // productInCart['price']?.toDouble();
      int quantity = productInCart['quantity'];
      if (productPrice != null) {
        double removedProductPrice = productPrice * quantity;

        // Remove the product from the cart's product list
        cart.products.removeWhere((product) => product['p_id'] == productId);

        // Calculate the new total price
        double newTotalPrice = cart.totalPrice - removedProductPrice;

        // Update the cart in Firestore
        return firestore.collection('carts').doc(cartId).update({
          'product_ids': cart.products,
          'total_price': newTotalPrice,
        });
      }
    }
  }

  double calculateTaxes(cartTotal){
    double salesTax = cartTotal * salesTaxRate;
     return salesTax;
  }


}