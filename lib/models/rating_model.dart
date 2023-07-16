import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  final String ratingId;
  final String userId;
  final String productId;
  final int ratingValue;


  Rating({
    required this.ratingId,
    required this.userId,
    required this.productId,
    required this.ratingValue,

  });

  factory Rating.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Rating(
      ratingId: doc.id,
      userId: data['user_id'],
      productId: data['product_id'],
      ratingValue: data['rating_value'],

    );
  }
}
