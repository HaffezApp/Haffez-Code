import 'dart:convert';

import 'package:haffez/model/tracks_model.dart';
import 'package:haffez/utils/enums/gender.dart';
import 'package:haffez/utils/enums/user_type.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    required this.gender,
    required this.email,
    required this.track,
    required this.specialty,
    required this.userType,
    required this.coursesSupervisedCount,
    required this.rating,
    required this.coursesFinishedCount,
  });

  String? uid;
  String? name;
  String? email;
  Gender? gender;
  UserType? userType;
  String? track;
  String? specialty;
  int? coursesSupervisedCount;
  double? rating;
  int? coursesFinishedCount;
  TrackModel? trackObject;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        gender: Gender.values[json["gender"]],
        email: json["email"],
        track: json["track"],
        specialty: json["specialty"],
        userType: UserType.values[json["user-type"]],
        coursesSupervisedCount: json["courses-supervised-count"],
        rating: json["rating"],
        coursesFinishedCount: json["courses-finished-count"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "gender": gender?.index ?? 0,
        "track": track,
        "specialty": specialty,
        "user-type": userType?.index ?? 0,
        "courses-supervised-count": coursesSupervisedCount,
        "rating": rating,
        "courses-finished-count": coursesFinishedCount,
      };
}
