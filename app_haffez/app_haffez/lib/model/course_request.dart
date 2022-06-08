import 'dart:convert';

import 'package:haffez/model/user_model.dart';
import 'package:haffez/utils/enums/status.dart';

CourseRequestModel courseRequestModelFromJson(String str) =>
    CourseRequestModel.fromJson(json.decode(str));

String courseRequestModelToJson(CourseRequestModel data) =>
    json.encode(data.toJson());

class CourseRequestModel {
  CourseRequestModel({
    required this.uid,
    required this.uidTrainingCourse,
    required this.uidOwner,
    required this.status,
    required this.createdDate,
    required this.uidMotivator,
  });

  String? uid;
  String? uidTrainingCourse;
  String? uidOwner;
  Status? status;
  String? createdDate;
  String? uidMotivator;
  UserModel? owner;

  factory CourseRequestModel.fromJson(Map<String, dynamic> json) =>
      CourseRequestModel(
        uid: json["uid"],
        uidTrainingCourse: json["uid-training-course"],
        uidOwner: json["uid-owner"],
        status: Status.values[json["status"]],
        createdDate: json["created-date"],
        uidMotivator: json["uid-motivator"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uid-training-course": uidTrainingCourse,
        "uid-owner": uidOwner,
        "status": status?.index,
        "created-date": createdDate,
        "uid-motivator": uidMotivator,
      };
}
