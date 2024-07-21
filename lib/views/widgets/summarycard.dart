import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final Widget value;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double width;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 4.5,
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Stack(
          children: [
            Positioned(
              top: kDefaultPadding * 0.5,
              right: kDefaultPadding * 0.5,
              child: Icon(
                icon,
                size: 80.0,
                color: iconColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: kDefaultPadding * 0.5),
                    child: value,
                  ),
                  Text(title,
                      style: CustomTextStyle()
                          .textStyleDesktopBigTitrKcardColorColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCardInfoReport extends StatelessWidget {
  final String value;
  final String category;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double width;

  const SummaryCardInfoReport({
    super.key,
    required this.value,
    this.category = '',
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: Get.height / 4,
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,

        color: backgroundColor,
        elevation: 4, // Adjust background color opacity
        // Add elevation to enhance the glass effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  overflow: TextOverflow.fade,
                  value,
                  style: textTheme.labelLarge!.copyWith(
                    color: textColor,
                  ),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 20),
                  Padding(
                    padding: EdgeInsets.all(kDefaultPadding * 0.5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.tableList,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                          SizedBox(
                            width: Get.width / 100,
                          ),
                          const Icon(
                            FontAwesomeIcons.solidFilePdf,
                            size: 20,
                            color: kErrorColor,
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(kDefaultPadding * 0.5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.code,
                            size: 20,
                            color: kCyanColor,
                          ),
                          SizedBox(
                            width: Get.width / 100,
                          ),
                          const Icon(
                            FontAwesomeIcons.solidFileExcel,
                            size: 20,
                            color: kSuccessColor,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
