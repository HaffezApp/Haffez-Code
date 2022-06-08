import 'package:flutter/cupertino.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/view/tab_bar/categories.dart';
import 'package:haffez/view/tab_bar/discussions_view.dart';
import 'package:haffez/view/tab_bar/home_view.dart';
import 'package:haffez/view/tab_bar/my_courses.dart';
import 'package:haffez/view/tab_bar/my_courses_motivator.dart';
import 'package:haffez/view/tab_bar/my_schedule.dart';
import 'package:haffez/view/tab_bar/my_track.dart';

enum TabBarItem {
  home,
  tracks,
  mySchedule,
  discussions,
  myCourses,
  myCoursesMotivator,
  myTrack,
}

extension TabBarItemExtension on TabBarItem {
  String get title {
    switch (this) {
      case TabBarItem.home:
        return "الصفحة الرئيسية";
      case TabBarItem.tracks:
        return "المسارات";
      case TabBarItem.myTrack:
        return "مساري";
      case TabBarItem.mySchedule:
        return "جدولي";
      case TabBarItem.discussions:
        return "المناقشات";
      case TabBarItem.myCourses:
        return "كورساتي";
      case TabBarItem.myCoursesMotivator:
        return "كورساتي";
    }
  }

  String get icon {
    switch (this) {
      case TabBarItem.home:
        return Assets.shared.icHome;
      case TabBarItem.tracks:
        return Assets.shared.icTracks;
      case TabBarItem.mySchedule:
        return Assets.shared.icMySchedule;
      case TabBarItem.discussions:
        return Assets.shared.icDiscussions;
      case TabBarItem.myCourses:
        return Assets.shared.icMyCourses;
      case TabBarItem.myCoursesMotivator:
        return Assets.shared.icMyCourses;
      case TabBarItem.myTrack:
        return Assets.shared.icTracks;
    }
  }

  Widget get screen {
    switch (this) {
      case TabBarItem.home:
        return HomeView();
      case TabBarItem.tracks:
        return Categories();
      case TabBarItem.mySchedule:
        return MyScheduleView();
      case TabBarItem.discussions:
        return DiscussionsView();
      case TabBarItem.myCourses:
        return MyCoursesView();
      case TabBarItem.myCoursesMotivator:
        return MyCoursesMotivator();
      case TabBarItem.myTrack:
        return MyTrackView();
    }
  }
}
