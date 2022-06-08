import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haffez/model/course_request.dart';
import 'package:haffez/utils/enums/status.dart';

class FirestoreCourseRequest {
  static final FirestoreCourseRequest shared = FirestoreCourseRequest();

  final courseRequestRef =
      FirebaseFirestore.instance.collection('Course_Request');

  Future<void> addCourseRequest({
    required CourseRequestModel courseRequest,
  }) async {
    courseRequest.uid = courseRequestRef.doc().id;
    await courseRequestRef
        .doc(courseRequest.uid)
        .set(courseRequest.toJson())
        .catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

  Future<List<CourseRequestModel>> getRequestByTrainingCourse(
      {required String uid}) {
    return courseRequestRef
        .where("uid-training-course", isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return CourseRequestModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  Future<List<CourseRequestModel>> getRequestTrainingCourse({
    required String uid,
  }) {
    return courseRequestRef
        .where("uid-training-course", isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return CourseRequestModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  void updateRequestStatus({required String uid, required Status status}) {
    courseRequestRef.doc(uid).update({
      "status": status.index,
    });
  }
}
