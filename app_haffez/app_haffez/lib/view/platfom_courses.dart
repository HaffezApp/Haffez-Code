import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/material_view_model.dart';
import 'package:haffez/model/material_model.dart';
import 'package:haffez/utils/enums/course_platforms.dart';
import 'package:haffez/utils/enums/user_type.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/widgets/course_form.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/assets.dart';
import 'course/course_view.dart';
import 'widgets/main_drawer.dart';

class PlatformCoursesView extends StatelessWidget {
  final MaterialViewModel controller = Get.put(MaterialViewModel());

  int platformIndex;
  String platformName;

  PlatformCoursesView({
    Key? key,
    required this.platformIndex,
    required this.platformName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.h,
        iconTheme: const IconThemeData(color: Colors.black),
        title: CustomText(
          text: platformName,
          fontSize: 18,
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
          controller.getMaterialsByPlatform(
            platform: platformIndex,
          );
        },
        builder: (controller) {
          return GridView.count(
            padding: EdgeInsets.all(20.r),
            crossAxisCount: 3,
            crossAxisSpacing: 15.r,
            childAspectRatio: 0.30.r,
            children: List.generate(controller.fillteredItems.length, (index) {
              return _ItemCell(
                material: controller.fillteredItems[index],
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
      onTap: () =>
          UserProfile.shared.currentUser?.userType == UserType.motivated
              ? Get.to(() => CourseView(
                    material: material,
                  ))
              : Get.dialog(CourseForm(
                  uidCourse: material.uid ?? "",
                )),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  try {
                    launch(material.courseUrl ?? "");
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Container(
                  height: 110.r,
                  width: 110.r,
                  decoration: BoxDecoration(
                    color: const Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Assets.shared.primaryColor,
                    ),
                  ),
                  child: CustomText(
                    text: material.name ?? "", // اسم الدورة
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    textColor: Assets.shared.primaryColor,
                  ),
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
                text: "اسم الكورس",
                fontSize: 12,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
              CustomText(
                text: (material.name?.length ?? 0) > 40
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
                text: "الموقع",
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
                  text: material.platform?.title ?? "",
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
                text: "تقييم المحفزين",
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
