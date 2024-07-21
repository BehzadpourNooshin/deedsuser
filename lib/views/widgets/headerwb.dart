import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';

class HeaderWB extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: kCardColor),
        backgroundColor: kPrimaryColor,
        title: Row(children: [
          const SizedBox(width: 20),
          Text(HeaderConstantText().subtitle,
              style: Responsive.isDesktop(context)
                  ? CustomTextStyle().textStyleDesktopBigTitrKcardColorColor
                  : CustomTextStyle().textStyleDesktopBigTitrKcardColorColor),
        ]),
        actions: [
          Text(HeaderConstantText().title,
              style: Responsive.isDesktop(context)
                  ? CustomTextStyle().textStyleDesktopBigTitrKcardColorColor
                  : CustomTextStyle().textStyleDesktopBigTitrKcardColorColor),
          const SizedBox(width: 15),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
