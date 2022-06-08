import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/view/discussion/discussion_details.dart';
import 'package:haffez/view/discussion/new_questions.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';
import '../notifications.dart';

// الصفحة الرئيسية للمناقشات

class DiscussionsView extends StatelessWidget {
  const DiscussionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFF4),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => Notifications());
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
        ],
        toolbarHeight: 140.h,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Column(
          children: [
            const CustomText(
              text: "المناقشات",
              fontSize: 18,
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              decoration: BoxDecoration(
                // بوكس البحث
                color: Colors.white54,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                // بوكس ابحث قابل للكتابة
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: InputBorder
                      .none, // الخط الازرق الي يطلع في الكونتينر حق الكتابة
                  hintText: "ابحث عن السؤال اللي تبيه",
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 16.r,
                    color: const Color(0xff818181),
                  ),
                  suffixIcon: Visibility(
                    // فائدتة الوحيده عشان النص يكون في النص
                    visible: false,
                    child: Icon(
                      Icons.search_rounded,
                      size: 16.r,
                      color: const Color(0xff818181),
                    ),
                  ),
                ),
              ),
            ),
             SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {},
              child: const CustomText(
                  text: "اسئلتي",
                  alignment: Alignment.centerRight,
                  fontSize: 14,
    
                  textColor: Colors.white),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {},
              child: const CustomText(
                text: "اجوبتي",
                textColor: Colors.black,
                alignment: Alignment.centerRight,
                fontSize: 14,
                
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: MainDrawer(),
      // قلم الكتابة
      floatingActionButton: InkWell(
        onTap: () => Get.to(const NewQuestions()),
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(5.r),
            ),
          ),
          child: Icon(
            Icons.edit,
            size: 26.r,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return const _ItemCell();
        },
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  const _ItemCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => const DiscussionDetailsView()),
      child: Container(
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // الايموجي
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 3),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).primaryColor,
                      size: 32.r,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "محمد",
                      alignment: Alignment.centerRight,
                      textAlign: TextAlign.right,
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomText(
                      text: "ما هي انواع الداتا في جافا",
                      alignment: Alignment.centerRight,
                      textAlign: TextAlign.right,
                      fontSize: 14,
                      textColor: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: const [
                    CustomText(
                      text: "اسبوع",
                      textColor: Colors.black54,
                      fontSize: 12,
                    ),
                    Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: Colors.black54,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                const CustomText(
                  text: "برمجة التطبيقات",
                  textColor: Colors.grey,
                  fontSize: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
