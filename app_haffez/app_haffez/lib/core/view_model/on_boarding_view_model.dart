import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haffez/view/auth/auth_view.dart';
import 'package:haffez/view/on_boarding/on_boarding_five.dart';
import 'package:haffez/view/on_boarding/on_boarding_four.dart';
import 'package:haffez/view/on_boarding/on_boarding_one.dart';
import 'package:haffez/view/on_boarding/on_boarding_six.dart';
import 'package:haffez/view/on_boarding/on_boarding_three.dart';
import 'package:haffez/view/on_boarding/on_boarding_two.dart';

class OnBoardingViewModel extends GetxController {
  final PageController pageController = PageController();

  int activeIndex = 0;

  List<Widget> items = const [
    OnBoardingOne(), // index 0
    OnBoardingTwo(),
    OnBoardingThree(),
    OnBoardingFour(),
    OnBoardingFive(),
    OnBoardingSix(), // index 5
  ];
  // محتوى الكونتينر
  void updateIndex({required int index}) {
   
    activeIndex = index;
    update();
  }

// الدوائر
  void updateIndexToNext() {
    if (activeIndex < items.length - 1) {
      activeIndex += 1;
    } else {
      Get.offAll(
        () => const AuthView(),
      );
    }

    pageController.animateToPage(
      activeIndex, 
      duration:
          const Duration(milliseconds: 200), // المده على ماينتقل لصفحة التالية
      curve: Curves.ease, // طريقة ظهور النص
    );

    update();
  }
}