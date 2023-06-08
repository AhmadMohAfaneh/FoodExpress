import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
final String  categoryId;
final String categoryName;
final String  categoryUrlImage;

Category({required this.categoryId ,required this.categoryName,required this.categoryUrlImage});

      factory Category.fromFirestore(DocumentSnapshot doc) {
      return Category(
        categoryId: doc['category_id'],
        categoryName: doc['category_name'],
        categoryUrlImage: doc['c_urlimage']

  );
}
}