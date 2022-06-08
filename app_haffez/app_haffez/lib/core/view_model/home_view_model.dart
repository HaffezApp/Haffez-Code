import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_user.dart';
import 'package:haffez/model/user_model.dart';
import 'package:haffez/utils/enums/user_type.dart';

class HomeViewModel extends GetxController {
  List<UserModel> motivateds = [];

  List<UserModel> motivators = [];

  Future<void> getUsers() async {
    motivateds.clear();
    motivators.clear();

    List<UserModel> users = await FirestoreUser.shared.getUsers();

    for (var user in users) { 
      if (user.userType == UserType.motivated) {
        motivateds.add(user);
      } else {
        motivators.add(user);
      }
    }
// Sort from highest to lowest.
    motivateds.sort((a, b) {
      return (b.coursesFinishedCount ?? 0)
          .compareTo(a.coursesFinishedCount ?? 0);
    });

    motivators.sort((a, b) {
      return (b.coursesSupervisedCount ?? 0)
          .compareTo(a.coursesSupervisedCount ?? 0);
    });

    if (motivateds.length > 5) {
      motivateds = motivateds.sublist(0, 5);
    } else if (motivateds.length > 2) {
      motivateds = motivateds.sublist(0, motivateds.length - 1);
    }

    if (motivators.length > 5) {
      motivators = motivators.sublist(0, 5);
    } else if (motivators.length > 2) {
      motivators = motivators.sublist(0, motivators.length - 1);
    }

    update();
  }
}
