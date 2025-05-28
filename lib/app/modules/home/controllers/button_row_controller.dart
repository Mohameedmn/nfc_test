import 'package:get/get.dart';

class ButtonRowController extends GetxController {
  var selectedIndex = (-1).obs;

  void selectButton(int index) {
    selectedIndex.value = index;
  }
}
