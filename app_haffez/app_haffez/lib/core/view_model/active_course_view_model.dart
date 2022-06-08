import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_active_course.dart';
import 'package:haffez/core/service/firestore_material.dart';
import 'package:haffez/core/service/firestore_training_course.dart';
import 'package:haffez/core/service/firestore_user.dart';
import 'package:haffez/model/active_course.dart';
import 'package:haffez/utils/enums/course_status.dart';
import 'package:haffez/utils/enums/page_type.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/view/widgets/custom_alert_dialog.dart';
import 'package:haffez/view/widgets/rating.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'auth.dart';

class ActiveCourseViewModel extends GetxController {
  PageType pageType = PageType.currentCourses;

  String? uidCourse;
  List<ActiveCourseModel> items = [];

  void changePageType({required PageType pageType}) {
    if (this.pageType == pageType) {
      return;
    }

    this.pageType = pageType;

    getMyTrainingCourseByStatus();

    update();
  }

  Future<void> addActiveCourse({
    required String? uidTrainingCourse,
    required String? uidCourse,
    required String? uidOwner,
    required String? uidMotivator,
  }) async {
    Get.customLoader();

    ActiveCourseModel object = ActiveCourseModel(
      uid: "",
      uidTrainingCourse: uidTrainingCourse,
      uidCourse: uidCourse,
      uidMotivator: uidMotivator,
      uidOwner: uidOwner,
      courseStatus: CourseStatus.notStarted,
      createdDate: DateTime.now().toString(),
    );

    try {
      await FirestoreActiveCourse.shared.addActiveCourse(course: object);
      Get.customSnackbar(
        title: "تم بنجاح",
        message: "موفق في اخذك للكورس",
      );
    } catch (e) {
      Get.customSnackbar(
        title: "خطأ",
        message: e.toString(),
        isError: true,
      );
    } finally {
      Get.customLoader(isShowLoader: false);
    }
  }

  void getMyTrainingCourseByStatus() async {
    items = await FirestoreActiveCourse.shared.getMyTrainingCourseByStatus(
        status: pageType == PageType.currentCourses
            ? CourseStatus.notStarted
            : CourseStatus.finished);

    for (var item in items) {
      if (item.uidMotivator != null) {
        item.motivator = await FirestoreUser.shared
            .getUserByUid(uid: item.uidMotivator ?? "");
      }

      if (item.uidTrainingCourse != null) {
        item.trainingCourse = await FirestoreTrainingCourse.shared
            .getUserByUid(uid: item.uidTrainingCourse ?? "");
        item.material = await FirestoreMaterial.shared
            .getMaterialByUid(uid: item.trainingCourse?.courseUid ?? "");
      }

      if (item.uidCourse != null) {
        item.material = await FirestoreMaterial.shared.getMaterialByUid(
            uid: item.trainingCourse?.courseUid ?? item.uidCourse ?? "");
      }
    }

    update();
  }

  void updateCourseStatus(
      {required ActiveCourseModel? course, required CourseStatus status}) {
    customAlertDialog(
      title: "انهاء الكورس",
      message: "هل أنت متأكد من انهاء الكورس؟",
      alertType: AlertType.warning,
      titleBtnOne: "أكيد",
      backgroundButtonOne: Colors.green,
      actionBtnOne: () async {
        FirestoreActiveCourse.shared
            .updateCourseStatus(uid: course?.uid ?? "", status: status);

        if (status == CourseStatus.finished) {
          Get.put(AuthViewModel()).updateCoursesFinishedCount();
        }

        await Future.delayed(const Duration(milliseconds: 500));

        Get.dialog(
          const Rating(),
        );

        Future.delayed(const Duration(milliseconds: 300), () {
          getMyTrainingCourseByStatus();
        });

        Get.customSnackbar(
          title: "تم بنجاح",
          message: "تم الانتهاء بنجاح",
          isError: false,
        );
      },
      actionBtnTwo: () {},
    );
  }

  void deleteCourse({required String uid}) {
    customAlertDialog(
      title: "حذف الكورس",
      message: "هل أنت متأكد من حذف الكورس؟",
      alertType: AlertType.warning,
      titleBtnOne: "حذف",
      backgroundButtonOne: Colors.red,
      actionBtnOne: () async {
        FirestoreActiveCourse.shared.deleteCourse(uid: uid);

        Future.delayed(const Duration(milliseconds: 300), () {
          getMyTrainingCourseByStatus();
        });

        Get.customSnackbar(
          title: "تم بنجاح",
          message: "تم الحذف بنجاح",
          isError: false,
        );
      },
      actionBtnTwo: () {},
    );
  }
}
