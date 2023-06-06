import 'package:get/get.dart';

class RemoveDishController extends GetxController {
  var selectedDish = ''.obs;

  void clear() {
    selectedDish.value = '';
  }
}
