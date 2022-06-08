import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/training_course.dart';
import 'package:haffez/model/training_course.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/enums/course_platforms.dart';
import 'package:haffez/utils/enums/course_status.dart';
import 'package:haffez/utils/enums/page_type.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/members_view.dart';
import 'package:haffez/view/notifications.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCoursesMotivator extends StatelessWidget {
  MyCoursesMotivator({Key? key}) : super(key: key);

  final TrainingCourseViewModel _controller =
      Get.put(TrainingCourseViewModel());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
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
                          text: "كورساتي",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        IconButton(
                          onPressed: () => Get.to(() => Notifications()),
                          icon: const Icon(Icons.notifications_active_outlined),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.r),
                      child: GetBuilder<TrainingCourseViewModel>(
                        init: TrainingCourseViewModel(),
                        builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => controller.changePageType(
                                    pageType: PageType.currentCourses),
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
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () => controller.changePageType(
                                    pageType: PageType.finishedCourses),
                                child: CustomText(
                                  text: "كورساتي الى أشرفت عليها يا معلم",
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<TrainingCourseViewModel>(
              init: TrainingCourseViewModel(),
              initState: (_) {
                _controller.uidOwner =
                    UserProfile.shared.currentUser?.uid ?? "";
                _controller.getCoursesByUidOwnerWithStatus();
              },
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(20.r),
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      return _ItemCell(
                        item: controller.items[index],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  final TrainingCourse item;

  const _ItemCell({
    Key? key,
    required this.item,
  }) : super(key: key);

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
                        launch(item.course?.courseUrl ?? "");
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
                        text: item.course?.name ?? "", // اسم الدورة
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        textColor: Assets.shared.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  RatingBar.builder(
                    // ميثود عرض النجمات
                    ignoreGestures: true,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 14.r,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190.r,
                    child: CustomText(
                      text: (item.course?.name?.length ?? 0) > 50
                          ? "${item.course?.name?.substring(0, 50)} ..."
                          : item.course?.name ?? "",
                      fontWeight: FontWeight.bold,
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
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          try {
                            launch(item.course?.courseUrl ??
                                ""); // هنا اجيب الموقع واخليه قابل للضغط
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: CustomText(
                          text: item.course?.platform?.title ??
                              "", // هنا يجيب اسم المنصة
                          fontSize: 12,
                          textColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      const CustomText(
                        text: "تاريخ البدء:",
                        fontSize: 14,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomText(
                        text: formatDate(
                            DateTime.parse(
                                item.startDate ?? ""), // يرجع التاريخ
                            [yyyy, '/', mm, '/', dd]),
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: Get.find<TrainingCourseViewModel>().pageType ==
                PageType.currentCourses,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: Assets.shared.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const CustomText(
                          text: "البدء",
                          textColor: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: Assets.shared.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      // وظيفة زر الطلبات
                      onTap: () => Get.to(
                        () => MembersView(
                          trainingCourse: item,
                        ),
                      ),
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: Assets.shared.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          Icons.group_rounded, // زر الطلبات
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ElevatedButton(
                      // تحديث حالة الكورس الى منتهية
                      onPressed: () {
                        Get.put(TrainingCourseViewModel()).updateCourseStatus(
                          course: item,
                          status: CourseStatus.finished,
                        );
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xfff8f8f8)),
                      ),
                      child: const CustomText(
                        text: "انتهيت",
                        textColor: Colors.black,
                        fontSize: 14,
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
