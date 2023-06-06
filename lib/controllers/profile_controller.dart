
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var chosenImagePath = ''.obs;
  var profileImageLink = "";
  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();



  pickImageFromGallery(context) async {
  try {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (image == null) return ;
      chosenImagePath.value = image.path;
  }on PlatformException catch(e) {
    VxToast.show(context, msg: e.toString());
  }
  }


  uploadProfileImage()async {
    final storage = FirebaseStorage.instance;
    var fileName = basename(chosenImagePath.value);
    var destination = 'images/${currentUser!.uid}/$fileName';

    Reference  ref = FirebaseStorage.instance.ref().child(destination);
   await ref.putFile(File(chosenImagePath.value));
   profileImageLink = await ref.getDownloadURL();
  }
  updateProfile({name,phoneNumber,address,imageUrl})async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      "name": name,
      "phone number": phoneNumber,
      "address": address,
      "imageUrl": imageUrl,

    },SetOptions(merge: true));
    isLoading.value = false;  // here stopped
  }
}