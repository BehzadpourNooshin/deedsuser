import 'dart:math';

import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:deedsuser/utils/extensions.dart';
import 'package:get/get.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final Color? kDarktBlueColor;
  final Color? kInfoColor;
  final bool showDivider;
  final EdgeInsets padding;

  CardHeader({
    super.key,
    required this.title,
    this.kDarktBlueColor,
    this.kInfoColor,
    this.padding = const EdgeInsets.all(16),
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: kInfoColor,
      child: SizedBox(
        width: Get.width / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padding,
              child: Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kInfoColor,
                      fontSize: ScreenSize(context).screenWidth <= 1000
                          ? 16
                          : ScreenSize(context).screenWidth * 0.012),
                ),
              ),
            ),
            Visibility(
              visible: showDivider,
              child: const Divider(
                color: kLightBlueColor,
                height: 1.0,
                thickness: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color? kSecondaryColor;
  CardBody({
    super.key,
    required this.child,
    this.kSecondaryColor,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSecondaryColor,
      elevation: 5,
      child: SizedBox(
        width: Get.width / 3,
        child: Padding(
          padding: padding,
          child: Expanded(
            child: child,
          ),
        ),
      ),
    );
  }
}

class FullCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  //final Color? kDarktBlueColor;
  final String title;
//  final Color? kScreenBackgroundColor;
  final Color? kInfoColor;
  final bool showDivider;

  const FullCard({
    super.key,
    required this.child,
    // this.kDarktBlueColor,
    this.padding = const EdgeInsets.all(16),
    required this.title,
    // this.kScreenBackgroundColor,
    this.kInfoColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      color: kCardColor,
      elevation: 1,
      child: SizedBox(
        width: max(Get.width / 4, 300),
        // height: Get.height / 2,
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: kDefaultPadding,
                        left: kDefaultPadding,
                        right: kDefaultPadding),
                    child: Image.asset(
                      'assets/images/Icon-50.png',
                      //  height: 80.0,
                    ),
                  ),
                  //        SizedBox(height: Get.height / 12),
                  Padding(
                    padding: padding,
                    child: Text(title,
                        style: Responsive.isDesktop(context)
                            ? CustomTextStyle()
                                .textStyleDesktopBigTitrKprimaryColor
                            : CustomTextStyle()
                                .textStyleTabletKprimaryColorTitr),
                  ),
                  Visibility(
                    visible: showDivider,
                    child: const Divider(
                      //    color: kLightBlueColor,
                      height: 0.5,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: padding,

                child: child,
                //  SizedBox(height: Get.height / 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
