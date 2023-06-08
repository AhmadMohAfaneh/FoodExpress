import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/category.model.dart';

class CategoryController extends GetxController {
  // List categoryName = [];
  // List categoryImageUrl = [];
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getCategories();
  // }
  //
  // void getCategories() async {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   QuerySnapshot querySnapshot = await db.collection('categories').get();
  //   final categories = querySnapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
  //   for(int i= 0; i<categories.length;i++){
  //     categoryName.add(categories[i].categoryName);
  //     categoryImageUrl.add(categories[i].categoryUrlImage);
  //   }
  //   update();
  // }

  Stream<List<Category>> getCategories() {
  var db = FirebaseFirestore.instance;
  return db.collection('categories').snapshots().map((querySnapshot) =>
  querySnapshot.docs.map((doc) => Category.fromFirestore(doc)).toList());

  }


}
