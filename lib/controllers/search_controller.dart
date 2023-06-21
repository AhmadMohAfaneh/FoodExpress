
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/prducts_model.dart';

class SearchController extends GetxController{
  TextEditingController searchTextController = TextEditingController();
   var productsName = [];
   var dataFromStreamList = [];
   List<String> filterdProductsName = [];
  Stream<List<Product>> getProducts(){
      var db = FirebaseFirestore.instance;
     var productsNameData =  db.collection('products').snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
         return productsNameData;
  }
  checkingControllerWithList() {
    if(searchTextController.text.isNotEmpty) {
      var searchText = searchTextController.text;
      print(searchText.length);

      filterdProductsName.clear();

      for(var element in dataFromStreamList) {
        if(element.startsWith(searchText)) {
          filterdProductsName.add(element);
        }
      }

      print(filterdProductsName);
      print(filterdProductsName.length);
    }
  }
  Stream<List<Product>> getProductsAsSearched() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('products').where('p_name'.toLowerCase() ,isEqualTo: filterdProductsName).snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => Product.fromFirestore(doc)).toList());
  }

//  Stream<List<Product>> getProductsAsSearched() {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   return firestore.collection('products').where('p_name'.toLowerCase() ,isEqualTo: filterdProductsName).snapshots().map((querySnapshot) => querySnapshot.docs
  //       .map((doc) => Product.fromFirestore(doc)).toList());
  //
  // }

  // getDataAsSearch(filterdProductsName,product){
  //   getProducts().where((product.name) =>  )
  //
  //
  // }



  // checkingControllerWithList(){
  //   if(searchTextController.text.isNotEmpty){
  //     print(searchTextController.text.length);
  //     print(filterdProductsName);
  //     for(var element in dataFromStreamList){
  //       if(element[searchTextController.text.length-1] == searchTextController.text[searchTextController.text.length-1]){
  //         filterdProductsName.add(element);
  //         print(filterdProductsName);
  //         print(filterdProductsName.length);
  //       }
  //       else{
  //
  //       }
// checkingControllerWithList(){
  //   if(searchTextController.text.isNotEmpty){
  //     print(searchTextController.text.length);
  //     print(filterdProductsName);
  //     for(var element in dataFromStreamList){
  //       if(element[0] == searchTextController.text[0]){
  //         filterdProductsName.add(element);
  //         if(element[0] == searchTextController.text[0] && element[1] == searchTextController.text[1]){
  //           filterdProductsName.clear();
  //           filterdProductsName.add(element);
  //         }
  //         else{
  //           filterdProductsName.clear();
  //         }
  //         print(filterdProductsName);
  //         print(filterdProductsName.length);
  //       }
  //       else{
  //
  //       }
  //     }
  //   }
  // }

}