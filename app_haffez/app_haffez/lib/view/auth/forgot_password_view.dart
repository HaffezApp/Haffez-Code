import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/auth.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/view/auth/sign_in_view.dart';
import 'package:haffez/view/widgets/custom_auth_text_field.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: InkWell(
                      onTap: () => Get.offAll(() => SignInView()),
                      child: CustomText(
                        text: "تسجيل الدخول",
                        textColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Image.asset(Assets.shared.icImageAuth),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    const CustomText(
                      text: "إستعادة كلمة المرور",
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    GetBuilder<AuthViewModel>(
                      init: AuthViewModel(),
                      builder: (controller) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomAuthTextField(
                                onSaved: (value) =>
                                    controller.email = value?.trim(),
                                hintText: "البريد الإلكتروني",
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 125.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _formKey.currentState?.save();

                                  if (controller.email == "") {
                                    Get.customSnackbar(
                                      title: "خطأ",
                                      message: "يرجى إدخال البريد إلكتروني",
                                      isError: true,
                                    );
                                    return;
                                  }

                                  if (!GetUtils.isEmail(
                                    controller.email ?? "",
                                  )) {
                                    Get.customSnackbar(
                                      title: "خطأ",
                                      message: "يرجى إدخال بريد إلكتروني صحيح",
                                      isError: true,
                                    );
                                    return;
                                  }

                                  controller.forgotPassword();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(10.r),
                                  primary: const Color(0xffE6F1F3),
                                  shape: const StadiumBorder(),
                                ),
                                child: const CustomText(
                                  text: "إستعادة كلمة المرور",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
