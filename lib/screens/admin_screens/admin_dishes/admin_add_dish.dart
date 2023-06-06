import 'package:e_commerce/consts/colors.dart';
import 'package:e_commerce/customs/custom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/add_dish_controller.dart';

class AddDish extends StatelessWidget {
  final AddDishController addDishController = Get.put(AddDishController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        backgroundColor: redColor,
        title: Text('Add Dish'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            buildTextField(
              controller: addDishController.name,
              labelText: 'Dish Name',
            ),
            buildTextField(
              controller: addDishController.description,
              labelText: 'Dish Description',
            ),
            buildTextField(
              controller: addDishController.price,
              labelText: 'Dish Price',
              keyboardType: TextInputType.number,
            ),
            buildTextField(
              controller: addDishController.imageUrl,
              labelText: 'Image Url',
            ),
            buildTextField(
              controller: addDishController.categoryId,
              labelText: 'Category ID',
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text('Is there an offer on this dish?'),
                value: addDishController.hasOffer.value,
                activeColor: redColor,
                onChanged: (bool? value) {
                  addDishController.hasOffer.value = value!;
                  if (addDishController.hasOffer.value) {
                    showOfferPriceDialog(context);
                  }
                },
              ),
            ),
            customElevatedButton(
                onPressed: submitForm,
                child: const Text('Add Dish'),
                fixedSize: const Size(80, 50),
                color: redColor)
          ],
        ),
      ),
    );
  }
        // change the color of the border
  TextField buildTextField({
    required RxString controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(

      controller: TextEditingController(text: controller.value),
      onChanged: (value) => controller.value = value,
      decoration: InputDecoration(focusColor: fontGrey,labelText: labelText,labelStyle: const TextStyle(color: fontGrey)),
      keyboardType: keyboardType,
    );
  }

  void showOfferPriceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Offer Price'),
        content: buildTextField(
          controller: addDishController.offerPrice,
          labelText: 'Offer Price',
          keyboardType: TextInputType.number,
        ),
        actions: <Widget>[
          customElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Done'),
              fixedSize: const Size(100, 40),
              color: redColor)
        ],
      ),
    );
  }

  void submitForm() {
    // Use the information to update your firebase database.
    // Here, just printing out the information.
    print('Dish Name: ${addDishController.name.value}');
    print('Dish Description: ${addDishController.description.value}');
    print('Dish Price: ${addDishController.price.value}');
    print('Dish Image Url: ${addDishController.imageUrl.value}');
    print('Dish Category Id: ${addDishController.categoryId.value}');
    print('Dish has offer: ${addDishController.hasOffer.value}');
    if (addDishController.hasOffer.value) {
      print('Offer Price: ${addDishController.offerPrice.value}');
    }
    // Clear the fields after submitting
    addDishController.clear();
  }
}
