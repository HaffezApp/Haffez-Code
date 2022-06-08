import 'package:get/get.dart';

class MainTabBarViewModel extends GetxController {
  int activeTap = 0;

  void changeSelectedValue(int selectedValue) {
    activeTap = selectedValue;
    update();
  }
}
