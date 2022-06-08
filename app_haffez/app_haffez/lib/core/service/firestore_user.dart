import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haffez/model/user_model.dart';
import 'package:haffez/utils/user_profile.dart';

class FirestoreUser {
  static final FirestoreUser shared = FirestoreUser();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection('User');

  Future<UserModel?> getUserByUid({required String uid}) async {
    UserModel userTemp;
    var user = await userRef.doc(uid).snapshots().first;
    userTemp = UserModel.fromJson(user.data() ?? {});
    return userTemp;
  }

  Future<List<UserModel>> getUsers() {
    return userRef.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

  Future<void> addUser({
    required UserModel user,
  }) async {
    await FirestoreUser.shared.userRef
        .doc(user.uid)
        .set(user.toJson())
        .catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

  void updateProfile({required String name}) {
    userRef.doc(UserProfile.shared.currentUser?.uid ?? "").update({
      "name": name,
    });
  } // coursesFinishedCount

  Future<void> updateCoursesSupervisedCount() async {
    UserModel? user = await FirestoreUser.shared
        .getUserByUid(uid: UserProfile.shared.currentUser?.uid ?? "");

    userRef.doc(UserProfile.shared.currentUser?.uid ?? "").update({
      "courses-supervised-count": (user?.coursesSupervisedCount ?? 0) + 1,
    });
  }

  Future<void> updateCoursesFinishedCount() async {
    UserModel? user = await FirestoreUser.shared
        .getUserByUid(uid: UserProfile.shared.currentUser?.uid ?? "");

    userRef.doc(UserProfile.shared.currentUser?.uid ?? "").update({
      "courses-finished-count": (user?.coursesFinishedCount ?? 0) + 1,
    });
  }
}
