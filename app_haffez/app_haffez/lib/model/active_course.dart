import 'dart:convert';

import 'package:haffez/model/training_course.dart';
import 'package:haffez/model/user_model.dart';
import 'package:haffez/utils/enums/course_status.dart';

import 'material_model.dart';

ActiveCourseModel activeCourseModelFromJson(String str) =>
    ActiveCourseModel.fromJson(json.decode(str));

String activeCourseModelToJson(ActiveCourseModel data) =>
    json.encode(data.toJson());

class ActiveCourseModel {
  ActiveCourseModel({
    required this.uid,
    required this.uidTrainingCourse,
    required this.uidMotivator,
    required this.uidOwner,
    required this.courseStatus,
    required this.createdDate,
    required this.uidCourse,
  });

  String? uid;
  String? uidTrainingCourse;
  String? uidMotivator;
  String? uidOwner;
  CourseStatus? courseStatus;
  String? createdDate;
  String? uidCourse;
  UserModel? motivator;
  MaterialModel? material;
  TrainingCourse? trainingCourse;

  factory ActiveCourseModel.fromJson(Map<String, dynamic> json) =>
      ActiveCourseModel(
        uid: json["uid"],
        uidTrainingCourse: json["uid-training-course"],
        uidCourse: json["uid-course"],
        uidMotivator: json["uid-motivator"],
        uidOwner: json["uid-owner"],
        courseStatus: CourseStatus.values[json["course-status"]],
        createdDate: json["created-date"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uid-training-course": uidTrainingCourse,
        "uid-motivator": uidMotivator,
        "uid-owner": uidOwner,
        "course-status": courseStatus?.index,
        "created-date": createdDate,
        "uid-course": uidCourse,
      };
}
