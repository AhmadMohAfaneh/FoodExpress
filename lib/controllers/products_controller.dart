import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/prducts_model.dart';
      class ProductController extends GetxController {
        Stream<List<Product>> getProducts(){
          var db = FirebaseFirestore.instance;
          return db.collection('products').snapshots().map((querySnapshot) =>
             querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
        }
      }
