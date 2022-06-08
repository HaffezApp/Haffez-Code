import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_course.dart';
import 'package:haffez/core/view_model/material_view_model.dart';
import 'package:haffez/model/course_model.dart';
import 'package:haffez/model/material_model.dart';
import 'package:haffez/utils/enums/course_platforms.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/notifications.dart';
import 'package:haffez/view/widgets/course_form.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/assets.dart';

class MyTrackView extends StatelessWidget {
  MyTrackView({Key? key}) : super(key: key);

  final MaterialViewModel _controller = Get.put(MaterialViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaterialViewModel>(initState: (_) {
      _controller.viewAllCoursesinPath(
          uid: UserProfile.shared.currentUser?.specialty ?? "");
    }, builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.h,

          iconTheme: const IconThemeData(color: Colors.black),
          title: Column(
            children: [
              FutureBuilder<CourseModel>(
                  future: FirestoreCourses.shared.viewFilterPath(
                      uid: UserProfile.shared.currentUser?.specialty ?? ""),
                  builder: (context, snapshot) {
                    return CustomText(
                      text: snapshot.hasData //name the masar
                          ? snapshot.data?.name ?? ""
                          : "مساري",
                      fontSize: 18,
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(8.r),
                ),

                ///serch
                child: TextFormField(
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
                      color: Colors.black,
                    ),

                    ///////عشان يلف يمين النص
                    suffixIcon: Visibility(
                      visible: false,
                      child: Icon(
                        Icons.search_rounded,
                        size: 16.r,
                        color: const Color(0xff818181),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.searchCourse(keyword: value); //for serachCourse
                  },
                ),
              ),
            ],
          ),

          //notifications
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => Notifications());
              },
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),

        //menu
        drawer: MainDrawer(),

        body: GridView.count(
          padding: EdgeInsets.all(20.r),
          crossAxisCount: 3,
          mainAxisSpacing: 10.r,
          crossAxisSpacing: 10.r,
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
        ),
      );
    });
  }
}

//the cell
class _ItemCell extends StatelessWidget {
  final MaterialModel material;

  const _ItemCell({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.dialog(CourseForm(
        uidCourse: material.uid ?? "",
      )),
      child: Column(
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

              text: material.name ?? "",
              fontWeight: FontWeight.w400,
              textColor: Assets.shared.primaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              const CustomText(
                text: " اسم الكورس :",
                fontSize: 12,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
              CustomText(
                text: (material.name?.length ?? 0) > 30
                    ? ((material.name?.substring(0, 19) ?? "") + "...")
                    : material.name ?? "",
                // ignore: prefer_const_constructors
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
                text: "الموقع:",
                // textColor: Colors.black,
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
                  // ignore: prefer_const_constructors
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
                text: " تقييم المتحفزين :",
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
                itemCount: 5,
                itemSize: 14.r,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0.r),
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