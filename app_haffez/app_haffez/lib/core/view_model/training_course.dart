import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_material.dart';
import 'package:haffez/core/service/firestore_training_course.dart';
import 'package:haffez/core/service/firestore_user.dart';
import 'package:haffez/core/view_model/auth.dart';
import 'package:haffez/main.dart';
import 'package:haffez/model/training_course.dart';
import 'package:haffez/utils/enums/course_status.dart';
import 'package:haffez/utils/enums/page_type.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/widgets/custom_alert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../view/members_view.dart';

class TrainingCourseViewModel extends GetxController {
  PageType pageType = PageType.currentCourses;

  String? details, urlGroup, courseUid, uidOwner;

  int? memberCount;

  DateTime? dateStart;

  List<TrainingCourse> items = [];
//method1
  void changePageType({required PageType pageType}) {
    if (this.pageType == pageType) {
      return;
    }

    this.pageType = pageType;

    getCoursesByUidOwnerWithStatus();

    update();
  }

//method2
  void changeAcceptValue({required bool value}) {
    isAccept = value;
    update();
  }

  //method3
  Future<void> selectDateStart() async {
    final DateTime? newDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (newDate != null) {
      dateStart = newDate;
      update();
    }
  }

  bool? isAccept;
  bool _validation() {
    return !((details == null || details?.trim() == "") ||
        (urlGroup == null || urlGroup?.trim() == "") ||
        memberCount == null ||
        dateStart == null);
  }

//method4
  Future<void> addCourse() async {
    //cheak 1
    if (!_validation()) {
      Get.customSnackbar(
        title: "خطأ",
        message: "يرجى إدخال جميع الحقول",
        isError: true,
      );
      return;
    }
    //cheak2 for sah
    if (isAccept == null || isAccept == false) {
      Get.customSnackbar(
        title: "خطأ",
        message: "يرجى وضع صح امام الشرط",
        isError: true,
      );
      return;
    }
    //cheak3
    if (!GetUtils.isURL(urlGroup ?? "")) {
      Get.customSnackbar(
        title: "خطأ",
        message: "يرجى إدخال رابط صحيح",
        isError: true,
      );
      return;
    }

    Navigator.of(NavigationService.navigatorKey.currentContext!).pop();

    Get.customLoader();
    TrainingCourse object = TrainingCourse(
      uid: "",
      details: details,
      startDate: dateStart.toString(),
      groupCount: memberCount,
      courseUid: courseUid,
      groupUrl: urlGroup,
      dateCreated: DateTime.now().toString(),
      createdBy: UserProfile.shared.currentUser?.uid ?? "",
      courseStatus: CourseStatus.notStarted,
    );

    try {
      await FirestoreTrainingCourse.shared.courseForm(course: object);
      Future.delayed(const Duration(), () {
        Get.back();
        getCoursesByUidOwnerWithStatus();

        Get.customSnackbar(
          title: "تمت الاضافة بنجاح",
          message: "موفق في اشرافك للكورس",
        );
      });
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

  //method5
  Future<void> getCoursesByUidCourse({required String uidCourse}) async {
    var data = await FirestoreTrainingCourse.shared
        .getCoursesByUidCourse(uidCourse: uidCourse);

    data.removeWhere((course) => course.courseStatus == CourseStatus.finished);

    for (var item in data) {
      item.course = await FirestoreMaterial.shared
          .getMaterialByUid(uid: item.courseUid ?? "");
      item.owner =
          await FirestoreUser.shared.getUserByUid(uid: item.createdBy ?? "");
    }

    items = data;

    update();
  }

  //method6
  //for addcourseform
  Future<void> getCoursesByUidOwnerWithStatus() async {
    var data =
        await FirestoreTrainingCourse.shared.getCoursesByUidOwnerWithStatus(
            uidOwner: uidOwner ?? "",
            status: pageType == PageType.currentCourses
                ? CourseStatus.notStarted //الحالية
                : CourseStatus.finished); //المنتهية

    for (var item in data) {
      item.course = await FirestoreMaterial.shared
          .getMaterialByUid(uid: item.courseUid ?? "");
    }

    items = data;

    update();
  }

  //method7
  void updateCourseStatus(
      {required TrainingCourse course, required CourseStatus status}) {
    customAlertDialog(
      title: "تأكيد العملية",
      message: "هل أنت متأكد إتمام العملية؟",
      alertType: AlertType.warning,
      titleBtnOne: "أكيد",
      backgroundButtonOne: Colors.green,
      actionBtnOne: () async {
        FirestoreTrainingCourse.shared
            .updateCourseStatus(uid: course.uid ?? "", status: status);

        if (status == CourseStatus.finished) {
          Get.put(AuthViewModel()).updateCoursesSupervisedCount();
        }

        await Future.delayed(const Duration(milliseconds: 500));

        Get.to(() => MembersView(
              trainingCourse: course,
            ));

        Future.delayed(const Duration(milliseconds: 300), () {
          getCoursesByUidOwnerWithStatus();
        });

        Get.customSnackbar(
          title: "تم بنجاح",
          message: "تم بنجاح",
          isError: false,
        );
      },
      actionBtnTwo: () {},
    );
  }
}
