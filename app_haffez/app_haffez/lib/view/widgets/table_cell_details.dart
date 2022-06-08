import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/schedule_view.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class TableCellDetails extends StatelessWidget {
  final int index;
  final String? value;

  TableCellDetails({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = value ?? "";
    return Center(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.text = "";
                  Get.put(ScheduleViewModel())
                      .addOrEditCellInSchedule(index: index, value: "");
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_forever_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 32.r,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    const CustomText(
                      text: "فرغ لي الخانة",
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: const [
                  CustomText(
                    text: "اسم الدورة :",
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5.r, 0, 5.r, 0.r),
                height: 40.h,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffe8e8e8)),
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 30.h,
                    child: ElevatedButton(
                      onPressed: () {
                        String value = _controller.text.trim();
                        if (value == "") {
                          Get.customSnackbar(
                            title: "خطأ",
                            message: "يرجي ادخال قيمة قبل الضغط على زر الحفظ",
                            isError: true,
                          );
                          return;
                        }
                        Get.put(ScheduleViewModel()).addOrEditCellInSchedule(
                            index: index, value: value);

                        Get.back();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xfff8f8f8)),
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
          ),
        ),
      ),
    );
  }
}
