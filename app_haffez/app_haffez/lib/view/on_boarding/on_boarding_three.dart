import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "وتقدر كمتحفز تأخد الكورسات مع محفز أو تكون أنت المحفز!",
            fontSize: 20,
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}