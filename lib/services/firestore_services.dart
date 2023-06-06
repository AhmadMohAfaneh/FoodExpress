import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';

class FirestoreServices {
  // to get the user data

  static getUser(uid){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return  firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

}