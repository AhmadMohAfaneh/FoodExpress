import 'dart:io';

import 'package:e_commerce/consts/colors.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/controllers/profile_controller.dart';
import 'package:e_commerce/customs/custom_elvated_button.dart';
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
        title: const Text('Edit Profile'),
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
                      "Edit Your Profile",
                      style: TextStyle(
                          fontFamily: bold, color: redColor, fontSize: 22),
                    )),

                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    controller.chosenImagePath.isEmpty
                        ? Image.asset(
                            imgProfilePic,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.chosenImagePath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    IconButton(onPressed: () {
                      controller.pickImageFromGallery(context);
                    }, icon: const Icon(Icons.edit)),
                  ]),
                ),

                // customElevatedButton(onPressed: (){},
                //     child: const Text("change"), fixedSize: const Size(50, 20), color: redColor),

                // Obx(

                //       () => CircleAvatar(
                //     radius: 70,
                //     backgroundColor: myWhite,
                //     backgroundImage: controller.chosenImagePath.value.isEmpty
                //         ? null
                //         : AssetImage(controller.chosenImagePath.value),
                //     child: IconButton(
                //       icon: const Icon(Icons.camera_alt),
                //       color: redColor,
                //       onPressed: controller.pickImageFromGallery(context),
                //     ),
                //   ),
                // ),
                30.heightBox,
                CustomTextField(
                  controller: controller.nameController,
                  labelText: hintUserName,
                  hintText: 'Enter your restaurant name',
                  labelTextColor: myBlack,
                ),

                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: controller.addressController,
                  labelText: addressSt,
                  hintText: 'Enter your address',
                  labelTextColor: myBlack,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: controller.phoneNumberController,
                  labelText: hintPhoneNumber,
                  hintText: 'Enter your phone number',
                  labelTextColor: myBlack,
                ),
                const SizedBox(height: 24.0),
                customElevatedButton(
                  onPressed: () {
                    // Handle save button click here
                  },
                  child: const Text('  Save  '),
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
