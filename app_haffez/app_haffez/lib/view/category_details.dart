import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/material_view_model.dart';
import 'package:haffez/model/course_model.dart';
import 'package:haffez/model/material_model.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/enums/course_platforms.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'course/course_view.dart';

class CategoryDetails extends StatelessWidget {
  final CourseModel? course;

  CategoryDetails({
    Key? key,
    required this.course,
  }) : super(key: key);

  final MaterialViewModel controller = Get.put(MaterialViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.h,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Column(
          children: [
            CustomText(
              text: course?.name ?? "", // اسم التخصص الدقيق
              fontSize: 18,
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                onChanged: (value) =>
                    controller.searchCourse(keyword: value.trim()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ابحث عن الدورة اللي تبيها",
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 16.r,
                      color: const Color(0xff818181),
                    ),
                    suffixIcon: Visibility(
                      visible: false,
                      child: Icon(
                        Icons.search_rounded,
                        size: 16.r,
                        color: const Color(0xff818181),
                      ),
                    )),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: GetBuilder<MaterialViewModel>(
        init: MaterialViewModel(),
        initState: (_) {
          controller.viewAllCoursesinPath(uid: course?.uid ?? "");
        },
        builder: (controller) {
          return GridView.count(
            padding: EdgeInsets.all(20.r),
            crossAxisCount: 3, // حددت 3 اعمده لصفحة
            crossAxisSpacing: 15.r,
            childAspectRatio: 0.30.r,
            children: List.generate(
                controller.searchKeywordMaterial == ""
                    ? controller.itemsSpMaterials.length
                    : controller.searchItemsMaterials.length, (index) {
              return _ItemCell(
                material: controller.searchKeywordMaterial == ""
                    ? controller.itemsSpMaterials[index]
                    : controller.searchItemsMaterials[index],
              );
            }),
          );
        },
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  final MaterialModel material;

  const _ItemCell({Key? key, required this.material}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        // صفحة المحفزين (مشرفين الدورة)
        () => CourseView(
          material: material,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 110.r,
                width: 110.r,
                decoration: BoxDecoration(
                  color: const Color(0xfff6f6f6),
                 borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Assets.shared.primaryColor,),
                ),
                child: CustomText(
                  text: material.name ?? "", // اسم الدورة
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  textColor: Assets.shared.primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: CustomText(
                  text: "التفاصيل",
                  textColor: Assets.shared.secondaryColor,
                  fontSize: 12,
                  alignment: Alignment.topRight,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              const CustomText(
                text: " اسم الكورس :",
                fontSize: 12,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
              //  البيانات الي تحت كل دوره
              CustomText(
                text: (material.name?.length ?? 0) > 50 // conditon
                    ? ((material.name?.substring(0, 30) ?? "") + "...")
                    : material.name ?? "",
                fontSize: 12,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              const CustomText(
                text: "الموقع :",
                fontSize: 12,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () {
                  try {
                    launch(material.courseUrl ?? "");
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: CustomText(
                  text: material.platform?.title ?? "", // اسم المنصة
                  fontSize: 12,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                  textColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              const CustomText(
                text: "تقييم المتحفزين",
                fontSize: 12,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5.h,
              ),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 15.r,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}