import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haffez/model/active_course.dart';
import 'package:haffez/utils/enums/course_status.dart';
import 'package:haffez/utils/user_profile.dart';

class FirestoreActiveCourse {
  static final FirestoreActiveCourse shared = FirestoreActiveCourse();

  final courseRef = FirebaseFirestore.instance.collection('Active_course');

  Future<void> addActiveCourse({
    required ActiveCourseModel course,
  }) async {
    course.uid = courseRef.doc().id;
    await courseRef.doc(course.uid).set(course.toJson()).catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

  Future<List<ActiveCourseModel>> getActiveTrainingCourse(
      {required String uid}) {
    return courseRef
        .where("uid-training-course", isEqualTo: uid)
        .where("status", isEqualTo: CourseStatus.started)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return ActiveCourseModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  Future<List<ActiveCourseModel>> getMyTrainingCourseByStatus({
    required CourseStatus status,
  }) {
    return courseRef
        .where("uid-owner",
            isEqualTo: UserProfile.shared.currentUser?.uid ?? "")
        .where("course-status", isEqualTo: status.index)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return ActiveCourseModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  void updateCourseStatus({required String uid, required CourseStatus status}) {
    courseRef.doc(uid).update({
      "course-status": status.index,
    });
  }

  void deleteCourse({required String uid}) {
    courseRef.doc(uid).delete();
  }
}
