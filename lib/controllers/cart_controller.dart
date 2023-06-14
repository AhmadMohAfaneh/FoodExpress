

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/screens/cart_screen/emptyCart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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

  // Future<void> removeCartOrder(String cartId, String productId) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // fetch the cart
  //   DocumentSnapshot doc = await firestore.collection('carts').doc(cartId).get();
  //   CartModel cart = CartModel.fromFirestore(doc);
  //
  //   // remove the product from the cart's product list
  //   cart.products.removeWhere((product) => product['p_id'] == productId);
  //
  //   // update the cart in firestore
  //   return firestore.collection('carts').doc(cartId).update({
  //     'product_ids': cart.products,
  //     'total_price': calculateTotalPrice(cart.products), // calculateTotalPrice needs to be implemented
  //   });
  // }

  // removeCartOrder(){
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   var cartDoc = CartModel.fromFirestore('product_Ids' as DocumentSnapshot<Object?>);
  //   firestore.collection('carts').doc(cartDoc as String?).delete();
  // }
}