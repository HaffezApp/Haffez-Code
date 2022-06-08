import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class OnBoardingTwo extends StatelessWidget {
  const OnBoardingTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              const CustomText(
                text: "بس عندنا الحل!",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          CustomText(
            text: "جبنا لك كورسات من عدة منصات  وبتقييم عالي",
            fontSize: 20,
            textColor: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}