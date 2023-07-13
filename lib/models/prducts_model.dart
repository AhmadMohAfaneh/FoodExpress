import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  num price;
  final String description;
  final String urlImage;
  final String offer;
  final String categoryId;
  final String productId;
  final int rating;
  final num productDiscountRate;

  // p_discount_rate

  Product(
      {required this.name,
      required this.price,
      required this.rating,
      required this.description,
      required this.urlImage,
      required this.offer,
      required this.categoryId,
      required this.productId,
      required this.productDiscountRate});

  /////////////////////////////////////////////////////////////////
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      productId: doc['p_id'],
      rating: doc['rating'],
      name: data['p_name'],
      categoryId: data['category_id'] ?? '',
      description: data['p_description'] ?? '',
      price: data['p_price'] ?? 0,
      urlImage: data['p_urlimage'] ?? '',
      offer: data['p_offer'] ?? '',
      productDiscountRate: data['p_discount_rate'] ?? 0,
      // all is done
    );
  }
}
