import 'dart:convert';

import 'course_model.dart';

TrackModel trackModelFromJson(String str) =>
    TrackModel.fromJson(json.decode(str));

String trackModelToJson(TrackModel data) => json.encode(data.toJson());

class TrackModel {
  TrackModel({
    required this.uid,
    required this.name,
    required this.dateCreated,
    this.courses,
  });

  String? uid;
  String? name;
  String? dateCreated;
  List<CourseModel>? courses;

  factory TrackModel.fromJson(Map<String, dynamic> json) => TrackModel(
        uid: json["uid"],
        name: json["name"],
        dateCreated: json["date-created"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "date-created": dateCreated,
      };
}
