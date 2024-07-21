import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyTextFormFieldPassword extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final Icon myicon;
  final TextEditingController myController;
  final TextAlign alignment;
  final TextDirection directionText;
  final bool secureText;
  final bool enable;
  final int maxLine;

  const MyTextFormFieldPassword(
      {super.key,
      required this.labelTitle,
      required this.hintTitle,
      this.maxLine = 1,
      this.errorTitle = "",
      this.secureText = false,
      this.myicon = const Icon(Icons.account_box),
      this.alignment = TextAlign.left,
      this.directionText = TextDirection.ltr,
      this.enable = true,
      required this.myController});
  @override
  Widget build(BuildContext context) {
    RxBool passwordVisible = false.obs;
    return Obx(() => TextFormField(
        style: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        maxLines: maxLine,
        minLines: 1,
        onChanged: (value) {},
        onSaved: (value) {},
        focusNode: FocusNode(),
        autofocus: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: !passwordVisible.value,
        textAlign: alignment,
        enabled: enable,
        textDirection: directionText,
        controller: myController,
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ],
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(
                top: kDefaultPadding / 4,
                bottom: kDefaultPadding / 4), // add padding to adjust icon
            child: IconButton(
              icon: Icon(
                size: 20,
                passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                color: kBlackColor,
              ),
              onPressed: () {
                passwordVisible.value = !passwordVisible.value;
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
          errorMaxLines: 2,
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
        }));
  }
}
