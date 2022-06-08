import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/course_request_view_model.dart';
import 'package:haffez/model/course_request.dart';
import 'package:haffez/model/training_course.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/enums/status.dart';
import 'package:haffez/view/widgets/custom_text.dart';

import '../utils/enums/gender.dart';
import 'widgets/rating.dart';

class MembersView extends StatelessWidget {
  final TrainingCourse trainingCourse;

  MembersView({
    Key? key,
    required this.trainingCourse,
  }) : super(key: key);

  final CourseRequestViewModel _controller = Get.put(CourseRequestViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الطلبات",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: GetBuilder<CourseRequestViewModel>(
        init: CourseRequestViewModel(),
        initState: (_) {
          _controller.uidCourse = trainingCourse.uid; // تعرض المتحفزين
          _controller.getRequestTrainingCourseByStatus(
            uid: trainingCourse.uid ?? "",
          );
        },
        builder: (controller) {
          return ListView.builder(
            padding: EdgeInsets.all(20.r),
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return _ItemCell(
                request: controller.items[index],
              );
            },
          );
        },
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  final CourseRequestModel request;

  const _ItemCell({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.r),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 80.r,
                    height: 80.r,
                    // نوع الجندر يجي مع المتحفز الي طلب انضمام
                    child: Image.asset(request.owner?.gender == Gender.male
                        ? Assets.shared.icMale
                        : Assets.shared.icFemale),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: request.owner?.name ??
                            "", // اسم المتحفز الي سوو طلب
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: 3,
                        minRating: 1,
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
                ],
              ),
              Row(
                children: [
                  Visibility(
                    visible:
                        request.status == Status.inReview, // تظهر قبول ورفض
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.put(CourseRequestViewModel()) //قبول المتحفز
                                .updateRequestStatus(
                              requestCourse: request,
                              status: Status.accept,
                            );
                          },
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Image.asset(
                                Assets.shared.icAcceptUser), // ايقونة القبول
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            Get.put(CourseRequestViewModel()) // رفض المتحفز
                                .updateRequestStatus(
                              requestCourse: request,
                              status: Status.reject,
                            );
                          },
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Image.asset(
                                Assets.shared.icRejectUser), // ايقونة الرفض
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: request.status == Status.accept,
                    child: InkWell(
                      onTap: () {
                        Get.dialog(
                          const Rating(),
                        );
                      },
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: Assets.shared.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Image.asset(
                            Assets.shared.icUserDetails), // اييقونة تقييم
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 0.5.h,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
