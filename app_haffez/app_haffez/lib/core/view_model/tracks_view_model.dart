import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_course.dart';
import 'package:haffez/core/service/firestore_tracks.dart';
import 'package:haffez/model/course_model.dart';
import 'package:haffez/model/tracks_model.dart';

class TracksViewModel extends GetxController {
  List<TrackModel> items = [];

  void getTracks() async {
    items = await FirestoreTracks.shared.getTracks();

    for (var item in items) {
      List<CourseModel> courses = await FirestoreCourses.shared
          .getCoursesByTrackUid(uid: item.uid ?? "");
      item.courses = courses;
    }

    update();
  }
}
