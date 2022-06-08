import 'dart:convert';

import 'package:haffez/model/user_model.dart';
import 'package:haffez/utils/enums/course_status.dart';

import 'material_model.dart';

TrainingCourse trainingCourseFromJson(String str) =>
    TrainingCourse.fromJson(json.decode(str));

String trainingCourseToJson(TrainingCourse data) => json.encode(data.toJson());

class TrainingCourse {
  TrainingCourse({
    required this.uid,
    required this.details,
    required this.startDate,
    required this.groupCount,
    required this.courseUid,
    required this.groupUrl,
    required this.dateCreated,
    required this.createdBy,
    required this.courseStatus,
  });

  String? uid;
  String? details;
  String? startDate;
  int? groupCount;
  String? courseUid;
  MaterialModel? course;
  String? groupUrl;
  String? dateCreated;
  String? createdBy;
  UserModel? owner;
  CourseStatus? courseStatus;

  factory TrainingCourse.fromJson(Map<String, dynamic> json) => TrainingCourse(
        uid: json["uid"],
        details: json["details"],
        startDate: json["start-date"],
        groupCount: json["group-count"],
        courseUid: json["course-uid"],
        groupUrl: json["group-url"],
        dateCreated: json["date-created"],
        createdBy: json["created-by"],
        courseStatus: json["course-status"] == null
            ? null
            : CourseStatus.values[json["course-status"]],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "details": details,
        "start-date": startDate,
        "group-count": groupCount,
        "course-uid": courseUid,
        "group-url": groupUrl,
        "date-created": dateCreated,
        "created-by": createdBy,
        "course-status": courseStatus?.index,
      };
}
