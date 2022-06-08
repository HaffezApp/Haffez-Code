import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_material.dart';
import 'package:haffez/model/material_model.dart';

class MaterialViewModel extends GetxController {
  String searchKeywordMaterial = "";
  List<MaterialModel> itemsSpMaterials = [];

  List<MaterialModel> searchItemsMaterials = [];

  List<MaterialModel> fillteredItems = [];
  //method 1
  void viewAllCoursesinPath({required String uid}) async {
    //uid for userS
    // method for found courcess by course user id
    itemsSpMaterials.clear();

    var tempData =
        await FirestoreMaterial.shared.viewAllMaterialincorsepath(uid: uid);

    for (var item in tempData) {
      itemsSpMaterials.add(item);
    }

    update();
  }

//method2
  void searchCourse({required String keyword}) {
    searchKeywordMaterial = keyword;
    searchItemsMaterials = itemsSpMaterials
        .where((value) =>
            value.name
                ?.toLowerCase()
                .contains(searchKeywordMaterial.toLowerCase()) ??
            false)
        .toList();
    update();
  }

//method3
  void getMaterialsByPlatform({required int platform}) async {
    fillteredItems.clear();

    var tempData = await FirestoreMaterial.shared
        .getMaterialsByPlatform(platform: platform);

    for (var item in tempData) {
      fillteredItems.add(item);
    }

    update();
  }
}
