import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/training_course.dart';
import 'package:haffez/model/training_course.dart';

import 'custom_text.dart';

class CourseForm extends StatelessWidget {
  final String? uidCourse; //matiral uid
  // ignore: non_constant_identifier_names
  final TrainingCourse? DataFormcourse;

  CourseForm({
    Key? key,
    this.uidCourse,
    // ignore: non_constant_identifier_names
    this.DataFormcourse,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.r),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 500.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Scaffold(
          body: GetBuilder<TrainingCourseViewModel>(
            init: TrainingCourseViewModel(),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),

                        //1)النبذه
                        TextFormField(
                          initialValue: DataFormcourse?.details ?? "",
                          textInputAction: TextInputAction.next,
                          onSaved: (value) => controller.details = value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "عطنا نبذة عنك ...",
                            labelText: "نبذة عنك؟",
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        //2) تحديد التاريخ
                        TextFormField(
                          controller: TextEditingController(
                            text: controller.dateStart == null
                                ? DataFormcourse?.startDate?.substring(0, 10) ??
                                    ""
                                : formatDate(
                                    controller.dateStart ?? DateTime.now(),
                                    [yyyy, '-', mm, '-', dd]),
                          ),
                          onSaved: (value) {
                            if (value != null || value != "") {
                              controller.dateStart = DateTime.parse(
                                  value ?? DateTime.now().toString());
                            }
                          },
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          onTap: controller.selectDateStart, //method1
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "تاريخ البدء",
                            labelText: "تاريخ البدء",
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        //3) عدد الاعضاء
                        DropdownButtonFormField(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: DataFormcourse?.groupCount,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "عدد أعضاء القروب",
                            labelText: "عدد أعضاء القروب",
                          ),
                          items: [
                            5,
                            10,
                            15,
                            20,
                          ].map((int item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text("1 - $item"),
                            );
                          }).toList(),
                          onSaved: (int? value) {
                            controller.memberCount = value;
                          },
                          onChanged: (_) {},
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        //4) رابط القروب
                        TextFormField(
                          initialValue: DataFormcourse?.groupUrl ?? "",
                          onSaved: (value) => controller.urlGroup = value,
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "https://web.telegram.org/",
                            labelText: "رابط القروب",
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        //5) الموافقة
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: ":ملاحظة",
                              fontSize: 12,
                              alignment: Alignment.centerRight,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Flexible(
                                  child: CustomText(
                                    text:
                                        " اذا عبيت الفورم هذا راح تنضاف لك الدورة وما تقدر تحذفها بعدين, حط الصح اذا ما عندك مشكلة",
                                    fontSize: 12,
                                    alignment: Alignment.centerRight,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Checkbox(
                                  value: controller.isAccept ?? false,
                                  onChanged: (value) =>
                                      controller.changeAcceptValue(
                                    //method2
                                    value: value ?? false,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 30.h,

                        ////////////////////////////زر الحفظ
                        child: ElevatedButton(
                          onPressed: () {
                            _formKey.currentState?.save();
                            //save for form
                            controller.courseUid = uidCourse;

                            if (DataFormcourse == null) {
                              controller.addCourse(); //method3
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.r),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xfff8f8f8),
                            ),
                          ),
                          child: CustomText(
                            text: "حفظ",
                            textColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
