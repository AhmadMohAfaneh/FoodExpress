// create acount method


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/screens/admin_screens/admin_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../screens/auth_screen/intro_screen.dart';
import '../screens/home_screen/home_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Future<UserCredential?> signupMethod({email, password,context}) async {

    UserCredential? userCredential;
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        VxToast.show(
           context,
          msg: "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        VxToast.show(
          context,
          msg: "The account already exists for that email.",
        );
      }else if (e.toString().contains("email address is badly formatted") ){
        VxToast.show(
          context, msg: "Enter Valid Email",);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
    return userCredential;
  }

// login methode

  Future<UserCredential?> loginMethod({email, password,context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential != null) {
        DocumentReference store = FirebaseFirestore.instance.collection(usersCollection).doc(userCredential.user!.uid);
        DocumentSnapshot snapshot = await store.get();
        String userType = (snapshot.data() as Map<String, dynamic>)["user_type"] ?? "user";

        if(userType == "admin") {
          Get.offAll(() => const AdminHomePage());
          VxToast.show(context, msg: "successfully logged in ");
        } else {
          Get.offAll(() => const Home());
          VxToast.show(context, msg: "successfully logged in ");
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        VxToast.show(
            context, msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        VxToast.show(
          context, msg: "Wrong password provided for that user.",);
       // handling other errors
      }else if (e.toString().contains("email address is badly formatted") ){
        VxToast.show(
          context, msg: "Enter Valid Email",);
      }
    else{
         VxToast.show(context, msg: e.toString());
      }
    }
    return userCredential;
  }



  storeUserData({name, phoneNumber, address, required String userType, id }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference store =
    firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      "name": name,
      "phone number": phoneNumber,
      "address": address,
      "user_type": "user",
      "imageUrl": "",
      "id" : currentUser!.uid,
    });
  }

  checkUserAuth(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        const IntroPage();
      } else {

        print('User is signed in!');
       const  Home();
      }
    });

  }




  signOut(context) async {
    try {
      await auth.signOut();
      VxToast.show(context, msg: "Logging Out");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}


class SignupController extends AuthController {
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPassController = TextEditingController();
  final TextEditingController registerUsernameController =
  TextEditingController();
  final TextEditingController registerPhoneNumberController =
  TextEditingController();
  final TextEditingController registerRetypePasswordController =
  TextEditingController();
  final TextEditingController registerAddressController =
  TextEditingController();
  RxBool isCheck = false.obs;
  RxString errorMessage = ''.obs;

  bool get validationPassword {
    return registerPassController.text == registerRetypePasswordController.text;
  }
  String userType = 'user';
  bool get emptyInfoFields {
    if(registerUsernameController.text.isEmpty){
      errorMessage.value = "Username is empty";
      return false;
    } else if (registerPhoneNumberController.text.isEmpty){
      errorMessage.value = "phone number is empty";
      return false;
    } else if(registerAddressController.text.isEmpty){
      errorMessage.value = "address is empty";
      return false;
    } else if (registerEmailController.text.isEmpty){
      errorMessage.value = "email is empty";
      return false;
    } else if (registerPassController.text.isEmpty){
      errorMessage.value = "password is empty";
      return false;
    } else if (registerRetypePasswordController.text.isEmpty){
      errorMessage.value = "retype your password";
      return false;
    } else if(!validationPassword){
      errorMessage.value = "password does not matches ";
      return false;
    } else if(!isCheck.value){
      errorMessage.value = "you must agree to our terms";
      return false;
    } else {
      errorMessage.value = "";
      return true;
    }
  }
}


class LoginController extends AuthController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString errorMessage = "".obs;
  bool get emptyInfoFields {
    if (emailController.text.isEmpty) {
      errorMessage.value = "email is empty";
      return false;
    } else if (passwordController.text.isEmpty) {
      errorMessage.value = "password is empty";
      return false;
    }
    else{
      errorMessage.value = "";
      return true;
    }
  }


}