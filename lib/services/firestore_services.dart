import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/category.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/prducts_model.dart';

class FirestoreServices {
  // to get the user data
  final FirebaseAuth auth = FirebaseAuth.instance;
  static getUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return firestore.collection(usersCollection)
        .where('id', isEqualTo: userId)
        .snapshots();
  }

  static Stream<List<Product>> getProductsByCat(String? categoryId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection('products')
        .where('category_id', isEqualTo: categoryId)
        .snapshots()
        .map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => Product.fromFirestore(doc))
            .toList());
  }
// creating methode to get the cart product data by the product id
   // creating method to get the cart product data by the product id
  static Stream<List<Product>> getProductsByCart(List<dynamic> cartProductIds){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('products').where('p_id' , whereIn: cartProductIds)
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }

}

