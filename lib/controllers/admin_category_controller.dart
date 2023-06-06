import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  // Initial category
  RxString currentCategory = 'Burgers'.obs;

  // The list of dishes for the current category
  RxList<Dish> dishes = <Dish>[].obs;

  void changeCategory(String category) {
    currentCategory.value = category;

    // fetch dishes for this category from your backend and update `dishes`
  }
}

class AdminDishes extends StatelessWidget {
  const AdminDishes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminController controller = Get.put(AdminController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
              () => Text('Category: ${controller.currentCategory.value}'),
        ),
      ),
      body: Column(
        children: [
          // Category selection
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => controller.changeCategory('Burgers'),
                  child: const Text('Burgers'),
                ),
                ElevatedButton(
                  onPressed: () => controller.changeCategory('Drinks'),
                  child: const Text('Drinks'),
                ),
                ElevatedButton(
                  onPressed: () => controller.changeCategory('Deserts'),
                  child: const Text('Deserts'),
                ),
              ],
            ),
          ),
          // Dish list
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.dishes.length,
                itemBuilder: (context, index) {
                  final dish = controller.dishes[index];
                  // return your menu container here, passing the dish info
                  return ListTile(
                    title: Text(dish.title),
                    subtitle: Text(dish.description),
                    trailing: Text(dish.price.toString()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Dish {
  final String title;
  final String description;
  final double price;

  Dish({
    required this.title,
    required this.description,
    required this.price,
  });
}
