
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/utils/enums/user_type.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: UserProfile.shared.currentUser?.userType ==
                          UserType.motivated ? motivatedRating : motivatorRating,
        
        );
  }
}

Widget get motivatedRating {
    return Center(
        child: Container(
            padding: EdgeInsets.all(20.r),
            width: 300.w,
            height: 250.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "كيف كان الكورس؟"),
                SizedBox(
                  height: 15.h,
                ),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(
                  height: 15.h,
                ),
                const CustomText(text: "كيف كان المحفز معاك؟"),
                SizedBox(
                  height: 15.h,
                ),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 20.r,
                            vertical: 10.r,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xffF8F8F8),
                        ),
                      ),
                      child: const CustomText(
                        text: "أرسل",
                        textColor: Color(0xff3DA18D),
                      ),
                    ),
                  ],
                ),
              ],
            ))));
  }


Widget get  motivatorRating{
    return Center(
        child: Container(
            padding: EdgeInsets.all(20.r),
            width: 300.w,
            height: 170.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "كيف كان المتحفز معك؟",
                ),
                SizedBox(
                  height: 15.h,
                ),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 20.r,
                            vertical: 10.r,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xffF8F8F8),
                        ),
                      ),
                      child: const CustomText(
                        text: "أرسل",
                        textColor: Color(0xff3DA18D),
                      ),
                    ),
                  ],
                ),
              ],
            ))));
  }
