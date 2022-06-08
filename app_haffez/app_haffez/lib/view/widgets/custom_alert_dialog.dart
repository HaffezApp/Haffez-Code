import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

customAlertDialog({
  required String title,
  required String message,
  String titleBtnOne = "تم",
  String titleBtnTwo = "إلغاء",
  required VoidCallback actionBtnOne,
  required VoidCallback actionBtnTwo,
  AlertType? alertType,
  bool showBtnOne = true,
  bool showBtnTwo = true,
  Color? backgroundButtonOne,
  Color? backgroundButtonTwo,
}) {
  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  var alert = Alert(
    context: Get.context!,
    style: const AlertStyle(
      overlayColor: Colors.black54,
    ),
    type: alertType,
    alertAnimation: fadeAlertAnimation,
    title: title,
    desc: message,
    buttons: [],
  );

  DialogButton btnOne = DialogButton(
    color: backgroundButtonOne,
    child: Text(
      titleBtnOne,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ),
    onPressed: () {
      actionBtnOne();
      alert.dismiss();
    },
  );

  DialogButton btnTwo = DialogButton(
    color: backgroundButtonTwo,
    child: Text(
      titleBtnTwo,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ),
    onPressed: () {
      actionBtnTwo();
      alert.dismiss();
    },
  );

  if (showBtnTwo) {
    alert.buttons?.add(btnTwo);
  }

  if (showBtnOne) {
    alert.buttons?.add(btnOne);
  }

  alert.show();
}
