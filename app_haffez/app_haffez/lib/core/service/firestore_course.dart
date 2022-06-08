import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haffez/model/course_model.dart';

class FirestoreCourses {
  static final FirestoreCourses shared = FirestoreCourses();

  final coursesRef = FirebaseFirestore.instance.collection('Courses');
  //ميثود 1
  Future<void> addCourse({
    required CourseModel course,
  }) async {
    course.uid = coursesRef.doc().id;
    await coursesRef.doc(course.uid).set(course.toJson()).catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

  //ميثود 2
//for msar
  Future<CourseModel> viewFilterPath({required String uid}) async {
    var data = await coursesRef.doc(uid).snapshots().first;
    var tempData = CourseModel.fromJson(data.data() ?? {});
    return tempData;
  }

//ميثود 3
  Future<List<CourseModel>> getCoursesByTrackUid({required String uid}) {
    return coursesRef
        .where("uid-track", isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return CourseModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }
}