import 'package:deedsuser/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:deedsuser/utils/extensions.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: kCardColor),
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: kDefaultPadding / 5, top: kDefaultPadding / 5),
            child: Image.asset(
              color: kCardColor,
              'assets/images/app-logo-32.png',
            ),
          ),
          const SizedBox(width: 20),
          Text(HeaderConstantText().title,
              style: TextStyle(
                  color: kLightGreyColor,
                  fontSize: ScreenSize(context).screenWidth <= 1000
                      ? 14
                      : ScreenSize(context).screenWidth * 0.012)),
          SizedBox(width: ScreenSize(context).screenWidth / 2),
          Text(HeaderConstantText().subtitle,
              style: TextStyle(
                  color: kLightGreyColor,
                  fontSize: ScreenSize(context).screenWidth <= 1000
                      ? 16
                      : ScreenSize(context).screenWidth * 0.012)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
