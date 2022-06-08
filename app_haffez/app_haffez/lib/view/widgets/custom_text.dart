import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final Alignment alignment;
  final TextAlign textAlign;
  final double lineHeight;

  const CustomText({
    Key? key,
    this.text = "",
    this.fontSize = 16,
    this.lineHeight = 1,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.alignment = Alignment.center,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          height: lineHeight.h,
          fontSize: ScreenUtil().setSp(fontSize),
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
