import 'dart:math';

import 'package:deedsuser/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100 &&
      MediaQuery.of(context).size.height >= 400;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}

class FontSize {
  double fontSizeBigTitrDesktop = 16;
  double fontSizeMiddleTitrDesktop = 14;
  double fontSizeDesktop = 13;
  double fontSizeTablet = 12;
  double fontSizeMobile = 11;
}

class CustomTextStyle {
  TextStyle textStyleDesktopCourierKprimaryColor = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');

  TextStyle textStyleDesktopCouriersuccessColor = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');

  TextStyle textStyleDesktopCourierKerrorColor = TextStyle(
      height: 0.1,
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');
  TextStyle textStyleDesktopCourierkCardColorSideMenu = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeDesktop + 2,
      fontFamily: 'Courier');
  TextStyle textStyleTabletCourierkCardColorSideMenu = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeTablet + 2,
      fontFamily: 'Courier');
  TextStyle textStyleDesktopCourierkCardColor = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');

  TextStyle textStyleDesktopCourierkSecondrayColor = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');

  TextStyle textStyleDesktopCourierkBlackColor = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');

  TextStyle textStyleTabletCouriersuccessColor = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');

  TextStyle textStyleTabletCourierKerrorColor = TextStyle(
      height: 0.1,
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');
  TextStyle textStyleTabletCourierKprimaryColor = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'Courier');
  TextStyle textStyleTabletCourierkCardColor = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'Courier');

  TextStyle textStyleTabletCourierkSecondrayColor = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'Courier');

  TextStyle textStyleTabletCourierkBlackColor = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'Courier');

  TextStyle textStyleMobileCouriersuccessColor = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');
  TextStyle textStyleMobileCourierKprimaryColor = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'Courier');

  TextStyle textStyleMobileCourierKerrorColor = TextStyle(
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'Courier');
  TextStyle textStyleMobileCourierkCardColor = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'Courier');

  TextStyle textStyleMobileCourierkSecondrayColor = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'Courier');

  TextStyle textStyleMobileCourierkBlackColor = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'Courier');

  TextStyle textStyleDesktopKprimaryColorTitrdrop = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeMiddleTitrDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopKprimaryColorTitr = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeMiddleTitrDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopKprimaryColor = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopBigTitrKcardColorColor = TextStyle(
      color: kCardColor,
      locale: const Locale('fa'),
      fontSize: FontSize().fontSizeBigTitrDesktop,
      fontFamily: 'YekanBakhFaNumVF');
  TextStyle textStyleDesktopBigTitrKprimaryColor = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeBigTitrDesktop,
      wordSpacing: 10,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopBigTitrKblackcolor = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeBigTitrDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopKsuccessColorTitr = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopsuccessColor = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopKerrorColorTitr = TextStyle(
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopKerrorColor = TextStyle(
      height: 0.1,
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopkCardColorSideMenu = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletkCardColorSideMenu = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopkCardColor = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopkCardColorTitr = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopkSecondrayColorTitr = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopkSecondrayColor = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopkBlackColorTitr = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleDesktopkBlackColor = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletKprimaryColorTitr = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeTablet,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletKsuccessColorTitr = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletsuccessColor = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletKerrorColorTitr = TextStyle(
      height: 0.1,
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletKerrorColor = TextStyle(
      height: 0.1,
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletKprimaryColor = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletkCardColor = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletkCardColorTitr = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeTablet,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletkSecondrayColorTitr = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeTablet,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletkSecondrayColor = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletkBlackColorTitr = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeTablet,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleTabletkBlackColor = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeTablet,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobileKprimaryColorTitr = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeMobile,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobileKsuccessColorTitr = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobilesuccessColor = TextStyle(
      color: kSuccessColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobileKprimaryColor = TextStyle(
      color: kPrimaryColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobileKerrorColorTitr = TextStyle(
      height: 0.1,
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobileKerrorColor = TextStyle(
      color: kErrorColor,
      fontSize: FontSize().fontSizeDesktop,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobilekCardColor = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobilekCardColorTitr = TextStyle(
      color: kCardColor,
      fontSize: FontSize().fontSizeMobile,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobilekSecondrayColorTitr = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeMobile,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobilekSecondrayColor = TextStyle(
      color: kSecondaryColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobilekBlackColorTitr = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeMobile,
      fontWeight: FontWeight.bold,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
  TextStyle textStyleMobilekBlackColor = TextStyle(
      color: kBlackColor,
      fontSize: FontSize().fontSizeMobile,
      fontFamily: 'YekanBakhFaNumVF',
      locale: const Locale('fa'));
}

class ResponsiveSizedBox {
  double largeDistanceWidgetHeight = Get.height / 8;
  double middleDistanceWidgetHeight = Get.height / 20;
  double smallDistanceWidgetHeight = Get.height / 25;
  double smallDistanceWidgetwidth = Get.width / 40;
  double middleDistanceWidgetwidth = Get.width / 15;
  double middleDistancePopupWidgetwidth = Get.width / 11;
  double largeDistanceWidgetwidth = Get.width / 5;
  double middleSizeBoxWidth = max(Get.width / 10, 300);
  double middleSizeBoxHeight = Get.height / 17;
  double largSizeBoxWidth = Get.width / 1.5;
  double largSizeBoxHeight = Get.height / 2;
}

class ResponsivePadding {
  double largePaddingHeight = Get.height / 8;
  double largePaddingWidth = Get.height / 4;
}

class ResponsiveSideBody {
  double margin = Get.width / 20;
  double radius = Get.width / 10;
  double sizeBodyNotCollapsed = Get.width / 1.2;
  double sizeBodyCollapsed = Get.width / 1.3;
  double sizeSideNotCollapsed = Get.width - Get.width / 1.2;
  double sizeSideBodyCollapsed = Get.width - Get.width / 1.3;
}
