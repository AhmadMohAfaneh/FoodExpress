import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  
  Stream<List<CartModel>> getCartData(){
    var db = FirebaseFirestore.instance;
    return db.collection('carts').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((doc) => CartModel.fromFirestore(doc)).toList());
  }
  getQuantityPrice(singlePrice, quantity){
   var totalPrice = singlePrice + quantity;
    return totalPrice.toString();

  }


}