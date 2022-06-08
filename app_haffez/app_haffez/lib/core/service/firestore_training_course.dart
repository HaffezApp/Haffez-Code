import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haffez/model/training_course.dart';
import 'package:haffez/utils/enums/course_status.dart';

class FirestoreTrainingCourse {
  static final FirestoreTrainingCourse shared = FirestoreTrainingCourse();

  final courseRef = FirebaseFirestore.instance.collection('Training_Course');

  //method1
  Future<void> courseForm({
    required TrainingCourse course,
  }) async {
    course.uid = courseRef.doc().id;
    await courseRef.doc(course.uid).set(course.toJson()).catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

  //method2
  Future<List<TrainingCourse>> getCoursesByUidOwnerWithStatus({
    required String uidOwner,
    required CourseStatus status,
  }) {
    return courseRef
        .where("created-by", isEqualTo: uidOwner)
        .where("course-status", isEqualTo: status.index)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return TrainingCourse.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  //method3
  Future<List<TrainingCourse>> getCoursesByUidCourse(
      {required String uidCourse}) {
    return courseRef
        .where("course-uid", isEqualTo: uidCourse)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return TrainingCourse.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  void updateCourseStatus({required String uid, required CourseStatus status}) {
    courseRef.doc(uid).update({
      "course-status": status.index,
    });
  }

  //metod4
  Future<TrainingCourse?> getUserByUid({required String uid}) async {
    TrainingCourse tempData;
    var course = await courseRef.doc(uid).snapshots().first;
    tempData = TrainingCourse.fromJson(course.data() ?? {});
    return tempData;
  }
}