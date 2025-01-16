import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:deedsuser/controllers/uuid_controller.dart';

class MyTextFormFieldAutomate extends StatelessWidget {
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

  MyTextFormFieldAutomate({
    super.key,
    required this.labelTitle,
    required this.hintTitle,
    this.errorTitle = "",
    this.secureText = false,
    required this.myicon,
    this.alignment = TextAlign.end,
    this.directionText = TextDirection.rtl,
    this.enable = true,
    this.textInputType = TextInputType.name,
    required this.myController,
  }) {
    // ایجاد و مقداردهی کنترلر UUID
    final uuidController = Get.put(UUIDController());
    myController.text = uuidController.getUUID();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        textAlign: alignment,
        enabled: enable,
        textDirection: directionText,
        controller: myController,
        keyboardType: textInputType,
        obscureText: secureText,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          prefixIcon: Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: myicon,
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
            return (errorTitle);
          }
          return null;
        });
  }
}
