import 'package:deedsuser/controllers/personalsetting_controller.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyTextFormFilterFieldSearchReport extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final Icon myicon;

  final TextAlign alignment;
  final TextDirection directionText;
  final bool secureText;
  final bool enable;
  final int maxLine;
  late bool validate;

  MyTextFormFilterFieldSearchReport({
    super.key,
    required this.labelTitle,
    required this.hintTitle,
    this.maxLine = 1,
    this.validate = true,
    this.errorTitle = "",
    this.secureText = false,
    this.myicon = const Icon(Icons.search),
    this.alignment = TextAlign.end,
    this.directionText = TextDirection.rtl,
    this.enable = true,
  });
  @override
  Widget build(BuildContext context) {
    PersonalSettingController personalSettingController =
        Get.find<PersonalSettingController>();
    return TextFormField(
      style: Responsive.isDesktop(context)
          ? CustomTextStyle().textStyleDesktopkSecondrayColor
          : CustomTextStyle().textStyleTabletkSecondrayColor,
      maxLines: maxLine,
      minLines: 1,
      onChanged: (String? searchValue) async {
        personalSettingController.searchrep.value = searchValue!;
        await personalSettingController
            .filterAccountsRep(personalSettingController.searchrep.value);
      },
      onSaved: (value) {},
      focusNode: FocusNode(),
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: secureText,
      textAlign: alignment,
      enabled: enable,
      textDirection: directionText,
      keyboardType: TextInputType.name,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter
      ],
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding:
              EdgeInsets.all(kDefaultPadding), // add padding to adjust icon
          child: myicon,
        ),
        errorText: validate ? null : errorTitle,
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
    );
  }
}
