import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class OnBoardingFive extends StatelessWidget {
  const OnBoardingFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "تحسب خلصنا ؟؟؟",
            fontSize: 20,
            textColor: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomText(
            text:
                "لا وكمان وفرنا لك قروب تجتمع فيه مع محفزك والمتحفزين اللي زيك",
            fontSize: 20,
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}