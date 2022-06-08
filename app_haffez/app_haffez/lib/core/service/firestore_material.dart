import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haffez/model/material_model.dart';

class FirestoreMaterial {
  static final FirestoreMaterial shared = FirestoreMaterial();

  final materialRef = FirebaseFirestore.instance.collection('Material');

//method 1
  Future<void> addMaterial({
    required MaterialModel material,
  }) async {
    material.uid = materialRef.doc().id;
    await materialRef.doc(material.uid).set(material.toJson()).catchError((e) {
      throw "حدث خطأ ما! يرجى المحاولة فيما بعد";
    });
  }

//method 2
  Future<MaterialModel> getMaterialByUid({required String uid}) async {
    var data = await materialRef.doc(uid).snapshots().first; //
    var tempData = MaterialModel.fromJson(data.data() ?? {});
    return tempData;
  }

//method 3

  Future<List<MaterialModel>> viewAllMaterialincorsepath(
      {required String uid}) {
    return materialRef
        .where("uid-course", isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return MaterialModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }

//method 4
  Future<List<MaterialModel>> getMaterialsByPlatform({required int platform}) {
    return materialRef
        .where("platform", isEqualTo: platform)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return MaterialModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).first;
  }
}
