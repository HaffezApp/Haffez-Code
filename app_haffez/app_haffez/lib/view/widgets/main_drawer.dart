import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/auth.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/utils/enums/drawer_tabs.dart';
import 'package:haffez/utils/enums/gender.dart';
import 'package:haffez/utils/enums/user_type.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);

  final List<DrawerTabs> _items = [
    DrawerTabs.home,
    DrawerTabs.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.white,
      child: Column(
        children: [
          GetBuilder<AuthViewModel>(
              init: AuthViewModel(),
              builder: (_) {
                return Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Image.asset(
                        UserProfile.shared.currentUser?.gender?.icon ?? "",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomText(
                        text: UserProfile.shared.currentUser?.name ?? "",
                        textColor: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: CustomText(
                              text: UserProfile.shared.currentUser?.userType ==
                                      UserType.motivator
                                  ? "عدد الكورسات اللي أشرفت عليها: "
                                  : "عدد الكورسات اللي أنجزتها يا بطل:",
                              textColor: Theme.of(context).primaryColor,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          CustomText(
                            ///عدد الكورسات
                            text: UserProfile.shared.currentUser?.userType ==
                                    UserType.motivator
                                ? (UserProfile.shared.currentUser
                                            ?.coursesSupervisedCount ??
                                        0)
                                    .toString()
                                : (UserProfile.shared.currentUser
                                            ?.coursesFinishedCount ??
                                        0)
                                    .toString(),
                            textColor: Assets.shared.secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
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
                        itemSize: 20.r,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.r),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (_) {},
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                );
              }),
          Divider(height: 1.r, thickness: 0.5.r),
          SizedBox(
            height: _items.length * 40.h,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(20.r),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _ItemCell(
                    item: _items[index],
                  );
                }),
          ),
          SizedBox(
            height: _items.length * 40.h,
            child: Divider(height: 1.r, thickness: 0.5.r),
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              Get.put(AuthViewModel()).signOut();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.r,
                vertical: 40.r,
              ),
              child: Row(
                children: [
                  const Icon(Icons.logout),
                  SizedBox(
                    width: 12.w,
                  ),
                  CustomText(
                    text: "تسجيل الخروج",
                    fontSize: 14,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  final DrawerTabs item;

  const _ItemCell({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => item.action(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(item.icon),
                SizedBox(
                  width: 12.w,
                ),
                CustomText(
                  text: item.title,
                  fontSize: 14,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
