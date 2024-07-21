import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyFormBuilderRadioGroup extends StatelessWidget {
  const MyFormBuilderRadioGroup({
    super.key,
    required this.myController,
    required this.labelTitle,
    required this.name,
    required this.items,
    required String hintTitle,
  });

  final List items;
  final TextEditingController myController;
  final String labelTitle;
  final String name;

  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup(
      name: name,
      orientation: OptionsOrientation.horizontal,
      decoration: InputDecoration(
        labelText: labelTitle,
        border: OutlineInputBorder(),
      ),
      options: [
        for (var item in items)
          FormBuilderFieldOption(
              value: item,
              child: Text(
                item,
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopkSecondrayColor
                    : CustomTextStyle().textStyleTabletkSecondrayColor,
              )),
      ],
    );
  }
}
