import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class OnBoardingSix extends StatelessWidget {
  const OnBoardingSix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "شد حيلك! \n ترا السالفة فيها تقييم ومراكز",
            fontSize: 20,
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}