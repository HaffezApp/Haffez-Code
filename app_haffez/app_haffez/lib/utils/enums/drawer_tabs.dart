import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haffez/view/tab_bar/main_tab_bar_view.dart';
import 'package:haffez/view/update_profile.dart';

enum DrawerTabs {
  home,
  profile,
}

extension DrawerTabsExtension on DrawerTabs {
  String get title {
    switch (this) {
      case DrawerTabs.home:
        return "الصفحة الرئيسية";
      case DrawerTabs.profile:
        return "الملف الشخصي";
    }
  }

  IconData get icon {
    switch (this) {
      case DrawerTabs.home:
        return Icons.home;
      case DrawerTabs.profile:
        return Icons.person_rounded;
    }
  }

  Function get action {
    switch (this) {
      case DrawerTabs.home:
        return () => Get.offAll(() => const MainTabBarView());
      case DrawerTabs.profile:
        return () => Get.to(() => UpdateProfile());
    }
  }
}
