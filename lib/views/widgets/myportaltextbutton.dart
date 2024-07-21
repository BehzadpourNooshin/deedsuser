import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';

class MyTextButtonPoratl extends StatelessWidget {
  const MyTextButtonPoratl({
    super.key,
    required this.myicon,
    this.name = '',
    required this.function,
  });

  final String name;
  final Icon myicon;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: Styles().sideBarStyleButton,
        onPressed: function,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            name,
            style: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopkCardColorSideMenu
                : CustomTextStyle().textStyleTabletkCardColorSideMenu,
          ),
          const SizedBox(
            width: 10,
          ),
          myicon
        ]));
  }
}
