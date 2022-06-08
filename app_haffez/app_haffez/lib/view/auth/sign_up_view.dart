import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/auth.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/enums/gender.dart';
import 'package:haffez/utils/enums/user_type.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/auth/sign_in_view.dart';
import 'package:haffez/view/widgets/custom_auth_text_field.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final AuthViewModel _controller = Get.put(AuthViewModel());

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
                        text: "صديقنا",
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
                      text: "سجل معنا",
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    GetBuilder<AuthViewModel>(
                      init: AuthViewModel(),
                      initState: (_) {
                        _controller.getTracks();
                      },
                      builder: (controller) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomAuthTextField(
                                onSaved: (value) =>
                                    controller.name = value?.trim(),
                                hintText: "الاسم",
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
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
                              Visibility(
                                visible: UserProfile.shared.userType ==
                                    UserType.motivator,
                                child: Column(
                                  children: [

                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    CustomAuthTextField(
                                      onSaved: (value) {},
                                      onTap: controller.selectTrack,
                                      isReadOnly: true,
                                      value: controller.selectedTrack == null
                                          ? ""
                                          : controller.selectedTrack?.name,
                                      hintText: "المسارات",
                                      textInputType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    Visibility(
                                      visible: controller.selectedTrack != null,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          CustomAuthTextField(
                                            onSaved: (value) {},
                                            onTap: controller.selectSpecialty,
                                            isReadOnly: true,
                                            value:
                                                controller.selectedSpecialty ==
                                                        null
                                                    ? ""
                                                    : controller
                                                        .selectedSpecialty
                                                        ?.name,
                                            hintText: "التخصص",
                                            textInputType:
                                                TextInputType.emailAddress,
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Visibility(
                                visible: UserProfile.shared.userType ==
                                    UserType.motivator,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      text: "محفزة ولا محفز؟",
                                      fontSize: 14,
                                      alignment: Alignment.topRight,
                                    ),
                                    SizedBox(width: 10.w),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 12.r,
                                              child: Radio(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: Gender.female,
                                                groupValue: controller.gender,
                                                onChanged: (value) {
                                                  controller.selectGender(
                                                      gender: Gender.female);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            CustomText(
                                              text: "محفزة",
                                              textColor: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 12.r,
                                              child: Radio(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: Gender.male,
                                                groupValue: controller.gender,
                                                onChanged: (value) {
                                                  controller.selectGender(
                                                      gender: Gender.male);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            CustomText(
                                              text: "محفز",
                                              textColor: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: UserProfile.shared.userType ==
                                    UserType.motivated,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      text: "متحفزة ولا متحفز؟",
                                      fontSize: 14,
                                      alignment: Alignment.topRight,
                                    ),
                                    SizedBox(width: 10.w),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 12.r,
                                              child: Radio(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: Gender.female,
                                                groupValue: controller.gender,
                                                onChanged: (value) {
                                                  controller.selectGender(
                                                      gender: Gender.female);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            CustomText(
                                              text: "متحفزة",
                                              textColor: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 12.r,
                                              child: Radio(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: Gender.male,
                                                groupValue: controller.gender,
                                                onChanged: (value) {
                                                  controller.selectGender(
                                                      gender: Gender.male);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            CustomText(
                                              text: "متحفز",
                                              textColor: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _formKey.currentState?.save();

                                  if (controller.name == "" ||
                                      controller.email == "" ||
                                      controller.password == "" ||
                                      controller.gender == null) {
                                    Get.customSnackbar(
                                      title: "خطأ",
                                      message: "يرجى إدخال جميع الحقول",
                                      isError: true,
                                    );
                                    return;
                                  }

                                  if (UserProfile.shared.userType ==
                                      UserType.motivator) {
                                    if (controller.selectedTrack == null ||
                                        controller.selectedSpecialty == null) {
                                      Get.customSnackbar(
                                        title: "خطأ",
                                        message: "يرجى إدخال جميع الحقول",
                                        isError: true,
                                      );
                                      return;
                                    }
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

                                  if (!(controller.password ?? "")
                                      .isValidPassword()) {
                                    Get.customSnackbar(
                                      title: "خطأ",
                                      message: "يرجى إدخال كلمة مرور قوية",
                                      isError: true,
                                    );
                                    return;
                                  }

                                  controller
                                      .createAccountWithEmailAndPassword();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(10.r),
                                  primary: const Color(0xffE6F1F3),
                                  shape: const StadiumBorder(),
                                ),
                                child: const CustomText(
                                  text: "أهلا فيك",
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