import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyFormBuilderSwitch extends StatelessWidget {
  final String labelTitle;
  final String myName;
  final TextEditingController myController;
  const MyFormBuilderSwitch(
      {super.key,
      required this.labelTitle,
      required this.myName,
      required this.myController});
  @override
  Widget build(BuildContext context) {
    return FormBuilderSwitch(
      activeColor: kswitchColor,
      onChanged: (value) {
        myController.text = value.toString();
      },
      name: myName,
      decoration: InputDecoration(
        labelText: labelTitle,
        labelStyle: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        hoverColor: kHoverColor,
        focusColor: kFocusColor,
      ),
      title: Text(
        '',
        style: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
      ),
    );
  }
}
