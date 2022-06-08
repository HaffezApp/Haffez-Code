import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

//  الصفحة الرئيسية للمناقشات لمن اضغط على اول سؤال تنفتح صفحة اشوف فيها الردود
class DiscussionDetailsView extends StatelessWidget {
  const DiscussionDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFF4),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "المناقشات",
          style: TextStyle(
            color: Colors.black,
            fontWeight:
                FontWeight.w400, // w400 > هي لسته ثابته من 100 -900 اختار منها
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, 
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.r,
          vertical: 12.r,
        ),
        height: 60.h, // ارتفاع كونتينر اكتب ردك
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          decoration: BoxDecoration(
            color: const Color(0xffEFEFF4),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: const Color(0xffE8E8E8),
            ),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "اكتب ردك ...",
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            margin: EdgeInsets.symmetric(vertical: 5.h),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 3),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Icon(
                          Icons.person_outline,
                          color: Theme.of(context).primaryColor,
                          size: 32.r, // حجم ايقونة الشخص
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "محمد",
                          alignment: Alignment.centerRight,
                          textAlign: TextAlign.right,
                          fontSize: 16,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        const CustomText(
                          text: "ماهي أنواع الداتا في الجافا",
                          alignment: Alignment.centerRight,
                          textAlign: TextAlign.right,
                          fontSize: 14,
                          textColor: Colors.black54,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: const [
                        CustomText(
                          text: "أسبوع",
                          textColor: Colors.black54,
                          fontSize: 12,
                        ),
                        Icon(
                          Icons.keyboard_arrow_left_outlined,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const CustomText(
                      text: "برمجة التطبيقات",
                      textColor: Colors.grey,
                      fontSize: 10,
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: const CustomText(
              text: "الردود",
              alignment: Alignment.centerRight,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const _ItemCell();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  const _ItemCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                    size: 32.r,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "محمد",
                    alignment: Alignment.centerRight,
                    textAlign: TextAlign.right,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  const CustomText(
                    text: "ماهي أنواع الداتا في الجافا",
                    alignment: Alignment.centerRight,
                    textAlign: TextAlign.right,
                    fontSize: 14,
                    textColor: Colors.black54,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: const [
                  CustomText(
                    text: "أسبوع",
                    textColor: Colors.black54,
                    fontSize: 12,
                  ),
                  Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.black54,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              const CustomText(
                text: "برمجة التطبيقات",
                textColor: Colors.grey,
                fontSize: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}