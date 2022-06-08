import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/active_course_view_model.dart';
import 'package:haffez/model/active_course.dart';
import 'package:haffez/utils/enums/course_platforms.dart';
import 'package:haffez/utils/enums/course_status.dart';
import 'package:haffez/utils/enums/page_type.dart';
import 'package:haffez/view/notifications.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/assets.dart';

class MyCoursesView extends StatelessWidget {
  MyCoursesView({Key? key}) : super(key: key);

  final ActiveCourseViewModel _controller = Get.put(ActiveCourseViewModel());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(),
      body: SizedBox(
        width: double.infinity,
        child: GetBuilder<ActiveCourseViewModel>(
          init: ActiveCourseViewModel(),
          initState: (_) {
            _controller
                .getMyTrainingCourseByStatus(); // هذي الميثود اللي تعرض الدورات الحالية والنتهية حسب الحالة
          },
          builder: (controller) {
            return Column(
              children: [
                Container(
                  height: 180.h,
                  color: Theme.of(context).primaryColor,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  _scaffoldKey.currentState?.openDrawer(),
                              icon: const Icon(Icons.menu),
                            ),
                            const CustomText(
                              //اسم الصفحة اللي فوق
                              text: "كورساتي",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            IconButton(
                              onPressed: () => Get.to(() => Notifications()),
                              icon: const Icon(
                                  Icons.notifications_active_outlined),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => controller.changePageType(
                                  pageType: PageType.currentCourses,
                                ),
                                child: CustomText(
                                  text: "كورساتي الحالية",
                                  alignment: Alignment.centerRight,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  textColor: controller.pageType ==
                                          PageType.currentCourses
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () => controller.changePageType(
                                  pageType: PageType.finishedCourses,
                                ),
                                child: CustomText(
                                  text: "الكورسات اللي انهيتها ي بطل!",
                                  textColor: controller.pageType ==
                                          PageType.finishedCourses
                                      ? Colors.white
                                      : Colors.black,
                                  alignment: Alignment.centerRight,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(20.r),
                    itemCount: controller.items.length, // هنا اجيب عدد الايتمز
                    itemBuilder: (context, index) {
                      // هنا ترجع اللست اللي هي الدورات الحالية
                      return _ItemCell(
                        course: controller.items[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  final ActiveCourseModel? course;

  const _ItemCell({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.r),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      try {
                        launch(course?.material!.courseUrl ?? "");
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    child: Container(
                      height: 100.r,
                      width: 100.r,
                      decoration: BoxDecoration(
                        color: const Color(0xfff6f6f6),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Assets.shared.primaryColor,
                        ),
                      ),
                      child: CustomText(
                        text: course?.material!.name ?? "", // اسم الدورة
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        textColor: Assets.shared.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RatingBar.builder(
                    // هذا اللي يعرض النجمات تحت مربع الدورة من هنا الى سطر 173
                    ignoreGestures: true,
                    initialRating: 3,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15.r,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0.r),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190.r,
                        child: CustomText(
                          text: course?.material?.name ??
                              "", // هنا يجيب اسم الدورة
                          fontWeight: FontWeight.w600,
                          alignment: Alignment.topRight,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          const CustomText(
                            text: "الموقع:",
                            fontSize: 14,
                            alignment: Alignment.centerRight,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            child: CustomText(
                              text: course?.material?.platform?.title ??
                                  "", // هنا يعرض اسم المنصة
                              fontSize: 14,
                              alignment: Alignment.centerRight,
                              textColor: Colors.blueAccent,
                            ),
                            onTap: () {
                              try {
                                launch(course?.material?.courseUrl ??
                                    ""); // هنا موقع الدورة
                              } catch (e) {
                                log(e
                                    .toString()); // هنا لو طلع ايرور يحوله لكلام
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          const CustomText(
                            text: "تاريخ البدأ:",
                            fontSize: 14,
                            alignment: Alignment.centerRight,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            text: course?.trainingCourse?.startDate !=
                                    null // هنا يجيب تاريخ البدء
                                ? formatDate(
                                    DateTime.parse(
                                        course?.trainingCourse?.startDate ??
                                            DateTime.now().toString()),
                                    [yyyy, '/', mm, '/', dd])
                                : "لا يوجد تاريخ للبدء",
                            fontSize: 14,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          const CustomText(
                            text: "اسم المحفز:",
                            fontSize: 14,
                            alignment: Alignment.centerRight,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            text: course?.motivator?.name ?? "لا يوجد محفز",
                            fontSize: 14,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Visibility(
            // ظهور الدورة اذا قبله المحفز
            visible: Get.find<ActiveCourseViewModel>().pageType ==
                PageType.currentCourses,
            child: Column(
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: course?.trainingCourse?.groupUrl != null,
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            launch(course?.trainingCourse?.groupUrl ?? "");
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff52E83A).withOpacity(0.88),
                          ),
                        ),
                        child: const CustomText(
                          text: "انضمام",
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.put(ActiveCourseViewModel()).updateCourseStatus(
                          // هذي الميثود تغير حالة الدورة الى منتهية
                          course: course,
                          status: CourseStatus.finished,
                        );
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xfff8f8f8),
                        ),
                      ),
                      child: const CustomText(
                        text: "إنتهيت",
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ElevatedButton(
                      // زر الحذف
                      onPressed: () {
                        Get.put(ActiveCourseViewModel())
                            .deleteCourse(uid: course?.uid ?? "");
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xffFF0000).withOpacity(0.55),
                        ),
                      ),
                      child: const CustomText(
                        text: "حذف",
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
