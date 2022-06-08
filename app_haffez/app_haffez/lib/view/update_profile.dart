import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/auth.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/widgets/custom_auth_text_field.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.black, //لون السهم
        ),
        title: const
            // CustomText(
            //     text: "الملف الشخصي ", fontSize: 20, fontWeight: FontWeight.w400),
            Text(
          "الملف الشخصي",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body:
          //SingleChildScrollView(
          //child:
          Container(
        padding: EdgeInsets.all(20.r),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            GetBuilder<AuthViewModel>(
                init: AuthViewModel(),
                builder: (controller) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const CustomText(
                          text: "اسم المستخدم",
                          textColor: Colors.grey,
                          fontSize: 18,
                          alignment: Alignment.topRight,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        //التكست فيلد
                        CustomAuthTextField(
                          initialValue:
                              UserProfile.shared.currentUser?.name ?? "",
                          onSaved: (value) => controller.name = value?.trim(),
                          hintText: "",
                          isEdit: true,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        const CustomText(
                          text: "كلمة المرور",
                          textColor: Colors.grey,
                          fontSize: 18,
                          alignment: Alignment.topRight,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomAuthTextField(
                          initialValue: "",
                          onSaved: (value) =>
                              controller.password = value?.trim(),
                          hintText: "",
                          isEdit: true,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        const CustomText(
                          text: "البريد الالكتروني",
                          textColor: Colors.grey,
                          fontSize: 18,
                          alignment: Alignment.topRight,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomAuthTextField(
                          initialValue:
                              UserProfile.shared.currentUser?.email ?? "",
                          onSaved: (value) => controller.email = value?.trim(),
                          hintText: "",
                          isEdit: true,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        //زر الحفظ
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _formKey.currentState?.save();
                                controller.updateProfile();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.r, vertical: 10.r),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: const CustomText(
                                  text: "حفظ",
                                  fontSize: 16,
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
      // ),
    );
  }
}
