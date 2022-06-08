import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_course.dart';
import 'package:haffez/core/service/firestore_tracks.dart';
import 'package:haffez/core/service/firestore_user.dart';
import 'package:haffez/model/course_model.dart';
import 'package:haffez/model/tracks_model.dart';
import 'package:haffez/model/user_model.dart';
import 'package:haffez/utils/enums/gender.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/auth/auth_view.dart';
import 'package:haffez/view/auth/sign_in_view.dart';
import 'package:haffez/view/tab_bar/main_tab_bar_view.dart';
import 'package:haffez/view/widgets/custom_alert_sheet.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../view/widgets/custom_alert_dialog.dart';

class AuthViewModel extends GetxController {
  String? name, email, password;
  Gender? gender;
  TrackModel? selectedTrack;
  CourseModel? selectedSpecialty;

  List<TrackModel> tracks = [];

  List<CourseModel> specialties = [];

  Future<void> getTracks() async {
    tracks = await FirestoreTracks.shared.getTracks(); //حاسب، هندسة، ادارة
    update();
  }

  Future<void> getCourses() async {
    specialties = await FirestoreCourses.shared.getCoursesByTrackUid(
        uid: selectedTrack?.uid ?? ""); // التخصصات WebProg, AppProg, Networking
    update();
  }

  void selectGender({required Gender gender}) {
    this.gender = gender;
    update();
  }

  void selectTrack() {
    customAlertSheet(
      title: "إختر المسار",
      items: tracks.map((e) => e.name.toString()).toList(),
      onTap: (index, _) {
        selectedTrack = tracks[index]; // the whole obj
        update();
        getCourses(); // get the courses based on the selected track uid
      },
    );
  }

  void selectSpecialty() {
    customAlertSheet(
      title: "إختر التخصص",
      items: specialties.map((e) => e.name.toString()).toList(),
      onTap: (index, _) {
        selectedSpecialty = specialties[index];
        update();
      },
    );
  }

  void signInWithEmailAndPassword() async {
    Get.customLoader();
    try {
      await FirestoreUser.shared.auth.signInWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );

      ///To get user then trnasformed it to home screen
      UserModel? user = await FirestoreUser.shared
          .getUserByUid(uid: FirestoreUser.shared.auth.currentUser?.uid ?? "");

      if (user == null) {
        Get.customSnackbar(
          title: "خطأ",
          message: "لا يمكن تسجيل الدخول لهذا الحساب",
          isError: true,
        );
        return;
      }

      Get.customLoader(isShowLoader: false);

      UserProfile.shared.currentUser = user;
      UserProfile.shared.setUser(user: user);

      Get.offAll(() => const MainTabBarView());
    } on FirebaseAuthException catch (e) {
      Get.customLoader(isShowLoader: false);

      String? message;
      if (e.code == 'user-not-found') {
        message = "المستخدم غير موجود";
      } else if (e.code == 'wrong-password') {
        message = "كلمة المرور خاطئة";
      } else if (e.code == 'too-many-requests') {
        message = "تم قفل الحساب بشكل مؤقت";
      } else {
        message = "حدث خطأ ما! يرجى المحاولة فيما بعد";
      }

      Get.customSnackbar(
        title: "خطأ",
        message: message,
        isError: true,
      );
    } finally {
      Get.customLoader(isShowLoader: false);
    }
  }

  Future<String?> _createAccountInFirebase() async {
    try {
      UserCredential userCredential =
          await FirestoreUser.shared.auth.createUserWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );

      ///userCredential >> have user data  >> will assign the userId increateAccountWithEmailAndPassword method
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      String? message;

      if (e.code == "email-already-in-use") {
        message = "البريد الإلكتروني مستخدم من قبل";
      } else {
        message = "حدث خطأ ما! يرجى المحاولة فيما بعد";
      }

      Get.customSnackbar(
        title: "خطأ",
        message: message,
        isError: true,
      );

      throw message;
    } catch (e) {
      Get.customSnackbar(
        title: "خطأ",
        message: "حدث خطأ ما! يرجى المحاولة فيما بعد",
        isError: true,
      );
    }
    return null;
  }

  void createAccountWithEmailAndPassword() async {
    Get.customLoader();
    String? userId;

    try {
      userId = await _createAccountInFirebase();
    } catch (_) {
      Get.customLoader(isShowLoader: false);
      return;
    }

    if (userId != null) {
      try {
        UserModel user = UserModel(
          uid: userId,
          name: name,
          gender: gender,
          email: email,
          userType: UserProfile.shared.userType,
          track: selectedTrack?.uid,
          specialty: selectedSpecialty?.uid,
          coursesFinishedCount: 0,
          coursesSupervisedCount: 0,
          rating: 0,
        );

        /// Add User in Firebase
        await FirestoreUser.shared.addUser(
          user: user,
        );

        signInWithEmailAndPassword();
      } catch (e) {
        Get.customSnackbar(
          title: "خطأ",
          message: e.toString(),
          isError: true,
        );
      } finally {
        Get.customLoader(isShowLoader: false);
      }
    }
  }

  Future<void> forgotPassword() async {
    Get.customLoader();
    try {
      await FirestoreUser.shared.auth.sendPasswordResetEmail(
        email: email ?? "",
      );
      Get.customSnackbar(
        title: "تم بنجاح",
        message: "تم إرسال رابط تعيين كلمة المرور الى $email",
      );

      Get.offAll(() => SignInView());
    } on FirebaseAuthException catch (e) {
      Get.customLoader(isShowLoader: false);

      String? message;
      if (e.code == 'user-not-found') {
        message = "المستخدم غير موجود";
      } else if (e.code == 'wrong-password') {
        message = "كلمة المرور خاطئة";
      } else if (e.code == 'too-many-requests') {
        message = "تم قفل الحساب بشكل مؤقت";
      } else {
        message = "حدث خطأ ما! يرجى المحاولة فيما بعد";
      }

      Get.customSnackbar(
        title: "خطأ",
        message: message,
        isError: true,
      );
    } catch (e) {
      Get.customSnackbar(
        title: "خطأ",
        message: "حدث خطأ ما! يرجى إعادة المحاولة فيما بعد",
        isError: true,
      );
    } finally {
      Get.customLoader(isShowLoader: false);
    }
  }

  void updateCurrentUser() async {
    UserModel? user = await FirestoreUser()
        .getUserByUid(uid: UserProfile.shared.currentUser?.uid ?? "");
    UserProfile.shared.currentUser = user;
    UserProfile.shared.setUser(user: user);
    update(); //Like setState, تسوي ابديت للودجيت لحالو
  }

  void updateProfile() {
    if (name == "") {
      Get.customSnackbar(
        title: "خطأ",
        message: "يرجى إدخال جميع الحقول",
        isError: true,
      );
      return;
    }

    FirestoreUser.shared.updateProfile(name: name ?? "");

    Future.delayed(
        const Duration(milliseconds: 300), () => updateCurrentUser());

    Get.customSnackbar(
      title: "تم بنجاح",
      message: "تم بنجاح",
      isError: false,
    );
  }

  void updateCoursesSupervisedCount() {
    FirestoreUser.shared.updateCoursesSupervisedCount();

    Future.delayed(
        const Duration(milliseconds: 300), () => updateCurrentUser());
  }

  void updateCoursesFinishedCount() {
    FirestoreUser.shared.updateCoursesFinishedCount();

    Future.delayed(
        const Duration(milliseconds: 300), () => updateCurrentUser());
  }

  void signOut() async {
    customAlertDialog(
      title: "تسجيل الخروج",
      message: "هل أنت متأكد من تسجيل الخروج؟",
      alertType: AlertType.warning,
      titleBtnOne: "خروج",
      backgroundButtonOne: Colors.green,
      actionBtnOne: () async {
        try {
          await FirebaseAuth.instance.signOut();
          UserProfile.shared.setUser(user: null);
          Get.offAll(() => const AuthView());
        } catch (_) {
          Get.customSnackbar(
            title: "خطأ",
            message: "حدث خطأ ما! يرجى المحاولة فيما بعد",
            isError: true,
          );
        }
      },
      actionBtnTwo: () {},
    );
  }
}
