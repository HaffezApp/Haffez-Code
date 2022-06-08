import 'dart:convert';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  CourseModel({
    required this.uid,
    required this.uidTrack,
    required this.name,
  });

  String? uid;
  String? uidTrack;
  String? name;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        uid: json["uid"],
        uidTrack: json["uid-track"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uid-track": uidTrack,
        "name": name,
      };
}
