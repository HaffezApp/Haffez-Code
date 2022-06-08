import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_schedule.dart';
import 'package:haffez/utils/extenstion.dart';

class ScheduleViewModel extends GetxController {
  Map<String, dynamic> data = {};

  Future<void> getSchedule() async {
    data = await FirestoreSchedule.shared.getSchedule();
    update();
  }

  Future<void> addOrEditCellInSchedule(
      {required int index, required String value}) async {
    await FirestoreSchedule.shared
        .addCellInSchedule(index: index, value: value);

    Get.customSnackbar(
      title: "تم بنجاح",
      message: "تم بنجاح",
    );

    getSchedule();
  }

  void emptyTable() {
    FirestoreSchedule.shared.emptyTable();
    Get.customSnackbar(
      title: "تم بنجاح",
      message: "تم بنجاح",
    );
    getSchedule();
  }
}
