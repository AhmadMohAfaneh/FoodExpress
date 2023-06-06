import 'package:e_commerce/consts/colors.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/customs/custom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/remove_dish_controller.dart';

class RemoveDish extends StatelessWidget {
  final RemoveDishController removeDishController =
  Get.put(RemoveDishController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        backgroundColor: redColor,
        title: const Text('Remove Dish'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Obx(
                    () => DropdownButton<String>(
                  value: removeDishController.selectedDish.value.isNotEmpty
                      ? removeDishController.selectedDish.value
                      : null,
                  hint: const Text('Select a dish'),
                  items: dishesNameList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    removeDishController.selectedDish.value = newValue!;
                  },
                ),
              ),
              customElevatedButton(onPressed: submitForm, child: const Text("Remove Dish"), fixedSize: const Size(150, 40), color:redColor )
            ],
          ),
        ),
      ),
    );
  }

  void submitForm() {
    // Use the information to update your Firebase database.
    // Here, just printing out the information.
    print('Dish to remove: ${removeDishController.selectedDish.value}');
    // Clear the fields after submitting
    removeDishController.clear();
  }
}
