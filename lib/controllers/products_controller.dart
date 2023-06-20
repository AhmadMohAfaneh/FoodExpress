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
  getProductAddedTotalPrice({required Product product }){
    double priceToUse = product.offer.toLowerCase() == 'yes' ? calculateDiscountedPrice(product.price.toDouble(), product.productDiscountRate.toDouble()) : product.price.toDouble();
    return totalPrice.value = priceToUse * quantity.value.toDouble();
  }
  resetData(){
    quantity.value = 0;
    totalPrice.value = 0;
  }

  addToCart(Product product,userId,context) async {
    var db = FirebaseFirestore.instance;
    var cartRef = db.collection('carts').doc(userId);
    var cartDoc = await cartRef.get();
    double priceToUse = product.offer.toLowerCase() == 'yes' ? calculateDiscountedPrice(product.price.toDouble(), product.productDiscountRate.toDouble()) : product.price.toDouble();
    print(calculateDiscountedPrice(product.price.toDouble(), product.productDiscountRate.toDouble()));
    print(product.price.toDouble());
    print(priceToUse);
    if(quantity > 0 ){
      if (cartDoc.exists == false ) {
        // create new cart document
        await cartRef.set({
          'c_id': cartRef.id,
          'user_Id': userId,
          'total_price': priceToUse * quantity.value,
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
        cart.totalPrice += priceToUse * quantity.value;

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
  }
  double calculateDiscountedPrice(double originalPrice, double discountRate) {
   double discountedPrice = originalPrice - (originalPrice * discountRate);
    return double.tryParse(discountedPrice.toStringAsFixed(2)) ?? 0.0;
  }







  // getProductPriceAfterDiscount (originalPrice,discountRate,productId) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   double priceAfterDiscount;
  //   oldPrice.value = originalPrice;
  //   priceAfterDiscount = originalPrice -(originalPrice * discountRate);
  //       // update the p_ price with the new offer price after calc..
  //   var  productDoc = await firestore.collection('products').doc(productId).get();
  //   var product = Product.fromFirestore(productDoc);
  //   product.price = offerPrice.value;
  //   await firestore.collection('products').doc(productId).update({
  //     'p_price' : product.price
  //   });
  //
  //   offerPrice.value = priceAfterDiscount.roundToDouble();
  //   return  priceAfterDiscount.roundToDouble().toString();
  // }




}