import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/on_boarding/on_boarding_view.dart';
import 'package:haffez/view/tab_bar/main_tab_bar_view.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      UserProfile.shared.getUser().then((user) {
        if (user != null) {
          UserProfile.shared.currentUser = user;

          Get.offAll(
            () => const MainTabBarView(),
            transition: Transition.zoom,
          );
        } else {
          Get.offAll(
            () => const OnBoardingView(),
            transition: Transition.zoom,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffBCDDE2),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Image.asset(
              Assets.shared.icLogo,
              fit: BoxFit.fill,
            ),
            const CustomText(
              text: "طالبات نظم المعلومات",
            ),
          ],
        ),
      ),
    );
  }
}
