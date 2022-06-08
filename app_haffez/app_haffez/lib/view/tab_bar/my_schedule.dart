import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/schedule_view.dart';
import 'package:haffez/view/notifications.dart';
import 'package:haffez/view/widgets/custom_text.dart';
import 'package:haffez/view/widgets/main_drawer.dart';
import 'package:haffez/view/widgets/table_cell_details.dart';

class MyScheduleView extends StatelessWidget {
  MyScheduleView({Key? key}) : super(key: key);

  final List<List<String>> _times = [
    [],
    ["6:00", "8:00"],
    ["8:00", "10:00"],
    ["10:00", "12:00"],
    ["12:00", "2:00"],
    ["2:00", "4:00"],
    ["4:00", "6:00"],
  ];

  final List<String> _days = [
    "",
    "الأحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
  ];

  final ScheduleViewModel _controller = Get.put(ScheduleViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const CustomText(
          text: "جدولي",
          fontSize: 18,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => Notifications()),
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: GetBuilder<ScheduleViewModel>(
                  init: ScheduleViewModel(),
                  initState: (_) {
                    _controller.getSchedule();
                  },
                  builder: (controller) {
                    return GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 6,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.h,
                      children: List.generate(42, (index) {
                        if (index % 6 == 0) {
                          return _HeaderTable(
                            index: index ~/ 6,
                            times: _times[index ~/ 6],
                          );
                        }

                        return InkWell(
                          onTap: () {
                            if (index > 6) {
                              Get.to(
                                TableCellDetails(
                                  index: index,
                                  value: controller.data["$index"], //القيمة
                                ),
                              );
                            }
                          },
                          child: _BodyTable(
                            value: index < 6
                                ? _days[index]
                                : controller.data["$index"],
                          ),
                        );
                      }),
                    );
                  }),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: _controller.emptyTable,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color(0xffFF0000).withOpacity(0.55)),
                    ),
                    child: const CustomText(
                      text: "تفريغ",
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderTable extends StatelessWidget {
  final int index;

  final List<String> times;

  const _HeaderTable({
    Key? key,
    required this.index,
    required this.times,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      width: 54.r,
      height: 65.r,
      decoration: BoxDecoration(
        color: index != 0 ? Colors.white : const Color(0xffF6F6F6),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xffF6F6F6)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: index == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "من",
                    fontSize: 12,
                  ),
                  Container(
                    height: 0.5.h,
                    color: const Color(0xffE8E8E8),
                  ),
                  const CustomText(
                    text: "الى",
                    fontSize: 12,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: index.toString(),
                    fontSize: 12,
                  ),
                  CustomText(
                    text: times[0],
                    fontSize: 12,
                  ),
                  CustomText(
                    text: times[1],
                    fontSize: 12,
                  ),
                ],
              ),
      ),
    );
  }
}

class _BodyTable extends StatelessWidget {
  final String? value;

  const _BodyTable({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      width: 54.r,
      height: 65.r,
      decoration: BoxDecoration(
        color: const Color(0xffF6F6F6),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xffF6F6F6)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Center(
          child: CustomText(
            text: value ?? "",
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
