// import 'package:e_commerce/consts/colors.dart';
// import 'package:e_commerce/consts/consts.dart';
// import 'package:e_commerce/controllers/profile_controller.dart';
// import 'package:e_commerce/customs/custom_elvated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../../../customs/custom_text-field.dart';
// class AdminEditProfileScreen extends StatelessWidget {
//    AdminEditProfileScreen({Key? key}) : super(key: key);
//
//   final TextEditingController _restaurantNameController = TextEditingController();
//
//   final TextEditingController _addressController = TextEditingController();
//
//   final TextEditingController _phoneNumberController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ProfileController());
//     return Scaffold(
//       backgroundColor: myWhite,
//       appBar: AppBar(
//         backgroundColor: redColor,
//         title: const Text('Edit Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Align(
//              heightFactor: 3,
//                   child: Text("Edit Your Profile",style: TextStyle(fontFamily: bold,color: redColor,fontSize: 22),)),
//               Obx(
//                     () => CircleAvatar(
//                   radius: 70,
//                   backgroundColor: myWhite,
//                   backgroundImage: controller.chosenImagePath.value.isEmpty
//                       ? null
//                       : AssetImage(controller.chosenImagePath.value),
//                   child: IconButton(
//                     icon: const Icon(Icons.camera_alt),
//                     color: redColor,
//                     onPressed: controller.pickImageFromGallery,
//                   ),
//                 ),
//               ),
//               30.heightBox,
//
//               CustomTextField(
//                 controller: _restaurantNameController,
//                 labelText: 'Restaurant Name',
//                 hintText: 'Enter your restaurant name',
//                 labelTextColor: myBlack,
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextField(
//                 controller: _addressController,
//                 labelText: 'Address',
//                 hintText: 'Enter your address',
//                 labelTextColor: myBlack,
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextField(
//                 controller: _phoneNumberController,
//                 labelText: 'Phone Number',
//                 hintText: 'Enter your phone number',
//                 labelTextColor: myBlack,
//               ),
//               const SizedBox(height: 24.0),
//               customElevatedButton(
//                 onPressed: () {
//                   // Handle save button click here
//                 },
//                 child: const Text('  Save  '),
//                 fixedSize: const Size(double.infinity, 48.0),
//                 color: redColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
