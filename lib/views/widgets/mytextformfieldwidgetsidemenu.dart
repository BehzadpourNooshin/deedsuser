import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormFieldSideMenu extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final Icon myicon;
  final TextEditingController myController;
  final TextAlign alignment;
  final TextDirection directionText;
  final bool secureText;
  final bool enable;
  final TextInputType textInputType;

  const MyTextFormFieldSideMenu({
    super.key,
    required this.labelTitle,
    required this.hintTitle,
    this.errorTitle = "",
    this.secureText = false,
    required this.myicon,
    this.alignment = TextAlign.right,
    this.directionText = TextDirection.ltr,
    this.enable = true,
    this.textInputType = TextInputType.name,
    required this.myController,
  });

  // تبدیل اعداد انگلیسی به فارسی برای نمایش
  String convertToPersianNumbers(String input) {
    return input
        .replaceAll('0', '۰')
        .replaceAll('1', '۱')
        .replaceAll('2', '۲')
        .replaceAll('3', '۳')
        .replaceAll('4', '۴')
        .replaceAll('5', '۵')
        .replaceAll('6', '۶')
        .replaceAll('7', '۷')
        .replaceAll('8', '۸')
        .replaceAll('9', '۹');
  }

  @override
  Widget build(BuildContext context) {
    // کنترلری برای تبدیل و نمایش اعداد فارسی بدون تغییر مقدار ذخیره شده
    final displayController = TextEditingController(
      text: convertToPersianNumbers(myController.text),
    );

    myController.addListener(() {
      displayController.value = displayController.value.copyWith(
        text: convertToPersianNumbers(myController.text),
        selection: myController.selection,
      );
    });

    return TextFormField(
      style: Responsive.isDesktop(context)
          ? CustomTextStyle().textStyleDesktopkSecondrayColor
          : CustomTextStyle().textStyleTabletkSecondrayColor,
      textAlign: alignment,
      enabled: enable,
      textDirection: directionText,
      obscureText: secureText,
      controller: displayController,
      keyboardType: textInputType,
      onChanged: (value) {
        // ذخیره مقدار به صورت انگلیسی در myController
        final englishValue = value
            .replaceAll('۰', '0')
            .replaceAll('۱', '1')
            .replaceAll('۲', '2')
            .replaceAll('۳', '3')
            .replaceAll('۴', '4')
            .replaceAll('۵', '5')
            .replaceAll('۶', '6')
            .replaceAll('۷', '7')
            .replaceAll('۸', '8')
            .replaceAll('۹', '9');
        myController.value = myController.value.copyWith(
          text: englishValue,
          selection: TextSelection.collapsed(offset: englishValue.length),
        );
      },
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        prefixIcon: Padding(
          padding: EdgeInsets.all(kDefaultPadding / 2),
          child: myicon,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            top: kDefaultPadding / 4,
            bottom: kDefaultPadding / 4,
          ),
          child: IconButton(
            icon: const Icon(
              size: 20,
              Icons.clear,
              color: kBlackColor,
            ),
            onPressed: () {
              myController.clear();
              displayController.clear();
            },
          ),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        labelText: labelTitle,
        labelStyle: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        hintText: hintTitle,
        hintStyle: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kErrorColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kErrorColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kBlackColor),
        ),
        errorStyle: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopKerrorColor
            : CustomTextStyle().textStyleTabletKerrorColor,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return errorTitle;
        }
        return null;
      },
    );
  }
}
