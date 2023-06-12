import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';
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

addToCart(Product product,userId,context) async {
  var db = FirebaseFirestore.instance;
  var cartRef = db.collection('carts').doc(userId);
  var cartDoc = await cartRef.get();

  if(quantity > 0 ){
  if (cartDoc.exists == false ) {
    // create new cart document
    await cartRef.set({
      'c_id': cartRef.id,
      'user_Id': userId,
      'total_price': product.price * quantity.value,
      'product_ids': [{
        'p_id': product.productId,
        'quantity': quantity.value,
      }]
    });
    VxToast.show(context, msg: "Item added successfully to your Cart ");
  } else {
    // update existing cart document
    var cart = CartModel.fromFirestore(cartDoc);

    // we search for the product if we dont find it return an empty map in the list of products
    var productInCart = cart.products.firstWhere((prod) => prod['p_id'] == product.productId, orElse: () => {});
    if (productInCart.isEmpty) {
      // add new product to cart
      cart.products.add({
        'p_id': product.productId,
        'quantity': quantity.value,
      });
    } else {
      // update the quantity for the product in the list
      productInCart['quantity'] += quantity.value;
    }

    // update the price also
    cart.totalPrice += product.price * quantity.value;

    await cartRef.update({
      'total_price': cart.totalPrice,
      'product_ids': cart.products,
    });
    VxToast.show(context, msg: "Item added successfully to your Cart ");
  }
  }
  else {
    VxToast.show(context, msg: "Nothing to add , add count of items");
  }

  resetData();
}}

