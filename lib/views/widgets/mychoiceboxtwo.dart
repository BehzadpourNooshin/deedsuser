import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MyChoiceBox2 extends StatelessWidget {
  final String labelTitle;
  final String nameCheckBox;
  final String hintTitle;
  final String errorTitle;
  final TextEditingController myController;
  final List myItems;
  final bool initialValue;

  MyChoiceBox2(
      {super.key,
      required this.labelTitle,
      required this.nameCheckBox,
      required this.hintTitle,
      this.errorTitle = "",
      required this.initialValue,
      this.myItems = const [],
      required this.myController});
  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
        name: nameCheckBox,
        initialValue: initialValue,
        onChanged: (value) {
          myController.text = value.toString();
        },
        title: Text(
          labelTitle,
          style: Responsive.isDesktop(context)
              ? CustomTextStyle().textStyleDesktopkSecondrayColor
              : CustomTextStyle().textStyleTabletkSecondrayColor,
          textAlign: TextAlign.right,
        ),
        validator: FormBuilderValidators.equal(
          true,
          errorText: errorTitle,
        ));
  }
}
