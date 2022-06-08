import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haffez/utils/user_profile.dart';

class FirestoreSchedule {
  static final FirestoreSchedule shared = FirestoreSchedule();

  final scheduleRef = FirebaseFirestore.instance.collection('Schedule');

  Future<void> addCellInSchedule(
      {required int index, required String value}) async {
    var doc =
        await scheduleRef.doc(UserProfile.shared.currentUser?.uid ?? "").get();

    if (!doc.exists) {
      await scheduleRef.doc(UserProfile.shared.currentUser?.uid ?? "").set({});
    }

    await scheduleRef
        .doc(UserProfile.shared.currentUser?.uid ?? "")
        .update({index.toString(): value}).catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

  Future<Map<String, dynamic>> getSchedule() async {
    return (await scheduleRef
                .doc(UserProfile.shared.currentUser?.uid ?? "")
                .snapshots()
                .first)
            .data() ??
        {};
  }

  void emptyTable() {
    scheduleRef.doc(UserProfile.shared.currentUser?.uid ?? "").delete();
  }
}
