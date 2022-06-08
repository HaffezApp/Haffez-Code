import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/enums/user_type.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/auth/sign_up_view.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widgets/custom_alert_dialog.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "كيف تبي تسجل معنا؟",
                        fontSize: 22,
                      ),
                      SizedBox(height: 70.h),
                      InkWell(
                        onTap: () {
                          UserProfile.shared.userType = UserType.motivated;
                          customAlertDialog(
                            title: "",
                            message: "حاب تسجل معانا وتتعلم ",
                            alertType: AlertType.none,
                            titleBtnOne: "تسجيل كمتحفز",
                            showBtnTwo: false,
                            backgroundButtonOne: const Color(0xff3DA18D),
                            actionBtnOne: () {
                              Get.off(() => SignUpView());
                            },
                            actionBtnTwo: () {},
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.r),
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff3DA18D),
                            borderRadius: BorderRadius.circular(35.r),
                          ),
                          child: const CustomText(
                            text: "متحفز",
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          UserProfile.shared.userType = UserType.motivator;
                          customAlertDialog(
                            title: "",
                            message: "حاب تسجل وتشرف على دورات",
                            alertType: AlertType.none,
                            titleBtnOne: "تسجيل كمحفز",
                            showBtnTwo: false,
                            backgroundButtonOne: Assets.shared.primaryColor,
                            actionBtnOne: () {
                              Get.off(() => SignUpView());
                            },
                            actionBtnTwo: () {},
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.r),
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffA3C8D7),
                            borderRadius: BorderRadius.circular(35.r),
                          ),
                          child: const CustomText(
                            text: "محفز",
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
