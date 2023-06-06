import 'package:get/get.dart';

class AddDishController extends GetxController {
  var name = ''.obs;
  var description = ''.obs;
  var price = ''.obs;
  var imageUrl = ''.obs;
  var categoryId = ''.obs;
  var offerPrice = ''.obs;
  var hasOffer = false.obs;

  void clear() {
    name.value = '';
    description.value = '';
    price.value = '';
    imageUrl.value = '';
    categoryId.value = '';
    offerPrice.value = '';
    hasOffer.value = false;
  }
}
