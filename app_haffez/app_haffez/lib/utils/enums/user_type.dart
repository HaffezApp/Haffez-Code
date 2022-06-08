import 'package:haffez/utils/enums/tab_bar_item.dart';

enum UserType {
  motivated, // متحفز
  motivator, // محفز
}

extension UserTypeExtension on UserType {
  List<TabBarItem> get tabBarItems {
    switch (this) {
      case UserType.motivated:
        return [
          TabBarItem.home,
          TabBarItem.tracks,
          TabBarItem.mySchedule,
          TabBarItem.discussions,
          TabBarItem.myCourses,
        ];
      case UserType.motivator:
        return [
          TabBarItem.home,
          TabBarItem.myTrack,
          TabBarItem.mySchedule,
          TabBarItem.myCoursesMotivator,
        ];
    }
  }
}
