
import 'dart:io';
import 'package:e_commerce/consts/colors.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/profile_controller.dart';
import 'package:e_commerce/customs/custom_elvated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../customs/custom_text-field.dart';

class UserEditProfileScreen extends StatelessWidget {
  final dynamic data;
  const UserEditProfileScreen({Key? key, this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    controller.nameController.text = data['name'];
    controller.addressController.text = data['address'];
    controller.phoneNumberController.text = data['phone number'];

    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        backgroundColor: redColor,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(()=>
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                      heightFactor: 3,
                      child: Text(
                        editYourProfileSt,
                        style: TextStyle(
                            fontFamily: bold, color: redColor, fontSize: 22),
                      )),

                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      data['imageUrl'] == '' && controller.chosenImagePath.isEmpty ?
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(imgProfilePic),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          : data['imageUrl'] != "" && controller.chosenImagePath.isEmpty ?
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(data['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(File(controller.chosenImagePath.value)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          controller.pickImageFromGallery(context);
                        },
                        icon: const Icon(CupertinoIcons.plus_circle_fill),
                        color: Colors.white,
                      ),
                    ],
                  ),

                  30.heightBox,
                  CustomTextField(
                    controller: controller.nameController,
                    labelText: hintUserName,
                    hintText: hintUserName,
                    labelTextColor: myBlack,
                  ),

                  const SizedBox(height: 16.0),
                  CustomTextField(
                    controller: controller.addressController,
                    labelText: addressSt,
                    hintText: hintAddress,
                    labelTextColor: myBlack,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    controller: controller.phoneNumberController,
                    labelText: hintPhoneNumber,
                    hintText: hintPhoneNumber,
                    labelTextColor: myBlack,
                  ),
                  controller.isLoading.value ? const CircularProgressIndicator(): const SizedBox(height: 24.0),
                  customElevatedButton(
                    onPressed: () async{
                      controller.isLoading.value = true;
                      if (controller.chosenImagePath.isNotEmpty) {
                        await controller.uploadProfileImage();
                      }
                      await controller.updateProfile(
                        imageUrl: controller.chosenImagePath.isNotEmpty ? controller.profileImageLink : data['imageUrl'],
                        name: controller.nameController.text,
                        address: controller.addressController.text,
                        phoneNumber: controller.phoneNumberController.text,
                      );
                      VxToast.show(context, msg: dataUpdatedSt);
                    },
                    child: const Text(saveSt),
                    fixedSize: const Size(double.infinity, 48.0),
                    color: redColor,
                  ),

                ],
              ),
          ),
        ),
      ),
    );
  }
}