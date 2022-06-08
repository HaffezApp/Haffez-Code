import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/main_tabbar.dart';
import 'package:haffez/utils/enums/tab_bar_item.dart';
import 'package:haffez/utils/enums/user_type.dart';
import 'package:haffez/utils/user_profile.dart';

class MainTabBarView extends StatelessWidget {
  const MainTabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainTabBarViewModel>(
      init: MainTabBarViewModel(),
      builder: (controller) => Scaffold(
        body: UserProfile.shared.currentUser?.userType
            ?.tabBarItems[controller.activeTap].screen,
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainTabBarViewModel>(
      init: MainTabBarViewModel(),
      builder: (controller) => BottomNavigationBar(
        items: _renderTaps(),
        currentIndex: controller.activeTap,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        elevation: 0,
        showUnselectedLabels: true,
        backgroundColor: const Color(0xffE5E5E5),
      ),
    );
  }

  List<BottomNavigationBarItem> _renderTaps() {
    List<BottomNavigationBarItem> items = [];

    List<TabBarItem> tabs =
        UserProfile.shared.currentUser?.userType?.tabBarItems ?? [];

    for (var tab in tabs) {
      var tempTab = BottomNavigationBarItem(
        activeIcon: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(Get.context!).primaryColor,
          ),
          child: Image.asset(tab.icon),
        ),
        label: tab.title,
        icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: Image.asset(tab.icon)),
      );

      items.add(tempTab);
    }

    return items;
  }
}
