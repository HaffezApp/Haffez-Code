import 'dart:convert';

import 'package:haffez/utils/enums/course_platforms.dart';

MaterialModel materialModelFromJson(String str) =>
    MaterialModel.fromJson(json.decode(str));

String materialModelToJson(MaterialModel data) => json.encode(data.toJson());

class MaterialModel {
  MaterialModel({
    required this.uid,
    required this.uidCourse,
    required this.name,
    required this.platform,
    required this.rating,
    required this.courseUrl,
  });

  String? uid;
  String? uidCourse;
  String? name;
  CoursePlatforms? platform;
  double? rating;
  String? courseUrl;

  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
        uid: json["uid"],
        uidCourse: json["uid-course"],
        name: json["name"],
        platform: json["platform"] == null
            ? null
            : CoursePlatforms.values[json["platform"]],
        rating: json["rating"] != null ? json["rating"].toDouble() : 0,
        courseUrl: json["course-url"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uid-course": uidCourse,
        "name": name,
        "platform": platform?.index,
        "rating": rating,
        "course-url": courseUrl,
      };
}
