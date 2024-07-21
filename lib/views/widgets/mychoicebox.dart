import 'package:deedsuser/utils/constant.dart';

import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MyChoiceBox extends StatelessWidget {
  final String labelTitle;
  final String nameCheckBox;
  final String hintTitle;
  final String errorTitle;

  final TextEditingController myController;
  final List myItems;

  MyChoiceBox(
      {super.key,
      required this.labelTitle,
      required this.nameCheckBox,
      required this.hintTitle,
      this.errorTitle = "",
      this.myItems = const [],
      required this.myController});
  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      decoration: InputDecoration(
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
      name: nameCheckBox,
      initialValue: false,
      onChanged: (value) {
        myController.text = value.toString();
      },
      title: RichText(
        text: TextSpan(
          children: [
            for (var item in myItems) ...[
              TextSpan(
                text: item,
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopkSecondrayColor
                    : CustomTextStyle().textStyleTabletkSecondrayColor,
              )
            ]
          ],
        ),
      ),
      validator: FormBuilderValidators.equal(
        true,
        errorText: errorTitle,
      ),
    );
  }
}
