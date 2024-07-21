import 'package:deedsuser/controllers/accounts_controller.dart';
import 'package:deedsuser/utils/constant.dart';

import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyTextFormFieldFirstName extends StatelessWidget {
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

  const MyTextFormFieldFirstName(
      {super.key,
      required this.labelTitle,
      required this.hintTitle,
      this.errorTitle = "",
      this.secureText = false,
      required this.myicon,
      this.alignment = TextAlign.end,
      this.directionText = TextDirection.rtl,
      this.enable = true,
      this.textInputType = TextInputType.name,
      required this.myController});
  @override
  Widget build(BuildContext context) {
    AccountsController accountsController = Get.put(AccountsController());

    return TextFormField(
        style: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        onChanged: (value) {
          accountsController.firstnameobs.value = value;
          accountsController.update();
          accountsController.validationAccount();
        },
        onSaved: (value) {},
        focusNode: FocusNode(),
        autofocus: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: secureText,
        textAlign: alignment,
        enabled: enable,
        textDirection: directionText,
        controller: myController,
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ],
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          prefixIcon: Padding(
            padding: EdgeInsets.all(
                kDefaultPadding / 2), // add padding to adjust icon
            child: myicon,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(
                top: kDefaultPadding / 4,
                bottom: kDefaultPadding / 4), // add padding to adjust icon
            child: IconButton(
              icon: const Icon(
                size: 20,
                Icons.clear,
                color: kBlackColor,
              ),
              onPressed: () {
                accountsController.firstnameobs.value = '';
                accountsController.firstname.text = '';
                accountsController.update();
                accountsController.validationAccount();
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
            //  borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kErrorColor),
            //   borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            //   borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kBlackColor),
            // borderRadius: BorderRadius.circular(15.0),
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
