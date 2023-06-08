

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final num price;
  final String description;
  final String urlImage;
  final String offer;
  final String categoryId;
  final String productId;

  Product({required this.name, required this.price, required this.description, required this.urlImage,
    required this.offer, required this.categoryId, required this.productId});
  /////////////////////////////////////////////////////////////////
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Product(
      productId: doc['p_id'],
      name: data['p_name'] ?? '',
      categoryId: data['category_id'] ?? '',
      description: data['p_description'] ?? '',
      price: data['p_price'] ?? 0,
      urlImage: data['p_urlimage'] ?? '',
      offer: data['p_offer'] ?? '',
      // all is done
    );
  }
}
