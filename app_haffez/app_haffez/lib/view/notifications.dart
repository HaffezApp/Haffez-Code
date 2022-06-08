import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

import '../utils/assets.dart';

class Notifications extends StatelessWidget {
  Notifications({Key? key}) : super(key: key);
  final List notificationsContent = [
    {
      "titel": "اشعار تسجيل دخول",
      "content": " هلا والله نورت المكان!",
      "icon": Assets.shared.icRocket,
    },
    {
      "titel": "اشعار قبول انضمام",
      "content": "المحفز مشاري احمد قبل طلبك ومتحمس يشرف عليك!",
      "icon": Assets.shared.icHandTwo,
    },
    {
      "titel": "اشعار انهاء الكورس",
      "content": "انهيت كورسك كامل كفو عليك!",
      "icon": Assets.shared.icHand
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEFEFF4),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "التنبيهات",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(20.r),
            itemCount: notificationsContent.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(12.r),
                margin: EdgeInsets.symmetric(vertical: 5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.r,
                          height: 40.r,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            // color: Assets.shared.primaryColor,
                          ),
                          child: Image.asset(
                            "${notificationsContent[index]['icon']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "${notificationsContent[index]['titel']}",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            SizedBox(
                              width: 200.r,
                              child: CustomText(
                                text:
                                    "${notificationsContent[index]['content']}",
                                fontSize: 12,
                                textAlign: TextAlign.right,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: const Color(0xff3C3C43).withOpacity(0.3),
                      size: 12.r,
                    ),
                  ],
                ),
              );
            }));
  }
}
