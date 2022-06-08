import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/active_course_view_model.dart';
import 'package:haffez/core/view_model/training_course.dart';
import 'package:haffez/model/material_model.dart';
import 'package:haffez/model/training_course.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/enums/course_platforms.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/view_model/course_request_view_model.dart';

class CourseView extends StatelessWidget {
  final MaterialModel material;

  CourseView({
    Key? key,
    required this.material,
  }) : super(key: key);
  final TrainingCourseViewModel _controller =
      Get.put(TrainingCourseViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Column(
          children: [
            const SizedBox(
              height: 9,
            ),
            Text(
              material.name ?? "", // اسم الدوره
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ],
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(20.r),
        width: double.infinity,
        child: GetBuilder<TrainingCourseViewModel>(
          init: TrainingCourseViewModel(),
          initState: (_) {
            _controller.getCoursesByUidCourse(uidCourse: material.uid ?? "");
          },
          builder: (controller) {
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 35.h,
                      width: 140.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.put(ActiveCourseViewModel()).addActiveCourse(
                            uidTrainingCourse: null,
                            uidCourse: material.uid,
                            uidOwner: UserProfile.shared.currentUser?.uid ?? "",
                            uidMotivator: null,
                          );
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(
                             10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0.r),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                             Assets.shared.secondaryColor),
                        ),
                        child: const CustomText(
                          text: "اضافة بدون محفز",
                          textColor: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.r, // مسافه بين الصفوف
                    crossAxisSpacing: 10.r, // مسافة بين الاعمدة
                    childAspectRatio: 0.459, //GridView  يعطيني طول لل 0.479
                    children: List.generate(
                      controller.items.length, // عدد المشرفين
                      (index) {
                        // لعرض المشرفين
                        return _ItemCell(
                          item: controller.items[index],
                        );
                      },
                    ),
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
  final TrainingCourse item;

  const _ItemCell({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2, // شدو حول الكونتينر
            blurRadius: 2, //تخفيف للون الشدو
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            child: Icon(
              Icons.person_outline,
              color: Theme.of(context).primaryColor,
              size: 42.r,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            color: Colors.grey,
            height: 0.5,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "الموقع: ",
                fontSize: 12,
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 1.w,
              ),
              Flexible(
                child: InkWell(
                  onTap: () {
                    try {
                      launch(item.course?.courseUrl ?? "");
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  child: CustomText(
                    text: item.course?.platform?.title ?? "",
                    fontSize: 12,
                    alignment: Alignment.centerRight,
                    textAlign: TextAlign.start,
                    textColor: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "اسم المحفز: ",
                fontSize: 12,
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 1.w,
              ),
              Flexible(
                child: CustomText(
                  text: item.owner?.name ?? "",
                  fontSize: 12,
                  alignment: Alignment.centerRight,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "نبذة عنه: ",
                fontSize: 12,
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 1.w,
              ),
              Flexible(
                child: CustomText(
                  text: item.details ?? "",
                  fontSize: 12,
                  alignment: Alignment.centerRight,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              CustomText(
                text: "تقييم المحفز: ",
                fontSize: 12,
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 1.w,
              ),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 10.r,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.r),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: CustomText(
                  text: "عدد الكورسات التي تم الإشراف عليها: ",
                  fontSize: 12,
                  textColor: Theme.of(context).primaryColor,
                  alignment: Alignment.centerRight,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          CustomText(
            text: item.owner?.coursesSupervisedCount == null
                ? "0"
                : "${item.owner?.coursesSupervisedCount}",
            fontSize: 12,
            alignment: Alignment.centerRight,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "تاريخ بدء الكورس: ",
                fontSize: 12,
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 1.w,
              ),
            ],
          ),
          Flexible(
            child: CustomText(
              text: item.startDate == null
                  ? ""
                  : formatDate(
                      DateTime.parse(
                          item.startDate ?? DateTime.now().toString()),
                      [yyyy, '/', mm, '/', dd]),
              fontSize: 10,
              alignment: Alignment.centerRight,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 10.r,
          ),
          ElevatedButton(
            onPressed: () {
              Get.put(CourseRequestViewModel()).joinRequestCourse(
                  uidCourse: item.uid ?? "",
                  uidMotivator: item.createdBy ?? "");
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0.r),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            child: const CustomText(
              text: "طلب انضمام",
              textColor: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
