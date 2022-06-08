import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haffez/model/tracks_model.dart';

class FirestoreTracks {
  static final FirestoreTracks shared = FirestoreTracks();

  final tracksRef = FirebaseFirestore.instance.collection('Tracks');

  Future<void> addTrack({
    required TrackModel track,
  }) async {
    track.uid = tracksRef.doc().id;
    await tracksRef.doc(track.uid).set(track.toJson()).catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

  Future<TrackModel?> getTrackByUid({required String uid}) async {
    if (uid == "") {
      return null;
    }

    TrackModel trackTemp;
    var user = await tracksRef.doc(uid).snapshots().first;
    trackTemp = TrackModel.fromJson(user.data() ?? {});
    return trackTemp;
  }

  Future<List<TrackModel>> getTracks() {
    return tracksRef.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return TrackModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }
}
