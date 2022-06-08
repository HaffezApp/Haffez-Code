import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/tracks_view_model.dart';
import 'package:haffez/model/course_model.dart';
import 'package:haffez/model/tracks_model.dart';
import 'package:haffez/view/category_details.dart';
import 'package:haffez/view/notifications.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  final TracksViewModel _controller = Get.put(TracksViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const CustomText(
          text: "المسارات",
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
      body: GetBuilder<TracksViewModel>(
        init: TracksViewModel(),
        initState: (_) {
          _controller.getTracks();
        },
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.items.length, // العداد لكل الاقسام الكبيره
            itemBuilder: (context, index) {
              // هذه لعرض الاقسام الكبيره
              return _SectionCell(
                item: controller.items[index],
              );
            },
          );
        },
      ),
    );
  }
}

class _SectionCell extends StatelessWidget {
  final TrackModel item;

  const _SectionCell({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.r),
          child: CustomText(
            text: item.name ?? "", // اسم القسم الكبير
            textColor: Theme.of(context).primaryColor,
            fontSize: 14,
            alignment: Alignment.centerRight,
          ),
        ),
        SizedBox(
          height: 110.r,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: item.courses?.length, // عداد الكورسات
            itemBuilder: (context, index) {
              // لعرض التخصصات الدقيقة
              return _ItemCell(
                item: item.courses?[index],
              );
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class _ItemCell extends StatelessWidget {
  final CourseModel? item;

  const _ItemCell({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => CategoryDetails(
          // الدورات الي في التخصصات الدقيقه
          course: item,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20.w),
        height: 110.r,
        width: 110.r,
        decoration: BoxDecoration(
          color: const Color(0xfff6f6f6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: CustomText(
          text: item?.name ?? "", // اسم التخصصات الدقيقة
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}