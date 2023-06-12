import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:get/get.dart';
import '../models/prducts_model.dart';
      class ProductController extends GetxController {
        var quantity = 0.obs;
       var totalPrice = 0.0.obs ;
        Stream<List<Product>> getProducts(){
          var db = FirebaseFirestore.instance;
          return db.collection('products').snapshots().map((querySnapshot) =>
             querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
        }

        void increaseQuantity(){
          if(quantity < 30){
            quantity ++;
          }
        }
        void decreaseQuantity(){
         if(quantity > 0){
           quantity--;
         }
        }
        getProductAddedTotalPrice({productPrice}){
          return totalPrice.value = productPrice * quantity.value.toDouble();
      }
      resetData(){
          quantity.value = 0;
          totalPrice.value = 0;
      }

      addToCart()async{


      }
      }
