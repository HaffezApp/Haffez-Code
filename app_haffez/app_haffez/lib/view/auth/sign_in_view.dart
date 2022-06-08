import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/auth.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/view/auth/forgot_password_view.dart';
import 'package:haffez/view/auth/sign_up_view.dart';
import 'package:haffez/view/widgets/custom_auth_text_field.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);

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
                      onTap: () => Get.offAll(() => SignUpView()),
                      child: CustomText(
                        text: "سجل معنا",
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
                      text: "صديقنا",
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const CustomText(
                      text: "سجل دخول",
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
                                height: 25.h,
                              ),
                              CustomAuthTextField(
                                onSaved: (value) => controller.password = value,
                                hintText: "كلمة المرور",
                                textInputAction: TextInputAction.done,
                                isPassword: true,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Get.offAll(() => ForgotPasswordView()),
                                    child: CustomText(
                                      text: "نسيت كلمة المرور؟",
                                      fontSize: 14,
                                      textColor: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 125.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _formKey.currentState?.save();

                                  if (controller.email == "" ||
                                      controller.password == "") {
                                    Get.customSnackbar(
                                      title: "خطأ",
                                      message: "يرجى إدخال جميع الحقول",
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

                                  controller.signInWithEmailAndPassword();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(10.r),
                                  primary: const Color(0xffE6F1F3),
                                  shape: const StadiumBorder(),
                                ),
                                child: const CustomText(
                                  text: "هلا فيك مرة ثانية",
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
