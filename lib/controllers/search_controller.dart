import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/prducts_model.dart';

class SearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  var productsName = [];
  var dataFromStreamList = [];
  List<String> filterdProductsName = [];

  Stream<List<Product>> getProducts() {
    var db = FirebaseFirestore.instance;
    var productsNameData = db.collection('products').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => Product.fromFirestore(doc))
            .toList());
    return productsNameData;
  }

  checkingControllerWithList() {
    if (searchTextController.text.isNotEmpty) {
      var searchText = searchTextController.text;
      print(searchText.length);

      for (var element in dataFromStreamList) {
        if (element.startsWith(searchText)) {
          filterdProductsName.add(element);
        }
      }

      print(filterdProductsName);
      print(filterdProductsName.length);
    }
  }

  // List<Product> getProductsAsSearched(List<String> ourList,List<Product> product) {
  //   List<Product> productList = [];
  //   if (ourList.isNotEmpty) {
  //     for(var element in ourList){
  //       if(product.name.toLowerCase() == element){
  //         productList.add(product);
  //       }
  //     }
  //   }
  //return productList;

  Stream<List<Product>> getProductsAsSearched(List<String> ourList) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (ourList.isNotEmpty) {
      return firestore
          .collection('products')
          .where('search_keys', arrayContains: searchTextController.text)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => Product.fromFirestore(doc))
              .toList());
    } else {
      return Stream.value([]);
    }
  }
}
