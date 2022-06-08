import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/on_boarding_view_model.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/view/auth/auth_view.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          Assets.shared.bgScaffold,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  // الدوائر تتظلل مع انتقال الصفحة وتغير محتوى الكونتينر
                  child: GetBuilder<OnBoardingViewModel>(
                    init: OnBoardingViewModel(),
                    builder: (controller) {
                      return PageView(
                        controller: controller.pageController,
                        onPageChanged:
                            (index) => 
                                controller.updateIndex(index: index),
                        children: controller
                            .items,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Center(
                  child: SizedBox(
                    height: 15.r,
                    child: GetBuilder<OnBoardingViewModel>(
                      builder: (controller) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal, // بشكل عرضي
                          shrinkWrap:
                              true, // تاخذ المساحة اللازمة ال لستفيو من خلالها الدوائر تجي في النص
                          itemCount: controller.items
                              .length,  
                          itemBuilder: (context, index) {
                            return Balling(
                              isActive: index ==
                                  controller
                                      .activeIndex, 
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(30.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<OnBoardingViewModel>(builder: (controller) {
                  return InkWell(
                    onTap: () => controller
                        .updateIndexToNext(), 
                    child: Container(
                      padding: EdgeInsets.all(15.0.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(180 / 360),
                        child: Image.asset(
                          Assets.shared.icNext, // صورةلايقونة الرجوع
                        ),
                      ),
                    ),
                  );
                }),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => const AuthView(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0.r),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      Assets.shared.icSkip,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Balling extends StatelessWidget {
  bool isActive;

  Balling({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: 15.r,
      height: 15.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive // if-else
            ? Assets.shared.secondaryColor.withOpacity(0.5) // true
            : Colors.white.withOpacity(0.5), // false
      ),
    );
  }
}