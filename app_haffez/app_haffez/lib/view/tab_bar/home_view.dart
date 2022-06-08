import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/utils/enums/course_platforms.dart';
import 'package:haffez/view/notifications.dart';
import 'package:haffez/view/platfom_courses.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';
import '../../core/view_model/home_view_model.dart';
import '../../utils/assets.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final List<CoursePlatforms> coursePlatforms = [
    CoursePlatforms.udemy,
    CoursePlatforms.satr,
    CoursePlatforms.edraak,
    CoursePlatforms.coursat,
    CoursePlatforms.coursera,
    CoursePlatforms.m3aarf,
    CoursePlatforms.skillShare,
  ];
  final List ranking = [
    Assets.shared.ic1,
    Assets.shared.ic2,
    Assets.shared.ic3,
    Assets.shared.ic4,
    Assets.shared.ic5,
  ];
  final HomeViewModel _controller = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const CustomText(
            text: "الصفحة الرئيسية",
            fontSize: 18,
          ),
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
        drawer: MainDrawer(),
        body: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: GetBuilder<HomeViewModel>(
                    init: HomeViewModel(),
                    initState: (_) {
                      _controller.getUsers();
                    },
                    builder: (controller) {
                      return Column(children: [
                        Padding(
                          padding: EdgeInsets.all(12.r),
                          child: const CustomText(
                            text: "المنصات اللي موفرينها لكم",
                            alignment: Alignment.centerRight,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 140.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffE6F1F3).withOpacity(0.5),
                            // borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.all(15.r),
                            scrollDirection: Axis.horizontal,
                            itemCount: coursePlatforms.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.to(PlatformCoursesView(
                                  platformIndex: coursePlatforms[index].index,
                                  platformName: coursePlatforms[index].title,
                                )),
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.r),
                                  width: 120.w,
                                  height: 120.h,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffE6F1F3)),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Image.asset(
                                    coursePlatforms[index].image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.r),
                          child: const CustomText(
                            text: "أبطالنا المحفزين الأعلى تقييمًا ",
                            alignment: Alignment.centerRight,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffE6F1F3).withOpacity(0.5),
                            // borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: ListView.builder(
                                padding: EdgeInsets.all(20.r),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.motivators.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.r),
                                    child: Column(
                                      children: [
                                        Stack(
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Assets
                                                      .shared.primaryColor
                                                      .withOpacity(0.3),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.r),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 36.r,
                                                  ),
                                                ),
                                              ),
                                              Image.asset(
                                                ranking[index],
                                                fit: BoxFit.contain,
                                                width: 25.r,
                                              )
                                            ]),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        CustomText(
                                          text:
                                              "${controller.motivators[index].name}",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 15.r,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1.0.r),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                  );
                                })
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.r),
                          child: const CustomText(
                            text: "أبطالنا المتحفزين الأعلى تقييمًا ",
                            alignment: Alignment.centerRight,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            height: 150.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffE6F1F3).withOpacity(0.5),
                              // borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: ListView.builder(
                                padding: EdgeInsets.all(20.r),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.motivateds.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.r),
                                    child: Column(
                                      children: [
                                        Stack(
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Assets
                                                      .shared.primaryColor
                                                      .withOpacity(0.3),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.r),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 36.r,
                                                  ),
                                                ),
                                              ),
                                              Image.asset(
                                                ranking[index],
                                                fit: BoxFit.contain,
                                                width: 25.r,
                                              )
                                            ]),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        CustomText(
                                          text:
                                              "${controller.motivateds[index].name}",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 15.r,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1.0.r),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                  );
                                })
                                )
                      ]);
                    }))));
  }
}
