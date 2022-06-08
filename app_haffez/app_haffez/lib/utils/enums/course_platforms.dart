import 'package:haffez/utils/assets.dart';

enum CoursePlatforms {
  udemy,
  satr,
  edraak,
  coursera,
  coursat,
  skillShare,
  m3aarf,
}

extension CoursePlatformsExtension on CoursePlatforms {
  String get image {
    switch (this) {
      case CoursePlatforms.udemy:
        return Assets.shared.icUdemy;
      case CoursePlatforms.satr:
        return Assets.shared.icSatr;
      case CoursePlatforms.edraak:
        return Assets.shared.icEdraak;
      case CoursePlatforms.coursera:
        return Assets.shared.icCoursera;
      case CoursePlatforms.coursat:
        return Assets.shared.icCoursat;
      case CoursePlatforms.skillShare:
        return Assets.shared.icSkillShare;
      case CoursePlatforms.m3aarf:
        return Assets.shared.icM3aarf;
    }
  }

  String get title {
    switch (this) {
      case CoursePlatforms.udemy:
        return "يوديمي";
      case CoursePlatforms.satr:
        return "سطر";
      case CoursePlatforms.edraak:
        return "إدراك";
      case CoursePlatforms.coursera:
        return "كورسيرا";
      case CoursePlatforms.coursat:
        return "كورسات";
      case CoursePlatforms.skillShare:
        return "سكل شير";
      case CoursePlatforms.m3aarf:
        return "معارف";
    }
  }

  // String get url {
  //   switch (this) {
  //     case CoursePlatforms.udemy:
  //       return "https://www.udemy.com/";
  //     case CoursePlatforms.satr:
  //       return "https://satr.codes/";
  //     case CoursePlatforms.edraak:
  //       return "https://www.edraak.org/";
  //     case CoursePlatforms.coursera:
  //       return "https://www.coursera.org/";
  //     case CoursePlatforms.coursat:
  //       return "https://www.coursat.org/";
  //     case CoursePlatforms.skillShare:
  //       return "https://www.skillshare.com/";
  //     case CoursePlatforms.m3aarf:
  //       return "https://www.m3aarf.com/";
  //   }
  // }
}
