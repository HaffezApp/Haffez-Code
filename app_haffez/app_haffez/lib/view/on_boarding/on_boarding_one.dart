import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              const CustomText(
                text: "أهلا بكم في مجتمع التحفيز",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          CustomText(
            text: "تبغى تتعلم بس ما حولك احد يحفزك؟",
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