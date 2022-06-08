import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

// الصفحة الي تنفتح لمن اضغط زر الكتابة
class NewQuestions extends StatelessWidget {
  const NewQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFF4),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "سؤال جديد",
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
      body: SingleChildScrollView(
        child: Container(
          // الابيض الكبير
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  children: [
                    const CustomText(
                      text: "اكتب سؤالك",
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      // الرمادي داخل الابيض
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: const Color(0xfff6f6f6),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder
                              .none, // يشيل الخط الازرق حق الكتابة يظهر بشكل افقي
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                // الابيض الكبير الثاني
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  children: [
                    const CustomText(
                      text: "اكتب مسارك",
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      // الرمادي داخل الابيض الثاني
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: const Color(0xfff6f6f6),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                splashColor: Colors.white, // لمن اضفط على زر يلون ابيض
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  child: const CustomText(
                    text: "ارسال",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}