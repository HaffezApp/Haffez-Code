import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haffez/utils/assets.dart';

import 'custom_text.dart';

customAlertSheet({
  required String title,
  required List<String> items,
  required Function(int, String) onTap,
}) {
  List<Widget> actions = [];

  for (int i = 0; i < items.length; i++) {
    actions.add(
      TextButton(
        onPressed: () {
          onTap(i, items[i]);
          Get.back();
        },
        child: CustomText(
          text: items[i],
          textColor: Colors.black,
        ),
      ),
    );
  }

  actions.add(
    TextButton(
        onPressed: () => Get.back(),
        child: CustomText(
          text: "إلغاء",
          textColor: Assets.shared.secondaryColor,
        )),
  );

  showModalBottomSheet(
    context: Get.context!,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: title,
              textColor: Theme.of(context).primaryColor,
            ),
            Wrap(
              children: actions,
            ),
          ],
        ),
      );
    },
  );
}
